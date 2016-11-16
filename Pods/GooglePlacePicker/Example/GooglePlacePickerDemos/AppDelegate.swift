import UIKit
import GooglePlaces
import GoogleMaps

/// Application delegate for the PlacePicker demo app.
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    // Do a quick check to see if you've provided an API key, in a real app you wouldn't need this
    // but for the demo it means we can provide a better error message if you haven't.
    if kMapsAPIKey.isEmpty || kPlacesAPIKey.isEmpty {
      // Blow up if API keys have not yet been set.
      let bundleId = NSBundle.mainBundle().bundleIdentifier!
      let msg = "Configure API keys inside SDKDemoAPIKey.swift for your  bundle `\(bundleId)`, " +
                "see README.GooglePlacePickerDemos for more information"
      fatalError(msg)
    }

    // Provide the Places API with your API key.
    GMSPlacesClient.provideAPIKey(kPlacesAPIKey)
    // Provide the Maps API with your API key. We need to provide this as well because the Place
    // Picker displays a Google Map.
    GMSServices.provideAPIKey(kMapsAPIKey)

    // Log the required open source licenses! Yes, just logging them is not enough but is good for
    // a demo.
    print(GMSPlacesClient.openSourceLicenseInfo())
    print(GMSServices.openSourceLicenseInfo())

    // Construct a window and the split split pane view controller we are going to embed our UI in.
    let window = UIWindow(frame: UIScreen.mainScreen().bounds)
    let rootViewController = PickAPlaceViewController()
    let splitPaneViewController = SplitPaneViewController(rootViewController: rootViewController)

    // If we're on iOS 8 or above wrap the split pane controller in a inset controller to get the
    // map displaying behind our content on iPad devices.
    if #available(iOS 8.0, *) {
      let mapController = BackgroundMapViewController()
      rootViewController.mapViewController = mapController
      let insetController = InsetViewController(backgroundViewController: mapController,
                                                contentViewController: splitPaneViewController)
      window.rootViewController = insetController
    } else {
      window.rootViewController = splitPaneViewController
    }

    // Make the window visible and allow the app to continue initialization.
    window.makeKeyAndVisible()
    self.window = window

    return true
  }
}
