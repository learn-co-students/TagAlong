import UIKit

/// Represents the current UI state of a |SplitPaneViewController|.
enum State {
  /// The UI is being displayed fullscreen, only one view controller will be onscreen at a time.
  case FullScreen
  /// The UI is being displayed in a fullscreen split. One or two controllers will be visible at a
  /// time.
  case SplitScreen
  /// The UI is being displayed in a split inset from the screen. One or two controllers will be
  /// visible at a time and background view will likely be visible around them. Note, this state
  /// can only occur when nested in a |InsetViewController|.
  case CenteredSplitScreen
}

/// A container view controller which displays up to two view controllers in a navigation controller
/// style manner when there is not enough screen space to display them side-by-side.
class SplitPaneViewController: BaseContainerViewController {
  // MARK: - Properties
  private let leftController: UIViewController
  private var rightController: UIViewController?
  private let wrapperView = UIView()
  private let shadowView = ShadowView()

  init(rootViewController: UIViewController) {
    self.leftController = rootViewController
    super.init(nibName: nil, bundle: nil)
  }

  // MARK: - Init/Deinit

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    updatePreferredContentSize()

    // Configure the shadow view at the bottom of the view hierarchy.
    view.addSubview(shadowView)
    shadowView.shadowRadius = 3
    shadowView.shadowOpacity = 0.4
    shadowView.cornerRadius = 3
    shadowView.shadowOffset = CGSize(width: 1.5, height: 1.5)

    // Then add the wrapper view.
    view.addSubview(wrapperView)
    wrapperView.layer.cornerRadius = 3

    // And the root controller.
    startAdd(leftController)
    wrapperView.addSubview(leftController.view)
    endAdd(leftController)
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    transitionToState(state, animated: false) {}
  }

  @available(iOS 8.0, *)
  /// Listen to size changes and trigger the appropriate animations.
  override func viewWillTransitionToSize(size: CGSize,
    withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
      transitionToState(state, overrideSize: size, withTransitionCoordinator: coordinator) {}

      super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
  }

  /// Only needed for iOS 7 support.
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    guard #available(iOS 8.0, *) else {
      transitionToState(state, overrideSize: view.bounds.size) {}
      return
    }
  }

  /// Pass through to the child view controller for status bar appearance.
  override func childViewControllerForStatusBarStyle() -> UIViewController? {
    return leftController
  }

  /// Pass through to the child view controller for status bar appearance.
  override func childViewControllerForStatusBarHidden() -> UIViewController? {
    return leftController
  }

  /// Listen to changes in the preferred content size of our children.
  override func preferredContentSizeDidChangeForChildContentContainer(
    container: UIContentContainer) {
    updatePreferredContentSize()
  }

  /// When called, calculates the new preferred content size for this view controller.
  private func updatePreferredContentSize() {
    let childPreferred = self.leftController.preferredContentSize
    let preferredSize = CGSize(width: childPreferred.width * 2, height: childPreferred.height)
    if preferredSize != CGSize.zero {
      self.preferredContentSize = preferredSize
    } else {
      // Default is 2x iPhone
      self.preferredContentSize = CGSize(width: 640, height: 480)
    }
  }

  // MARK: - Public Methods

  /// Push the provided view controller onto this split pane.
  ///
  /// - parameter rightController The new controller to display to the right of the current one.
  /// - parameter animated Whether to animate the push. This is true by default.
  func pushViewController(rightController: UIViewController, animated: Bool = true) {
    var animate = animated

    // Check to see if there is an existing view controller which we need to remove.
    if let oldRightController = self.rightController {
      // We can't animate in this case.
      animate = false

      startRemove(oldRightController)
      transitionToState(state, forceCollapsed: false, animated: false) {
        oldRightController.view.removeFromSuperview()
        self.endRemove(oldRightController)
      }
    }

    self.rightController = rightController

    // Add the new controller and insert it under the left one.
    startAdd(rightController)
    wrapperView.insertSubview(rightController.view, belowSubview: leftController.view)

    // Trigger an initial layout with the split pane collapsed, and then animate to being open.
    layoutViewControllersForState(state, forceCollapsed: true)
    transitionToState(state, animated: animate) {
      self.endAdd(rightController)
    }
  }

  /// Pop the rightmost view controller.
  ///
  /// - parameter animated Whether to animate the pop. This is true by default.
  func popViewController(animated: Bool = true) {
    guard let rightController = rightController else {
      return
    }

    // Remove the controller and animate it out.
    startRemove(rightController)
    transitionToState(state, forceCollapsed: true, animated: animated) {
      rightController.view.removeFromSuperview()
      self.endRemove(rightController)
    }

    self.rightController = nil
  }

  // MARK: - State Management

  /// Access the current state of the UI.
  private var state: State {
    get {
      if #available(iOS 8.0, *) {
        let hasMargin = insetViewController?.hasMargin ?? false
        return SplitPaneViewController.stateForTraitCollection(actualTraitCollection,
                                                               hasMargin: hasMargin)
      } else {
        return .FullScreen
      }
    }
  }

  @available(iOS 8.0, *)
  /// Determine the expected UI state for the given parameters.
  ///
  /// - parameter traitCollection The trait collection the UI will be displayed for.
  /// - parameter hasMargin Whether or not a wrapping |InsetViewController| has margins.
  private static func stateForTraitCollection(traitCollection: UITraitCollection,
                                              hasMargin: Bool) -> State {
    switch traitCollection.horizontalSizeClass {
    case .Compact, .Unspecified: return .FullScreen
    case .Regular: return hasMargin ? .CenteredSplitScreen : .SplitScreen
    }
  }

  // MARK: - State Change Animation

  /// Animate to the given state.
  ///
  /// - parameter state The state to animate to.
  /// - parameter forceCollapsed Whether to force the right view controller to be collapsed.
  /// - parameter overrideSize Override the size to use for layout.
  /// - parameter coordinator An optional animation coordinator to animate with.
  /// - parameter animated Whether to animate the transition. Defaults to true.
  /// - parameter completion A completion block to call when the animation has finished.
  private func transitionToState(
    state: State, forceCollapsed: Bool = false, overrideSize: CGSize? = nil, animated: Bool = true,
    withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator? = nil,
    completion: () -> Void) {
      // Determine which controllers were visible.
      let leftWasHidden = !wrapperView.bounds.intersects(leftController.view.frame)
      var rightWasHidden = false
      if let rightController = rightController {
        rightWasHidden = !view.bounds.intersects(rightController.view.frame)
      }

      var leftWillBeHidden = false
      var rightWillBeHidden = false

      // Setup the animation block.
      let animation = {
        // Layout the controllers using the given information.
        self.layoutViewControllersForState(state, forceCollapsed: forceCollapsed,
                                           overrideSize: overrideSize)

        // Update the state of whether the left and right controllers will be hidden. Also set the
        // 'from' hidden state.
        leftWillBeHidden = !self.view.bounds.intersects(self.leftController.view.frame)
        self.leftController.view.hidden = leftWasHidden && leftWillBeHidden
        if let rightController = self.rightController {
          rightWillBeHidden = !self.wrapperView.bounds.intersects(rightController.view.frame)
          rightController.view.hidden = rightWasHidden && rightWillBeHidden
        }
      }

      // Once the animation is finished update the hidden states and call the callback.
      let finish = {
        self.leftController.view.hidden = leftWillBeHidden
        if let rightController = self.rightController {
          rightController.view.hidden = rightWillBeHidden
        }

        completion()
      }

      // Check to see if we should be animating
      if animated {
        // Check to see if we do a coordinated animation or a standalone one.
        if let coordinator = coordinator {
          coordinator.animateAlongsideTransition({ _ in
            animation()
            }, completion: { _ in
              finish()
          })
        } else {
          UIView.animateWithDuration(0.367, animations: animation) { (finished) in
            finish()
          }
        }
      } else {
        animation()
        finish()
      }
  }

  // MARK: - Centralized Layout

  /// Layout the view controllers with the specified state.
  ///
  /// - parameter state The state to layout the controllers for.
  /// - parameter forceCollapsed Whether to force the second controller to be under the first one.
  /// - parameter overrideSize Override the size to use for layout.
  private func layoutViewControllersForState(state: State, forceCollapsed: Bool = false,
                                             overrideSize: CGSize? = nil) {
    let collapsed = rightController == nil || forceCollapsed
    // Call out the the static function.
    SplitPaneViewController.layoutViewControllersForState(state,
                                                          collapsed: collapsed,
                                                          size: overrideSize ?? view.bounds.size,
                                                          leftController: leftController,
                                                          rightController: rightController,
                                                          wrapperView: wrapperView,
                                                          shadowView: shadowView)
  }

  /// Layout the view controllers with the specified state. This function is static specifically so
  /// that all state must be passed in as parameters and instance variables cannot accidentally
  /// alter the behavior of the method.
  ///
  /// - parameter state The state to layout the controllers for.
  /// - parameter collapsed Whether the second controller is under the first one.
  /// - parameter size The size to use for layout.
  /// - parameter leftController The left controller.
  /// - parameter rightController The right controller.
  /// - parameter wrapperView The superview of left and right controller.
  private static func layoutViewControllersForState(state: State,
                                                    collapsed: Bool,
                                                    size: CGSize,
                                                    leftController: UIViewController,
                                                    rightController: UIViewController?,
                                                    wrapperView: UIView,
                                                    shadowView: ShadowView) {
    let fullBounds = CGRect(origin: CGPoint.zero, size: size)

    switch state {
    case .FullScreen:
      // If we are fullscreen, then both view controllers will have a bounds of |fullBounds|.
      // In the case where we are collapsed then they will be on top of each other, otherwise
      // the left controller will be offscreen to the left and the right controller will be
      // fullscreen.
      wrapperView.frame = fullBounds

      if collapsed {
        leftController.view.frame = wrapperView.bounds
        if let rightController = rightController {
          rightController.view.bounds = wrapperView.bounds
          rightController.view.center = offset(wrapperView.bounds.center,
                                               by: wrapperView.bounds.size.width)
        }
      } else {
        leftController.view.bounds = wrapperView.bounds
        leftController.view.center = offset(wrapperView.bounds.center,
                                            by: -wrapperView.bounds.size.width)
        if let rightController = rightController {
          rightController.view.frame = wrapperView.bounds
        }
      }

    case .SplitScreen:
      // If we are split screen, then both controllers can be shown side-by-side. If there is only
      // one controller or we are collapsed make if fill the bounds, otherwise split the space
      // equally.
      wrapperView.frame = fullBounds

      var leftFrame = CGRect()
      var rightFrame = CGRect()
      CGRectDivide(wrapperView.bounds, &leftFrame, &rightFrame, wrapperView.bounds.size.width/2,
                   .MinXEdge)

      if collapsed {
        leftController.view.frame = wrapperView.bounds
        if let rightController = rightController {
          let rightFrame = CGRect(x: wrapperView.bounds.maxX, y: wrapperView.bounds.origin.y,
                                  width: rightFrame.size.width, height: rightFrame.size.height)
          rightController.view.frame = rightFrame
        }
      } else {
        leftController.view.frame = leftFrame
        if let rightController = rightController {
          rightController.view.frame = rightFrame
        }
      }

    case .CenteredSplitScreen:
      // If we are centered split screen it's basically the same as split screen, except for that
      // when we are collapsed or there is only one controller then we display them smaller than the
      // full bounds. This makes it look like the second one is always hidden behind the first as
      // the size of them do not change.
      var leftFrame = CGRect()
      var rightFrame = CGRect()
      CGRectDivide(fullBounds, &leftFrame, &rightFrame, fullBounds.size.width/2, .MinXEdge)

      if collapsed {
        wrapperView.frame = leftFrame
        wrapperView.center = fullBounds.center
        leftController.view.frame = wrapperView.bounds
        if let rightController = rightController {
          rightController.view.frame = wrapperView.bounds
        }
      } else {
        wrapperView.frame = fullBounds
        leftController.view.frame = leftFrame
        if let rightController = rightController {
          rightController.view.frame = rightFrame
        }
      }
    }

    // Update shadow and corner radius state. These are only shown when we are centered.
    wrapperView.clipsToBounds = state == .CenteredSplitScreen
    shadowView.enableShadow = state == .CenteredSplitScreen
    shadowView.frame = wrapperView.frame
  }

  // MARK: - Utilities

  /// Offset a GGPoint along the X axis by the specified amount.
  private static func offset(point: CGPoint, by offset: CGFloat) -> CGPoint {
    return CGPoint(x: point.x + offset, y: point.y)
  }

  /// Start adding a view controller. This makes it a child and sets the associated object on it
  /// so that |self| can be looked up using |UIViewController.splitPaneViewController|.
  private func startAdd(viewController: UIViewController) {
    objc_setAssociatedObject(viewController, &SplitPaneViewControllerAssociatedObjectHandle, self,
                             .OBJC_ASSOCIATION_ASSIGN)

    self.addChildViewController(viewController)
  }

  /// Finish up adding a view controller.
  private func endAdd(viewController: UIViewController) {
    viewController.didMoveToParentViewController(self)
  }

  /// Start removing a child view controller.
  private func startRemove(viewController: UIViewController) {
    viewController.willMoveToParentViewController(self)
  }

  /// Finish up removing a child view controller. Remove it as a child and reset the
  /// |UIViewController.splitPaneViewController| property.
  private func endRemove(viewController: UIViewController) {
    viewController.removeFromParentViewController()

    // Check to see if it hasn't changed before nilling it out.
    if viewController.splitPaneViewController == self {
      objc_setAssociatedObject(viewController, &SplitPaneViewControllerAssociatedObjectHandle, nil,
                               .OBJC_ASSOCIATION_ASSIGN)
    }
  }
}

// MARK: - UIViewController Extensions

internal var SplitPaneViewControllerAssociatedObjectHandle: UInt8 = 0

extension UIViewController {
  /// Retrieve the parent |SplitPaneViewController| of |self| if one is present.
  var splitPaneViewController: SplitPaneViewController? {
    get {
      // Walk up the view controller hierarchy until we find one with the associated object set.
      var check = self
      repeat {
        if let pane = objc_getAssociatedObject(check,
                                               &SplitPaneViewControllerAssociatedObjectHandle) as?
                           SplitPaneViewController {
          return pane
        }
        guard let parent = check.parentViewController else {
          return nil
        }
        check = parent
      } while true
    }
  }
}
