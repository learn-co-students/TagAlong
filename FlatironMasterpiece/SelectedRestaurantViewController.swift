//
//  SelectedRestaurantViewController.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/25/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit

class SelectedRestaurantViewController: UIViewController {
    
    var restaurantView: RestaurantView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Restaurant Detail View"
        view.backgroundColor = UIColor.blue
    }
    
    override func loadView() {
        super.loadView()
        restaurantView = RestaurantView()
        self.view = restaurantView
    }
    
    func createTagAlong(user: String, date: String, location: [String: Any]) {
        
        //Things a tagalong needs:

//        "host" : "UserID", <-- should be collected when host confirms
        //         "location" : [     <-- should be collected from host
        //                "name" : "taco bell", <-- should be collected from host / restaurant conf card
        //                "latitude" : "30",
        //                "longitude" : "30"
        //            ],
        //         "date-time" : "figure out formatting here"
        
        
        
        
    }
}
