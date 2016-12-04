//
//  GetLocationViewController.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/20/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit
import CoreLocation
import GooglePlaces

class GetLocationViewController: UIViewController {
    
    let store = RestaurantDataStore.sharedInstance
    
    var placesClient: GMSPlacesClient?
    
    //TODO: - assign the lat and long to the user's location (via mapkit or google places); practice values for lat and long
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    //these are example lat and long for chelsea
//    var latitude: Double = 40.748944899999998
//    var longitude: Double = -74.0002432
    
    override func viewDidLoad() {
        print("getlocationVC is working")
        super.viewDidLoad()
        placesClient = GMSPlacesClient.shared()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        getLocation()
        
    }
    
    func getLocation() {
        print("get location func is working")
        placesClient?.currentPlace(callback: { (placeLikelihoodList, error) in
            
            if let error = error {
                print("there is an error in getlocation")
                print("this is the \(error.localizedDescription)")
                return
            }
            
            guard let placeLikelihoodList = placeLikelihoodList else { return }
            
            guard let place = placeLikelihoodList.likelihoods.first?.place else { return }
            
            let placeName = place.name
            //Place name is Public School 33
            let placeAddressComponents = place.addressComponents
            
            guard let placeAddress = place.formattedAddress?.components(separatedBy: ", ").joined(separator: "\n") else { print("Error with placeAddress"); return }
            //Place address is Optional("281 9th Ave\nNew York\nNY 10001\nUSA")
            let placeCoordinates = (place.coordinate.latitude, place.coordinate.longitude)
            //Place coordinates are (40.748944899999998, -74.0002432)
            print("Place name is \(placeName)")
            print("Place address is \(placeAddress)")
            print("Place coordinates are \(placeCoordinates)")
            self.latitude = place.coordinate.latitude
            self.longitude = place.coordinate.longitude
            
            // TODO: - this .getRestaurants call should be taking in a querySTring based on what the user has clicked in preferences
            APIClientGooglePlaces.getRestaurants(lat: self.latitude, long: self.longitude, queryString: "italian", completion: { (JSON) in
                self.store.restaurantsInJSON = JSON
                self.store.filterSearchedRestaurants()
            })
            
        })
    }
    
}
