import UIKit

@available(iOS 8.0, *)
/// A container view controller which displays its child controller with an optional inset and
/// background view controller. The inset and background controller are only shown if there is
/// enough space for the child controller to fit after being inset.
class InsetViewController: BaseContainerViewController {
  // MARK: - Properties
  private let backgroundViewController: UIViewController
  private let contentViewController: UIViewController
  private(set) var hasMargin = false
  private var parallax: UIMotionEffectGroup!

  // MARK: - Init/Deinit

  init(backgroundViewController: UIViewController, contentViewController: UIViewController) {
    self.backgroundViewController = backgroundViewController
    self.contentViewController = contentViewController

    super.init(nibName: nil, bundle: nil)

    // Set the associated object value on |viewController| so that it can look up this instance
    // using |UIViewController.insetViewController|.
    objc_setAssociatedObject(self.contentViewController, &InsetViewControllerAssociatedObjectHandle,
                             self, .OBJC_ASSOCIATION_ASSIGN)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Controller Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    // Add the background and the content controllers.

    addChildViewController(backgroundViewController)
    backgroundViewController.view.frame = view.bounds
    backgroundViewController.view.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
    view.addSubview(backgroundViewController.view)
    backgroundViewController.didMoveToParentViewController(self)

    addChildViewController(contentViewController)
    view.addSubview(contentViewController.view)
    contentViewController.view.autoresizingMask = [.FlexibleTopMargin, .FlexibleLeftMargin,
                                                   .FlexibleRightMargin, .FlexibleBottomMargin]
    contentViewController.didMoveToParentViewController(self)

    initializeParallax()
  }

  private func initializeParallax() {
    // Set vertical effect
    let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y",
                                                           type: .TiltAlongVerticalAxis)
    verticalMotionEffect.minimumRelativeValue = -30
    verticalMotionEffect.maximumRelativeValue = 30

    // Set horizontal effect
    let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x",
                                                             type: .TiltAlongHorizontalAxis)
    horizontalMotionEffect.minimumRelativeValue = -30
    horizontalMotionEffect.maximumRelativeValue = 30

    // Create group to combine both
    parallax = UIMotionEffectGroup()
    parallax.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    // Trigger a layout when we are first made visible.
    transitionToSize(view.bounds.size, traitCollection: traitCollection) {}
  }

  /// Listen to size changes and trigger the appropriate animations.
  override func viewWillTransitionToSize(size: CGSize,
    withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
      transitionToSize(size, traitCollection: actualTraitCollection, coordinator: coordinator) {}

      super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
  }

  /// Provide the correct size of the child controller to UIKit.
  override func sizeForChildContentContainer(container: UIContentContainer,
                                             withParentContainerSize parentSize: CGSize) -> CGSize {
    if container.isEqual(contentViewController) {
      return InsetViewController.viewControllerSize(contentViewController.preferredContentSize,
                                                    size: parentSize, traits: actualTraitCollection)
    } else if container.isEqual(backgroundViewController) {
      return parentSize
    } else {
      return super.sizeForChildContentContainer(container, withParentContainerSize: parentSize)
    }
  }

  /// Pass through to the appropriate child view controller for status bar appearance.
  override func childViewControllerForStatusBarStyle() -> UIViewController? {
    if contentViewController.view.frame == view.bounds {
      return contentViewController
    } else {
      return backgroundViewController
    }
  }

  /// Pass through to the appropriate child view controller for status bar appearance.
  override func childViewControllerForStatusBarHidden() -> UIViewController? {
    if contentViewController.view.frame == view.bounds {
      return contentViewController
    } else {
      return backgroundViewController
    }
  }

  /// Listen for changes in our children's preferred content size.
  override func preferredContentSizeDidChangeForChildContentContainer(
    container: UIContentContainer) {
    transitionToSize(view.bounds.size, traitCollection: actualTraitCollection) {}
  }

  // MARK: - Layout

  /// Transition to the given size using an animation.
  ///
  /// - parameter size The size to transition to.
  /// - parameter traitCollection The trait collection which will be used for layout.
  /// - parameter coordinator An optional animation coordinator to use.
  /// - parameter completion The completion block to call upon animation completion.
  private func transitionToSize(size: CGSize, traitCollection: UITraitCollection,
                                coordinator: UIViewControllerTransitionCoordinator? = nil,
                                completion: () -> Void) {
    // Determine the visibility state of the background before and after the transition.
    let backgroundWasHidden = backgroundViewController.view.hidden
    var newFrame = CGRect()
    newFrame.size = InsetViewController.viewControllerSize(
      contentViewController.preferredContentSize, size: size, traits: traitCollection)
    let backgroundWillBeHidden = newFrame.size == size
    hasMargin = !backgroundWillBeHidden

    // Setup the animation.
    let animate = {
      self.contentViewController.view.frame = newFrame
      self.contentViewController.view.center = self.view.bounds.center

      if backgroundWasHidden != backgroundWillBeHidden {
        // Notify the background controller that it is about to transition in/out.
        self.backgroundViewController.beginAppearanceTransition(!backgroundWillBeHidden,
                                                                animated: true)
      }

      self.backgroundViewController.view.hidden = backgroundWasHidden && backgroundWillBeHidden

      self.setNeedsStatusBarAppearanceUpdate()
    }

    // And the completion callback.
    let finish = {
      self.backgroundViewController.view.hidden = backgroundWillBeHidden

      if backgroundWasHidden != backgroundWillBeHidden {
        // Notify the background controller that the transition in/out has finished.
        self.backgroundViewController.endAppearanceTransition()
      }

      // Add/remove the parallax effect.
      if backgroundWillBeHidden {
        self.contentViewController.view.removeMotionEffect(self.parallax)
      } else {
        self.contentViewController.view.addMotionEffect(self.parallax)
      }

      completion()
    }

    // If a coordinator was provided use that, otherwise kick of a vanilla UIView animation.
    if let coordinator = coordinator {
      coordinator.animateAlongsideTransition({ _ in
        animate()
        }, completion: { _ in
          finish()
      })
    } else {
      animate()
      finish()
    }
  }

  /// Determine the size of the child for the given state. This function is static specifically so
  /// that all state must be passed in as parameters and instance variables cannot accidentally
  /// alter the behavior of the method.
  ///
  /// - parameter controllersPreferredSize The child view controllers preferred size.
  /// - parameter size The size of this controller.
  /// - parameter traits The trait classes which this controller will be displayed for.
  ///
  /// - returns: The size the child view controller should be given the parameters.
  private static func viewControllerSize(controllersPreferredSize: CGSize, size: CGSize,
                                         traits: UITraitCollection) -> CGSize {
    // If we're compact immediately make the child fullscreen, it'll need all the space it can get.
    if traits.horizontalSizeClass == .Compact || traits.verticalSizeClass == .Compact {
      return size
    }

    // Use the preferred size if its non-zero.
    var preferredSize = controllersPreferredSize
    if preferredSize == CGSize.zero {
      preferredSize = CGSize(width: 600, height: 600)
    }

    // If we don't have enough space to fit the controller horizontally or vertically with some
    // padding, make it fullscreen.

    if size.width < preferredSize.width + 100 || size.height < preferredSize.height + 100 {
      return size
    }

    // Else give the controller the size it wanted.
    return preferredSize
  }
}

@available(iOS 8.0, *)
internal var InsetViewControllerAssociatedObjectHandle: UInt8 = 0

@available(iOS 8.0, *)
extension UIViewController {
  /// Retrieve the parent |InsetViewController| of |self| if one is present.
  var insetViewController: InsetViewController? {
    get {
      // Walk up the view controller hierarchy until we find one with the associated object set.
      var check = self
      repeat {
        if let inset = objc_getAssociatedObject(check,
                                                &InsetViewControllerAssociatedObjectHandle) as?
                           InsetViewController {
          return inset
        }
        guard let parent = check.parentViewController else {
          return nil
        }
        check = parent
      } while true
    }
  }
}
