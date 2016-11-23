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
    
    var locationsArray: [Restaurant] = []
    
    var restaurantsInJSON:json!
    
    fileprivate init() {}
    
    func filterSearchedRestaurants() {
        
        guard let unwrappedRestaurantsInJSON = restaurantsInJSON else { print("problem with unwrappingRestaurantsInJSON"); return }
        
        let resultsArray = unwrappedRestaurantsInJSON["results"] as! [Any]
        print(resultsArray)
        
//        let firstArray = resultsArray[0] as! restaurantDictionary
        
        for array in resultsArray {
            let newRestaurant = Restaurant(dictionary: array as! json)
            locationsArray.append(newRestaurant)
            print("\nrestaurant array count is \(locationsArray.count)\n")
        }
        
       

//        let newLocation = Restaurant(dictionary: firstArray)
        
//        print(newLocation)
//        dump(newLocation)
//        locationsArray.append(newLocation)
//        print(locationsArray.count)
        
    }
}

