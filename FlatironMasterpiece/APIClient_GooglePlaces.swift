//
//  APIClient.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/15/16.
//  Copyright © 2016 Erica Millado. All rights reserved.
//

import UIKit
import GooglePlaces

class APIClient_GooglePlaces {

    //MARK: to get a current Google Place
    
    var placesClient: GMSPlacesClient?
    
    //this function should be called by a current place (perhaps when a user clicks "OK" to authorize their location)
    func getCurrentPlace() {
        placesClient?.currentPlace(callback: {
            (placeLikelihoodList: GMSPlaceLikelihoodList?, error: NSError?) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            if let placeLikelihoodList = placeLikelihoodList {
                let place = placeLikelihoodList.likelihoods.first?.place
                if let place = place {
                    print("the place is \(place)")
                    print("the address is \(place.formattedAddress?.components(separatedBy: ", ").joined(separator: "\n"))")
                }
            }
        } as! GMSPlaceLikelihoodListCallback)
    }
}

