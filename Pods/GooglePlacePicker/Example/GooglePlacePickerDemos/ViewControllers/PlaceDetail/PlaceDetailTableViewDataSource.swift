import UIKit
import GooglePlaces

enum PlaceProperty: Int {
  case PlaceID
  case Coordinate
  case OpenNowStatus
  case PhoneNumber
  case Website
  case FormattedAddress
  case Rating
  case PriceLevel
  case Types
  case Attribution

  static func numberOfProperties() -> Int {
    return 10
  }
}

/// The data source and delegate for the Place Detail |UITableView|. Beyond just displaying the
/// details of the place, this class also manages the floating section title containing the place
/// name and takes into account the presence of the back button if it's visible.
class PlaceDetailTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
  // MARK: - Properties
  private let place: GMSPlace
  private let blueCellIdentifier = "BlueCellIdentifier"
  private let extensionConstraint: NSLayoutConstraint
  private let noneText = NSLocalizedString("PlaceDetails.MissingValue",
                                           comment: "The value of a property which is missing")
  // Additional margin padding to use during layout. This is 0 for iOS versions 8.0 and above, while
  // on iOS 7 this needs to be hardcoded to 8 to ensure the correct layout.
  private let additionalMarginPadding: CGFloat = {
    if #available(iOS 8.0, *) {
      return 0
    } else {
      return 8
    }
  }()

  var offsetNavigationTitle = false

  // MARK: Init/Deinit

  /// Create a |PlaceDetailTableViewDataSource| with the specified |GMSPlace| and constraint.
  ///
  /// - parameter place The |GMSPlace| to show details for.
  /// - parameter extensionConstraint The |NSLayoutConstraint| to update when scrolling so that
  /// the header view shrinks/grows to fill the gap between the map/photo and the details.
  init(place: GMSPlace, extensionConstraint: NSLayoutConstraint) {
    self.place = place
    self.extensionConstraint = extensionConstraint
  }

  // MARK: - Public Methods

  /// Configure the |UITableView| we will be providing results for.
  ///
  /// - parameter tableView The table view to configure.
  func configure(tableView: UITableView) {
    // Register the |UITableViewCell|s.
    tableView.registerNib(PlaceAttributeCell.nib,
                          forCellReuseIdentifier: PlaceAttributeCell.reuseIdentifier)
    tableView.registerNib(PlaceNameHeader.nib,
                          forHeaderFooterViewReuseIdentifier: PlaceNameHeader.reuseIdentifier)
    tableView.registerClass(UITableViewCell.self,
                            forCellReuseIdentifier: blueCellIdentifier)

    // Configure some other properties.
    tableView.estimatedRowHeight = 44
    tableView.estimatedSectionHeaderHeight = 44
    tableView.sectionHeaderHeight = UITableViewAutomaticDimension
  }

  func updateNavigationTextOffset(tableView: UITableView) {
    // Grab the header.
    if let header = tableView.headerViewForSection(0) as? PlaceNameHeader {
      // Check to see if we should be offsetting the navigation title.
      if offsetNavigationTitle {
        // If so offset it by at most 36 pixels, relative to how much we've scrolled past 160px.
        let offset = max(0, min(36, tableView.contentOffset.y - 160))
        header.leadingConstraint.constant = offset + additionalMarginPadding
      } else {
        // Otherwise don't offset.
        header.leadingConstraint.constant = additionalMarginPadding
      }
    }
  }

  // MARK: - UITableView DataSource/Delegate

  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return PlaceProperty.numberOfProperties() + 1
  }

  func tableView(tableView: UITableView,
                 cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    // The first cell is special, this is a small blue spacer we use to pad out the place name
    // header.
    if indexPath.item == 0 {
      let cell = tableView.dequeueReusableCellWithIdentifier(blueCellIdentifier,
                                                             forIndexPath: indexPath)
      cell.backgroundColor = Colors.blue2
      cell.selectionStyle = .None
      return cell
    }

    // For all the other cells use the same class.

    let untyped = tableView.dequeueReusableCellWithIdentifier(PlaceAttributeCell.reuseIdentifier,
                                                              forIndexPath: indexPath)
    let cell = untyped as! PlaceAttributeCell

    // Disable selection.
    cell.selectionStyle = .None

    // Set the relevant values.
    if let propertyType = PlaceProperty(rawValue: indexPath.item - 1) {
      cell.propertyName.text = propertyType.localizedDescription()
      cell.propertyIcon.image = propertyType.icon()

      switch propertyType {
      case .PlaceID:
        cell.propertyValue.text = place.placeID
      case .Coordinate:
        let format = NSLocalizedString("Places.Property.Coordinate.Format",
                                       comment: "The format string for latitude, longitude")
        cell.propertyValue.text = String(format: format, place.coordinate.latitude,
                                         place.coordinate.longitude)
      case .OpenNowStatus:
        cell.propertyValue.text = textForOpenNowStatus(place.openNowStatus)
      case .PhoneNumber:
        cell.propertyValue.text = place.phoneNumber ?? noneText
      case .Website:
        cell.propertyValue.text = place.website?.absoluteString ?? noneText
      case .FormattedAddress:
        cell.propertyValue.text = place.formattedAddress ?? noneText
      case .Rating:
        let rating = place.rating
        // As specified in the documentation for |GMSPlace|, a rating of 0.0 signifies that there
        // have not yet been any ratings for this location.
        if rating > 0 {
          cell.propertyValue.text = "\(rating)"
        } else {
          cell.propertyValue.text = noneText
        }
      case .PriceLevel:
        cell.propertyValue.text = textForPriceLevel(place.priceLevel)
      case .Types:
        cell.propertyValue.text = place.types.joinWithSeparator(", ")
      case .Attribution:
        if let attributions = place.attributions {
          cell.propertyValue.attributedText = attributions
        } else {
          cell.propertyValue.text = noneText
        }
      }
    } else {
      fatalError("Unexpected row index")
    }

    return cell
  }

  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return place.name
  }

  func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return tableView.dequeueReusableHeaderFooterViewWithIdentifier(PlaceNameHeader.reuseIdentifier)
  }

  func tableView(tableView: UITableView,
                 heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    // Our first cell has a fixed height, all the rest are automatic.
    if indexPath.item == 0 {
      return 20
    }
    else {
      if #available(iOS 8.0, *) {
        return UITableViewAutomaticDimension
      } else {
        // This means that on iOS 7 we only get the first line of text.
        return 55
      }
    }
  }

  /// Only needed for iOS 7, explodes if this is not provided.
  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if #available(iOS 8.0, *) {
      return UITableViewAutomaticDimension
    } else {
      // This means that on iOS 7 we only get the first line of text.
      return 65
    }
  }

  func scrollViewDidScroll(scrollView: UIScrollView) {
    // Update the extensionConstraint and the navigation title offset when the tableView scrolls.
    if let tableView = scrollView as? UITableView {
      extensionConstraint.constant = max(0, -scrollView.contentOffset.y)

      updateNavigationTextOffset(tableView)
    }
  }

  // MARK: - Utilities

  /// Return the appropriate text string for the specified |GMSPlacesOpenNowStatus|.
  private func textForOpenNowStatus(status: GMSPlacesOpenNowStatus) -> String {
    switch status {
    case .No: return NSLocalizedString("Places.OpenNow.No",
                                       comment: "Closed/Open state for a closed location")
    case .Yes: return NSLocalizedString("Places.OpenNow.Yes",
                                        comment: "Closed/Open state for an open location")
    case .Unknown: return NSLocalizedString("Places.OpenNow.Unknown",
                                            comment: "Closed/Open state for when it is unknown")
    }
  }

  /// Return the appropriate text string for the specified |GMSPlacesPriceLevel|.
  private func textForPriceLevel(priceLevel: GMSPlacesPriceLevel) -> String {
    switch priceLevel {
    case .Free: return NSLocalizedString("Places.PriceLevel.Free",
                                         comment: "Relative cost for a free location")
    case .Cheap: return NSLocalizedString("Places.PriceLevel.Cheap",
                                          comment: "Relative cost for a cheap location")
    case .Medium: return NSLocalizedString("Places.PriceLevel.Medium",
                                           comment: "Relative cost for a medium cost location")
    case .High: return NSLocalizedString("Places.PriceLevel.High",
                                         comment: "Relative cost for a high cost location")
    case .Expensive: return NSLocalizedString("Places.PriceLevel.Expensive",
                                              comment: "Relative cost for an expensive location")
    case .Unknown: return NSLocalizedString("Places.PriceLevel.Unknown",
                                            comment: "Relative cost for when it is unknown")
    }
  }
}

extension PlaceProperty {
  func localizedDescription() -> String {
    switch self {
    case .PlaceID:
      return NSLocalizedString("Places.Property.PlaceID",
                               comment: "Name for the Place ID property")
    case .Coordinate:
      return NSLocalizedString("Places.Property.Coordinate",
                               comment: "Name for the Coordinate property")
    case .OpenNowStatus:
      return NSLocalizedString("Places.Property.OpenNowStatus",
                               comment: "Name for the Open now status property")
    case .PhoneNumber:
      return NSLocalizedString("Places.Property.PhoneNumber",
                               comment: "Name for the Phone number property")
    case .Website:
      return NSLocalizedString("Places.Property.Website",
                               comment: "Name for the Website property")
    case .FormattedAddress:
      return NSLocalizedString("Places.Property.FormattedAddress",
                               comment: "Name for the Formatted address property")
    case .Rating:
      return NSLocalizedString("Places.Property.Rating",
                               comment: "Name for the Rating property")
    case .PriceLevel:
      return NSLocalizedString("Places.Property.PriceLevel",
                               comment: "Name for the Price level property")
    case .Types:
      return NSLocalizedString("Places.Property.Types",
                               comment: "Name for the Types property")
    case .Attribution:
      return NSLocalizedString("Places.Property.Attributions",
                               comment: "Name for the Attributions property")
    }
  }

  func icon() -> UIImage? {
    switch self {
    case .PlaceID:
      return UIImage(named: "place_id")
    case .Coordinate:
      return UIImage(named: "coordinate")
    case .OpenNowStatus:
      return UIImage(named: "open_now")
    case .PhoneNumber:
      return UIImage(named: "phone_number")
    case .Website:
      return UIImage(named: "website")
    case .FormattedAddress:
      return UIImage(named: "address")
    case .Rating:
      return UIImage(named: "rating")
    case .PriceLevel:
      return UIImage(named: "price_level")
    case .Types:
      return UIImage(named: "types")
    case .Attribution:
      return UIImage(named: "attribution")
    }
  }
}
