//
//  Restaurant.swift
//  FlatironMasterpiece
//
//  Created by Elias Miller on 11/15/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import Foundation

class Restaurant {
    var latitude: Double?
    var longitude: Double?
    var name: String?
    var openNow: Bool = false
    var priceLevel: Int?
    var restaurantRating: Int?
    var timeStampOfLocation: Double?
    
    init(dictionary: json) {
//        guard let restaurantAddress = dictionary["formatted_address"] else { (print("Problem unwrapping restaurantAddress")); return }
//        print("This is the restaurant address \(restaurantAddress)")
//        
        let restaurantGeometryDict = dictionary["geometry"] as! restaurantDictionary
        //print("This is the restaurant geometryDict \(restaurantGeometryDict)")
        
        let restaurantLatLongDict = restaurantGeometryDict["location"] as! restaurantDictionary
        //print("This is the restaurant latlongDict \(restaurantLatLongDict)")
        
        if let uLatitude = restaurantLatLongDict["lat"] as? Double? {
            latitude = uLatitude
            print("This is the restaurantLat \(latitude)")
        }
        
        // textLabel.text = restaurant.name != nil ? restaurant.name! : "No name found"
        
        if let ulongitude = restaurantLatLongDict["lng"] as? Double? {
            longitude = ulongitude
            print("This is the restaurantLong \(longitude)")
        }
        
        if let uname = dictionary["name"] as? String? {
            name = uname
            print("This is the restaurant name \(name)")
        }
        
        if let restaurantDict = dictionary["opening_hours"] as? restaurantDictionary {
            if let restaurantOpenNow = restaurantDict["open_now"] as? Int {
                if restaurantOpenNow == 1{
                    self.openNow = true
                }else{
                    self.openNow = false
                    //if the restaurant is closed, we don't create a restaurant object
                    return
                }
                
                print("restaurant is open now")
            }
            
        }else{
            print("opening hours doesn't exist")
            self.openNow = false
            
        }
    
        if let uPriceLevel = dictionary["price_level"] as? Int? {
            priceLevel = uPriceLevel
            print("This is the restaurant's price level \(priceLevel)")
        }
        
        if let urestaurantRating = dictionary["rating"] as? Int? {
            restaurantRating = urestaurantRating
            print("This is the restaurant's rating \(restaurantRating)")
        }
        
        
//        name = restaurantName as! String
//        priceLevel = restaurantPriceLevel as! Int
//        //    var openNow: Int
//        latitude = restaurantLat as! Double
//        longitude = restaurantLong as! Double
//        timeStampOfLocation = restaurantRating as! Double
        
    }
    
}
