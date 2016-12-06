//
//  ShakeInstructionViewController.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/22/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit
import CoreLocation
import GooglePlaces

class ShakeInstructionViewController: UIViewController {
 
    var shakeView: ShakeView!
    
    //NOTE: - google places / core location properties
    var placesClient: GMSPlacesClient?
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    let restStore = RestaurantDataStore.sharedInstance
    let userStore = UsersDataStore.sharedInstance
    
    //these are example lat and long for chelsea
    //    var latitude: Double = 40.748944899999998
    //    var longitude: Double = -74.0002432

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        self.shakeView.activityIndicator.startAnimating()
        
        print("getlocationVC is working")
        placesClient = GMSPlacesClient.shared()
    }

    override func loadView() {
        super.loadView()
        shakeView = ShakeView()
        self.view = shakeView
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //ERICA'S CODE - should this go here?
        
        getLocation()
        
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if(event?.subtype == UIEventSubtype.motionShake) {
            print("shaken")
            
            //TODO: 1) segue to deck view 2) have the phone vibrate/pulsate 3) shaking sounds
            let deckView = CardViewController()
            self.navigationController?.pushViewController(deckView, animated: false)
        }
    }


}

extension ShakeInstructionViewController {
    
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
            
            APIClientGooglePlaces.getRestaurants(lat: self.latitude, long: self.longitude, queryString: self.userStore.currentChosenCuisine, completion: { (JSON) in
                self.restStore.restaurantsInJSON = JSON
                self.restStore.filterSearchedRestaurants()
            })
            
        })
    }
    
   
    
}
