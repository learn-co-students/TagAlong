//
//  CardViewController.swift
//  
//
//  Created by Nick Rigano on 11/23/16.
//
//

import UIKit

var testArray1 = ["", "De Mole", "Mexican", "$$", ".4 miles", "Wednesday 11AM-11:30PM"]
var testArray2 = ["", "Rizzo's Pizza", "Italian", "$$", ".1 miles", "Wednesday 11AM-10PM"]


class ZLSwipeableViewController: UIViewController {
    
    var swipeableView: ZLSwipeableView!
    var restaurantImageView = UIImageView()
    var restaurantNameLabel = UILabel()
    var restaurantCuisineLabel = UILabel()
    var restaurantCostLabel = UILabel()
    var restaurantDistanceLabel = UILabel()
    var restaurantHoursLabek = UILabel()
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        swipeableView.nextView = {
            return self.nextCardView()
        }
    
    
}




class CardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var swipeableView = ZLSwipeableView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
        view.addSubview(swipeableView)
    }


   
}
