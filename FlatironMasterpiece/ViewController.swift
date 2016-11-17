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
    
    let store = DataStore.sharedInstance
    
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
        getLocation { (latitude, longitude) in
            self.latitude = latitude
            self.longitude = longitude
 
            print("data store lat is \(latitude) and data store long is \(longitude)")
        }
        APIClientGooglePlaces.getRestaurants(lat: latitude, long: longitude)
        
    }
 
    @IBAction func getCurrentPlaceBtnPressed(_ sender: UIButton) {
    }
    
    func getLocation(_ completion:@escaping (Double, Double)->Void) {
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
            completion(place.coordinate.latitude, place.coordinate.longitude)
            print("Place name is \(placeName)")
            print("Place address is \(placeAddress)")
            print("Place coordinates are \(placeCoordinates)")
         })
     }

}

