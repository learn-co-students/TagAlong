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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        placesClient = GMSPlacesClient.shared()
        print("working")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        //you have to start
        locationManager.startUpdatingLocation()
        
    }
 
    @IBAction func getCurrentPlaceBtnPressed(_ sender: UIButton) {
        print("working after button pressed")
        placesClient?.currentPlace(callback: { (placeLikelihoodList, error) in
            if let error = error {
                print("pick place error:\(error.localizedDescription)")
                return
            }
            if let placeLikelihoodList = placeLikelihoodList {
                let place = placeLikelihoodList.likelihoods.first?.place
                if let place = place {
                    let placeName = place.name
                    let placeAddressComponents = place.addressComponents
                    let placeAddress = place.formattedAddress?.components(separatedBy: ", ").joined(separator: "\n")
                    let placeCoordinates = (place.coordinate.latitude, place.coordinate.longitude)
                
                    print("Place name is \(placeName)")
                    print("Place address is \(placeAddress)")
                    print("Place coordinates are \(placeCoordinates)")
                    
                }
            }
            
        })
        

//            
//            self.nameLabel.text = "No current place"
//            self.addressLabel.text = ""
//            
//            if let placeLikelihoodList = placeLikelihoodList {
//                let place = placeLikelihoodList.likelihoods.first?.place
//                if let place = place {
//                    self.nameLabel.text = place.name
//                    self.addressLabel.text = place.formattedAddress!.componentsSeparatedByString(", ")
//                        .joinWithSeparator("\n")
//                }
//            }
//        })
    }
        
        
        
        
//        
//        
//        placesClient?.currentPlace(callback: {
//            (placeLikelihoodList: GMSPlaceLikelihoodList?, error: NSError?) -> Void in
//            if let error = error {
//                print("Pick Place error: \(error.localizedDescription)")
//                return
//            }
//            
//            if let placeLikelihoodList = placeLikelihoodList {
//                let place = placeLikelihoodList.likelihoods.first?.place
//                if let place = place {
//                    let placeName = place.name
//                    let placeAddress = place.formattedAddress?.components(separatedBy: ", ").joined(separator: "\n")
//                    
//                    print("The placeName: \(placeName)\n")
//                    print("The placeAddress: \(placeAddress)")
//                    
//                }
//            }
//        } as! GMSPlaceLikelihoodListCallback)
//    }
    
    
    


}

