
//
//  SelectedRestaurantViewController.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/25/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit
import MapKit
import Firebase
class SelectedRestaurantViewController: UIViewController {

    //NOTE: - dataStores
    let firebaseStore = FirebaseManager.shared
    var userStore = UsersDataStore.sharedInstance
    var restStore = RestaurantDataStore.sharedInstance
    
    var restaurantView: RestaurantView!
    var restMap: MKMapView?
    var restaurant: Restaurant?
    var emojiString = ""


    var tagalongInfo: [String: Any] = [
        "hidden" : false,
        "date" : "December 1",
        "location" : [
            "restaurant" : "Peter Luger Steak House",
            "lat" : -45,
            "long": 35
        ]
    ]
    
    var newTagAlongInfo:[String:Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantView.delegate = self
        title = "Restaurant Info"
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor.blue
        
        restaurantView.restaurant = restaurant
        restaurantView.setup(cuisine: userStore.currentChosenCuisine)
        
        self.newTagAlongInfo = [
            "hidden" : false,
            "date" : "December 1",
            "location" : [
                "restaurant" : userStore.chosenRestName,
                "lat" : -45,
                "long": 35
            ]
        ]

    }
    
    override func loadView() {
        super.loadView()
        restaurantView = RestaurantView()
        self.view = restaurantView
    }
    

//    func loadRestaurantsMap(lat: Double, long: Double) -> MKMapView {
//       restaurantView.delegate = self
//        
//        let latitude = restaurant?.latitude
//        let longitude = restaurant?.longitude
//        let coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
//        restMap?.setCenter(coordinate, animated: true)
//        
//        
//       return restMap!
//    }


//    func createTagAlong(user: String, date: Date, location: [String: Any]) -> [String: Any] {
//
//        var tagAlonginfo: [String: Any] = [
//                "host" : user,
//                 "location" : location,
//                 "date-time" : date,
//        ]
//
//        return tagAlonginfo
//    }

}

extension SelectedRestaurantViewController: RestaurantViewDelegate {

    func sendToTagAlongConfirmation() {

        
        guard let selectedRestaurant = self.restaurant else { return }
        guard let restaurantname = selectedRestaurant.name else { return }
        guard let restaurantlat = selectedRestaurant.latitude else { return}
        guard let restaurantlong = selectedRestaurant.longitude else { return }
        
        var tagalongDict: [String: Any] = [
            "hidden" : false,
            "date" : "\(Date().timeIntervalSinceNow)",
            "location" : [
                "restaurant" : "\(restaurantname)",
                "lat" : restaurantlat,
                "long": restaurantlong
            ]
        ]

        let confirmTagAlongAlert = UIAlertController(title: "Confirm", message: "Click \"OK\" to confirm that you want to host a Tag Along", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            print("User clicked cancel")
        })
        let confirmAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            print("confirm tapped")
            print("hey there before createtagalong")
            tagalongDict["user"] = self.firebaseStore.currentUser.userID
            print("UserId - \(self.firebaseStore.currentUser.userID)")
            
            
            
            
            
            FirebaseManager.createTagAlong(with: tagalongDict, completion: { (key) in
                
                guard let newKey = key else { return }

                print("------------------- IS BEING CALLED ------------------------")

                self.firebaseStore.selectedTagAlongID = newKey
                
                // Add tagalong key to chat

                FirebaseManager.createChatWithTagID(key: newKey)
                
                print("Chat ID Being created")

                // Add tagalong key to users (current tagalong and tagalongs)
                FirebaseManager.updateUserWithTagAlongKey(key: newKey)
                
                let searchingVC = SearchingForTagAlongViewController()
                self.navigationController?.pushViewController(searchingVC, animated: true)
                
            })

        })
        confirmTagAlongAlert.addAction(cancelAction)
        confirmTagAlongAlert.addAction(confirmAction)
        self.present(confirmTagAlongAlert, animated: true, completion: nil)
    }

    func sendToDeckView() {
        let shakeInstVC = ShakeInstructionViewController()
        self.navigationController?.pushViewController(shakeInstVC, animated: true)
    }

}


