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
    
    // TODO: error handling for incompletion
    func filterSearchedRestaurants(completion: @escaping (Bool)->()) {

        restaurantsArray.removeAll()
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
        print("restaurants array size is \(restaurantsArray.count)")
        print("completed creating restaurants array")
        completion(true)
        
    }
    
}

