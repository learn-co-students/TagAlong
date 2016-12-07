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
    
    var restaurantsArray: [Restaurant] = []
    
    var restaurantsInJSON:json!
    
    fileprivate init() {}
    
    func filterSearchedRestaurants() {
        print("filter searched func is working")
        guard let unwrappedRestaurantsInJSON = restaurantsInJSON else { print("problem with unwrappingRestaurantsInJSON"); return }
        let resultsArray = unwrappedRestaurantsInJSON["results"] as! [Any]
        print(resultsArray)
        
        for array in resultsArray {
            let newRestaurant = Restaurant(dictionary: array as! json)
            if newRestaurant.openNow == true {
                restaurantsArray.append(newRestaurant)
                print("\nrestaurant array count is \(restaurantsArray.count)\n")
                if restaurantsArray.isEmpty {
                    print("no restaurants open right now")
                }
            }
        }
    }
    
}

