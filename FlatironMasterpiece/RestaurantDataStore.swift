//
//  LocationDataStore.swift
//  FlatironMasterpiece
//
//  Created by Elias Miller on 11/17/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//
import Foundation

typealias restaurantDictionary = [String:Any]

class RestaurantDataStore {
    
    static let sharedInstance = RestaurantDataStore()
    
    var locationsArray: [Restaurant] = []
    
    var restaurantsInJSON:json!
    
    fileprivate init() {}
    
    func filterSearchedRestaurants() {
        
        guard let unwrappedRestaurantsInJSON = restaurantsInJSON else { print("problem with unwrappingRestaurantsInJSON"); return }
        
        let resultsArray = unwrappedRestaurantsInJSON["results"] as! [Any]
        print(resultsArray)
        
        for array in resultsArray {
            let newRestaurant = Restaurant(dictionary: array as! json)
            locationsArray.append(newRestaurant)
            dump(locationsArray)
            print("\nrestaurant array count is \(locationsArray.count)\n")
        }
    
        
    }
}

