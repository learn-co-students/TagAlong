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
import AudioToolbox
import AVFoundation

class ShakeInstructionViewController: UIViewController {
 
    var shakeView: ShakeView!

    var shakeNosie: AVAudioPlayer?
    var vview: UIView!

    //NOTE: - google places / core location properties
    var placesClient: GMSPlacesClient?
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    let restStore = RestaurantDataStore.sharedInstance
    let userStore = UsersDataStore.sharedInstance

    override func viewDidLoad() {
        
        super.viewDidLoad()
        vview = ShakeView()
        view.backgroundColor = UIColor.blue

        self.shakeView.activityIndicator.startAnimating()
        
        print("getlocationVC is working")
        placesClient = GMSPlacesClient.shared()

        if view == vview {
            vibrate()
            playSound()
        }
        playSound()

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
    
    
    func setupAudioPlayerWithFile(file: String, type: String) -> AVAudioPlayer? {
        let path = Bundle.main.path(forResource: file as String, ofType: type as String)
        let url = URL(fileURLWithPath: path!)
        
        var audioPlayer: AVAudioPlayer?
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url)
        } catch {
            print("Nothing to play")
        }
        return audioPlayer
    }
    
    func loadPlayer() {
        if let shakeNosie = self.setupAudioPlayerWithFile(file: "SprayShake", type: "mp3") {
            self.shakeNosie = shakeNosie
            
        }
        self.shakeNosie?.volume = 1.0
        self.shakeNosie?.play()
    }
    
    func playSound() {
       loadPlayer()
    }
    func vibrate() {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
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
            print("please work")
            
            APIClientGooglePlaces.getRestaurants(lat: self.latitude, long: self.longitude, queryString: self.userStore.currentChosenCuisine, completion: { (JSON) in
                
                print("in shake instructionVC - queryString is \(self.userStore.currentChosenCuisine)")
                self.restStore.restaurantsInJSON = JSON
                print("this is the json \(self.restStore.restaurantsInJSON)")
                self.restStore.filterSearchedRestaurants()
                
                print("getting restaurants")
                for restaurant in self.restStore.restaurantsArray {
                    APIClientGooglePlaces.getRestImages(photoRef: restaurant.photoRef, completion: {
                        data in
                        
                        print("\n\n WE came back and we don't know whats up yete.")
                        
                        if let rawData = data {
                            
                            print("\n\n")
                            
                            print("We have raw data")
                            
                            restaurant.photoImage = UIImage(data: rawData)
                            
                        }
                    })
                }
              })
        })
    }

    
    
   
    
}
