import UIKit
import GooglePlacePicker

/// A view controller which displays a UI for opening the Place Picker. Once a place is selected
/// it navigates to the place details screen for the selected location.
class PickAPlaceViewController: UIViewController {
  private var placePicker: GMSPlacePicker?
  @IBOutlet private weak var pickAPlaceButton: UIButton!
  var mapViewController: BackgroundMapViewController?

  init() {
    super.init(nibName: String(self.dynamicType), bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // This is the size we would prefer to be.
    self.preferredContentSize = CGSize(width: 330, height: 600)

    // Configure our view.
    view.backgroundColor = Colors.blue1
    view.clipsToBounds = true
  }

  @IBAction func buttonTapped() {
    // Create a place picker.
    let config = GMSPlacePickerConfig(viewport: nil)
    let placePicker = GMSPlacePicker(config: config)

    // Present it fullscreen.
    placePicker.pickPlaceWithCallback { (place, error) in

      // Handle the selection if it was successful.
      if let place = place {
        // Create the next view controller we are going to display and present it.
        let nextScreen = PlaceDetailViewController(place: place)
        self.splitPaneViewController?.pushViewController(nextScreen, animated: false)
        self.mapViewController?.coordinate = place.coordinate
      } else if error != nil {
        // In your own app you should handle this better, but for the demo we are just going to log
        // a message.
        NSLog("An error occurred while picking a place: \(error)")
      } else {
        NSLog("Looks like the place picker was canceled by the user")
      }

      // Release the reference to the place picker, we don't need it anymore and it can be freed.
      self.placePicker = nil
    }

    // Store a reference to the place picker until it's finished picking. As specified in the docs
    // we have to hold onto it otherwise it will be deallocated before it can return us a result.
    self.placePicker = placePicker
  }

  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return .LightContent
  }
}
