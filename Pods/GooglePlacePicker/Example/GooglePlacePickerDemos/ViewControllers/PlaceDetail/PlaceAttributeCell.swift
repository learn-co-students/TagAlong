import UIKit

/// A cell which displays the name and value of an attribute on |GMSPlace|.
class PlaceAttributeCell: UITableViewCell {
  static let nib = { UINib(nibName: "PlaceAttributeCell", bundle: nil) }()
  static let reuseIdentifier = "PlaceAttributeCell"
  @IBOutlet weak var propertyName: UILabel!
  @IBOutlet weak var propertyValue: UILabel!
  @IBOutlet weak var propertyIcon: UIImageView!
}
