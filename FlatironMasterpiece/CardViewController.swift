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


var testArray1 = ["spreads", "De Mole", "Mexican", "$$", ".4 miles", "11AM-11:30PM"]
var testArray2 = ["spreads.jpg", "Rizzo's Pizza", "Italian", "$$", ".1 miles", "11AM-10PM"]


class CardViewController: UIViewController {
    
    var swipeableView: ZLSwipeableView!
    
    //erica's code
    var restStore = RestaurantDataStore.sharedInstance
    var restaurantArray = [Restaurant]()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.restaurantArray = restStore.restaurantsArray
        
        swipeableView.numberOfActiveView = UInt(restStore.restaurantsArray.count)
        swipeableView.nextView = {
            return self.nextCardView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeableView = ZLSwipeableView()
        swipeableView.backgroundColor = UIColor.red
        view.addSubview(swipeableView)
        self.view.backgroundColor = phaedraOrange
        
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
            if direction.description == "Right" {
                let selectedRestVC = SelectedRestaurantViewController()
                self.navigationController?.pushViewController(selectedRestVC, animated: true)
            }
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
        
        // +50 -50 +120 -100
        
        constrain(swipeableView, view) { view1, view2 in
            view1.left == view2.left+50
            view1.right == view2.right-50
            view1.top == view2.top + 120
            view1.bottom == view2.bottom - 100
        }
    }
    

    
    // MARK: ()
    func nextCardView() -> UIView? {
        
      
        while restaurantArray.count != 0{
            let restaurant = restaurantArray.removeFirst()
            let cardView = CardView(restaurant: restaurant, frame: swipeableView.bounds)
            cardView.backgroundColor = getRandomPhaedraColor()
    
            return cardView
            
        }
        
        //if i have a next card then return view if i do not return nil
        
       
//        cardView.backgroundColor = getRandomColor()
        return CardView(restaurant: nil, frame: swipeableView.bounds)
    }
    
    func getRandomPhaedraColor()-> UIColor {
        let phaedraColorArray:[UIColor] = [phaedraLightGreen, phaedraYellow, phaedraBeige, phaedraOliveGreen, phaedraDarkGreen]
        let randomNum = Int(arc4random_uniform(UInt32(phaedraColorArray.count)))
        return phaedraColorArray[randomNum]
    }
    
    
    
}
