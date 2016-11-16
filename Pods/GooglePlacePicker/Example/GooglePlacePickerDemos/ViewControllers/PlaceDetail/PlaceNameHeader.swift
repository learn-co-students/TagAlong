import UIKit

/// The view which displays the name of a |GMSPlace|.
class PlaceNameHeader: UITableViewHeaderFooterView {
  static let nib = { UINib(nibName: "PlaceNameHeader", bundle: nil) }()
  static let reuseIdentifier = "PlaceNameHeader"
  @IBOutlet private weak var placeNameLabel: UILabel!
  @IBOutlet weak var leadingConstraint: NSLayoutConstraint!

  // Override the textLabel property so that |UITableView| automatically knows how to set the text.
  override var textLabel: UILabel? {
    get {
      return placeNameLabel
    }
  }

  override func awakeFromNib() {
    // Create a background view for the header.
    let background = UIView(frame: bounds)

    // Place a drop shadow at the top edge so that we nicely overlay the photo & map.
    let shadow = ShadowLineView()
    shadow.shadowOpacity = 0.6
    shadow.shadowSize = 3
    shadow.enableShadow = true
    shadow.shadowColor = Colors.blue2
    shadow.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 0)
    shadow.autoresizingMask = [.FlexibleBottomMargin, .FlexibleWidth]
    background.addSubview(shadow)

    // Add the solid color we want on top of the drop shadow to hide all but the top edge of it.
    let color = UIView(frame: background.bounds)
    color.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    color.backgroundColor = Colors.blue2
    background.addSubview(color)

    // Set it as the background.
    backgroundView = background

    if #available(iOS 8.0, *) {
    } else {
      placeNameLabel.font = UIFont.systemFontOfSize(20)
    }
  }
}
