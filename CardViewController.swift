//
//  CardViewController.swift
//
//
//  Created by Nick Rigano on 11/23/16.
//
//

import UIKit
import ZLSwipeableViewSwift
import Cartography


var testArray1 = ["", "De Mole", "Mexican", "$$", ".4 miles", "Wednesday 11AM-11:30PM"]
var testArray2 = ["", "Rizzo's Pizza", "Italian", "$$", ".1 miles", "Wednesday 11AM-10PM"]


class CardViewController: UIViewController {
    
    var swipeableView: ZLSwipeableView!
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        swipeableView.nextView = {
            return self.nextCardView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeableView = ZLSwipeableView()
        swipeableView.backgroundColor = UIColor.red
        view.addSubview(swipeableView)
        self.view.backgroundColor = UIColor.green
        
        print("running")
        
        
        swipeableView.didStart = {view, location in
            print("Did start swiping view at location: \(location)")
        }
        swipeableView.swiping = {view, location, translation in
            print("Swiping at view location: \(location) translation: \(translation)")
        }
        swipeableView.didEnd = {view, location in
            print("Did end swiping view at location: \(location)")
        }
        swipeableView.didSwipe = {view, direction, vector in
            print("Did swipe view in direction: \(direction), vector: \(vector)")
        }
        swipeableView.didCancel = {view in
            print("Did cancel swiping view")
        }
        swipeableView.didTap = {view, location in
            print("Did tap at location \(location)")
        }
        swipeableView.didDisappear = { view in
            print("Did disappear swiping view")
        }
        
        constrain(swipeableView, view) { view1, view2 in
            view1.left == view2.left+50
            view1.right == view2.right-50
            view1.top == view2.top + 120
            view1.bottom == view2.bottom - 100
        }
    }
    
    
    
    // MARK: ()
    func nextCardView() -> UIView? {
        
        let cardView = CardView(frame: swipeableView.bounds)
        cardView.backgroundColor = getRandomColor()
        
        return cardView
    }
    
    
    
    
    func getRandomColor() -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    
    
}



//class CardViewController: UIViewController {
//    
//    var swipeableView: ZLSwipeableView!
//    
//    var restaurantImageView = UIImageView()
//    var restaurantNameLabel = UILabel()
//    var restaurantCuisineLabel = UILabel()
//    var restaurantCostLabel = UILabel()
//    var restaurantDistanceLabel = UILabel()
//    var restaurantHoursLabek = UILabel()
//    
//    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        swipeableView.nextView = {
//            return self.nextCardView()
//        }
//    }
//    
//    
//    
//    
//    
//    
//    
//    
//    //        super.viewDidLayoutSubviews()
//    //        swipeableView.nextView = {
//    //
//    //            var customView = UIView()
//    //            customView.backgroundColor = UIColor.random
//    //
//    //            return customView
//    //        }
//    //
//    //
//    //    }
//    //
//    //    override func viewDidLoad() {
//    //        var cardSize = CGRect(x: 100, y: 100, width: 100, height: 100)
//    //        swipeableView = ZLSwipeableView(frame: cardSize)
//    //        view.addSubview(swipeableView)
//    //
//    //
//    //    }
//    //
//    //
//    //}
//    //
//    //
//    //
//    //
//    //extension UIColor{
//    //    class var random: UIColor{
//    //        let red = CGFloat(drand48())
//    //        let green = CGFloat(drand48())
//    //        let blue = CGFloat(drand48())
//    //
//    //        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
//    //    }
//    //}
//    //
//    //
//    ////class CardViewController: UIViewController {
//    ////
//    ////    override func viewDidLoad() {
//    ////        super.viewDidLoad()
//    ////
//    ////        var swipeableView = ZLSwipeableView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
//    ////        view.addSubview(swipeableView)
//    ////    }
//    ////
//    ////
//    ////   
//    ////}
//}
