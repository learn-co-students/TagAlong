//
//  Restaurant.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/20/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import Foundation

class Restaurant {
    
//    var restaurantLat: Double
//    var restaurantLong: Double
    var restaurantName: String
    var openNow: Int = 0
    var priceLevel: Int = 0
    var restaurantRating: Double
    
    init(restaurantName: String, openNow: Int, priceLevel: Int, restaurantRating: Double) {
        self.restaurantName = restaurantName
        self.openNow = openNow
        self.priceLevel = priceLevel
        self.restaurantRating = restaurantRating
    }
//    
//    func restaurantOpen()-> Bool {
//        if openNow == 1 {
//            return true
//        }
//        return false
//    }

}
