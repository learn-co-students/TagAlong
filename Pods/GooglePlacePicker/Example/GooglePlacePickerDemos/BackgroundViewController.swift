import UIKit

/// Simple placeholder view controller, will be replaced with the real deal in a later CL.
class BackgroundViewController: UIViewController {
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .Default
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.backgroundColor = UIColor.whiteColor()
  }
}
