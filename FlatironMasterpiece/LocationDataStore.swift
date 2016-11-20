//
//  LocationDataStore.swift
//  FlatironMasterpiece
//
//  Created by Elias Miller on 11/17/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//
import Foundation

typealias restaurantDictionary = [String:Any]

class LocationDataStore {
    
    static let sharedInstance = LocationDataStore()
    
    var location: [Location]!
    
    var restaurantsInJSON:json!
    
    fileprivate init() {}
    
    func filterSearchedRestaurants() {
        guard let unwrappedRestaurantsInJSON = restaurantsInJSON else { return }
        
        //make an array of dictionaries
        let resultsArray = unwrappedRestaurantsInJSON["results"] as! [Any]
        let firstArray = resultsArray[0] as! restaurantDictionary
        guard let restaurantAddress = firstArray["formatted_address"] else { return }
        let restaurantGeometryDict = firstArray["geometry"] as! restaurantDictionary
        let restaurantLatLongDict = restaurantGeometryDict["location"] as! restaurantDictionary
        guard let restaurantLat = restaurantLatLongDict["lat"] else { return }
        guard let restaurantLong = restaurantLatLongDict["long"] else { return }
        
        guard let restaurantName = firstArray["name"] else { return }
        let restaurantHoursDict = firstArray["opening_hours"] as! restaurantDictionary
        guard let restaurantOpenNow = restaurantHoursDict["open_now"] else { return }
        guard let restaurantPriceLevel = firstArray["price_level"] else { return }
        guard let restaurantRating = firstArray["rating"] else { return }
        print("This is the first array \(firstArray)")
        print("This is the restaurant address \(restaurantAddress)")
        print("This is the restaurant geometryDict \(restaurantGeometryDict)")
        print("This is the restaurant latlongDict \(restaurantLatLongDict)")
        print("This is the restaurant name \(restaurantName)")
//        print("This is the restaurant's opening_hours dict \(restaurantHoursDict)")
        print("This is the restaurant's open_now \(restaurantOpenNow)")
        print("This is the restaurant's price level \(restaurantPriceLevel)")
        print("This is the restaurant's rating \(restaurantRating)")
        
    }
}

