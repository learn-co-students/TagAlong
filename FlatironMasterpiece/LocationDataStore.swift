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
        
        guard let unwrappedRestaurantsInJSON = restaurantsInJSON else { print("problem with unwrappingRestaurantsInJSON"); return }
        
        //make an array of dictionaries
        let resultsArray = unwrappedRestaurantsInJSON["results"] as! [Any]
        
        let firstArray = resultsArray[0] as! restaurantDictionary
        
        guard let restaurantAddress = firstArray["formatted_address"] else { (print("Problem unwrapping restaurantAddress")); return }
        print("This is the restaurant address \(restaurantAddress)")
        
        let restaurantGeometryDict = firstArray["geometry"] as! restaurantDictionary
        //print("This is the restaurant geometryDict \(restaurantGeometryDict)")
        
        let restaurantLatLongDict = restaurantGeometryDict["location"] as! restaurantDictionary
        //print("This is the restaurant latlongDict \(restaurantLatLongDict)")
        
        guard let restaurantLat = restaurantLatLongDict["lat"] else { return }
        guard let restaurantLong = restaurantLatLongDict["lng"] else { return }
        print("This is the restaurantLat \(restaurantLat)")
        print("This is the restaurantLong \(restaurantLong)")
        
        guard let restaurantName = firstArray["name"] else { return }
        print("This is the restaurant name \(restaurantName)")
        let restaurantHoursDict = firstArray["opening_hours"] as! restaurantDictionary
        //print("This is the restaurant's opening_hours dict \(restaurantHoursDict)")
        guard let restaurantOpenNow = restaurantHoursDict["open_now"] else { return }
        
        print("This is the restaurant's open_now \(restaurantOpenNow)")
        guard let restaurantPriceLevel = firstArray["price_level"] else { return }
        print("This is the restaurant's price level \(restaurantPriceLevel)")
        guard let restaurantRating = firstArray["rating"] else { return }
        print("This is the restaurant's rating \(restaurantRating)")
        
        let newLocation = Location(name: restaurantName as! String, priceLevel: restaurantPriceLevel as! Int, latitude: restaurantLat as! Double, longitude: restaurantLong as! Double, timeStampOfLocation: restaurantRating as! Double)
        
        location.append(newLocation)
        
        
        
        
        
        
        
    }
}

