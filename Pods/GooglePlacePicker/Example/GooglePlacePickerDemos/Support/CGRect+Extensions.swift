import CoreGraphics

extension CGRect {
  var center: CGPoint {
    get {
      return CGPoint(x: origin.x+size.width/2, y: origin.y+size.height/2)
    }
  }
}
