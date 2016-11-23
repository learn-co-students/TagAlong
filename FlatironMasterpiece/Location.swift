//
//  Restaurant.swift
//  FlatironMasterpiece
//
//  Created by Elias Miller on 11/15/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import Foundation

class Restaurant {
    var name: String?
    var priceLevel: Int?
    var openNow: Int?
    var latitude: Double?
    var longitude: Double?
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
        
        
        let restaurantHoursDict = dictionary["opening_hours"] as! restaurantDictionary
        //print("This is the restaurant's opening_hours dict \(restaurantHoursDict)")
    
        guard let restaurantOpenNow = restaurantHoursDict["open_now"] else { print("There is no restaurant hours array."); return }
        print("This is the restaurant's open_now \(restaurantOpenNow)")
        
        guard let restaurantPriceLevel = dictionary["price_level"] else { return }
        print("This is the restaurant's price level \(restaurantPriceLevel)")
        
        guard let restaurantRating = dictionary["rating"] else { return }
        print("This is the restaurant's rating \(restaurantRating)")
        
        name = restaurantName as! String
        priceLevel = restaurantPriceLevel as! Int
        //    var openNow: Int
        latitude = restaurantLat as! Double
        longitude = restaurantLong as! Double
        timeStampOfLocation = restaurantRating as! Double
        
    }
    
}
