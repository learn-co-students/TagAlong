//
//  ViewController.swift
//  FlatironMasterpiece
//
//  Created by Elias Miller on 11/14/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit
import CoreLocation
import GooglePlaces


class ViewController: UIViewController {
    
    var placesClient: GMSPlacesClient?
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placesClient = GMSPlacesClient.shared()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        //you have to start
        locationManager.startUpdatingLocation()
//        getLocation { (placelatitude, placelongitude) in
//            self.latitude = placelatitude
//            self.longitude = placelongitude
// 
//            print("data store lat is \(placelatitude) and data store long is \(placelongitude)")
//        }
        getLocation()
        
        print("latitude is \(self.latitude)")
        
    }
    
    func getLocation() {
        print("working after button pressed")
        placesClient?.currentPlace(callback: { (placeLikelihoodList, error) in
            
            if let error = error {
                print("pick place error:\(error.localizedDescription)")
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
            print("self.latitude is \(self.latitude)")
            self.latitude = place.coordinate.latitude
            self.longitude = place.coordinate.longitude
            APIClientGooglePlaces.getRestaurants(lat: self.latitude, long: self.longitude)
            print("latitude is NOW \(self.latitude)")
//            completion(place.coordinate.latitude, place.coordinate.longitude)
            
         })
     }

}

