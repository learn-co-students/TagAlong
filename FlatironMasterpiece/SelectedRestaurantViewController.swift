
//
//  SelectedRestaurantViewController.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/25/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit
import MapKit
class SelectedRestaurantViewController: UIViewController {

    let store = FirebaseManager.shared
    
    var restaurantView: RestaurantView!
    var userStore = UsersDataStore.sharedInstance
    var restStore = RestaurantDataStore.sharedInstance
    var restMap: MKMapView?
    var restaurant: Restaurant?
    var emojiString = ""
    
    // Information needed from Deck View
    var user: String?
    var date: Date?
    var location: [String: Any]?

    // Dummy Data
    var user1 = FirebaseManager.currentUser
    var date1 = Date()
    var location1: [String: Any] = [
        "restaurant" : "Peter Lugar's", // UsersDataStore.sharedInstance.chosenRestName
        "lat" : -45,                    // chosenRestLong
        "long": 35                      //chosenRestLat
    ]

//    var tagalongInfoDict: [String: Any] [
//        "user" : self.user1,
//        "date" : self.date1,
//        "location" : self.location1
//    ]

    var tagalongInfo: [String: Any] = [
        "user" : FirebaseManager.currentUser,
        "hidden" : false,
        "date" : "December 1",
        "location" : [
            "restaurant" : "Peter Luger Stake House",
            "lat" : -45,
            "long": 35
        ]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantView.delegate = self
        title = "Restaurant Info"
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor.blue
        
        restaurantView.restaurant = restaurant
        restaurantView.setup(cuisine: userStore.currentChosenCuisine)

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

        let confirmTagAlongAlert = UIAlertController(title: "Confirm", message: "Click \"OK\" to confirm that you want to host a Tag Along", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            print("User clicked cancel")
        })
        let confirmAction = UIAlertAction(title: "Confirm", style: .default, handler: { (action) in
            //TODO:
            print("confirm tapped")
            print("hey there before createtagalong")
            
            FirebaseManager.createTagAlong(with: self.tagalongInfo, completion: { (key) in
                
                guard let newKey = key else { return }

                print("------------------- IS BEING CALLED ------------------------")

                self.store.selectedTagAlongID = newKey
                
                // Add tagalong key to chat
        
                FirebaseManager.createChatWithTagID(key: newKey)
                
                
                
                print("Chat ID Being created")

                // Add tagalong key to users (current tagalong and tagalongs)
                FirebaseManager.updateUserWithTagAlongKey(key: newKey)
                
                let searchingVC = SearchingForTagAlongViewController()
                self.navigationController?.pushViewController(searchingVC, animated: true)
                
            })

            // Testing Chat - should segue to

//            let chatVC = ChatViewController()
//            self.navigationController?.present(chatVC, animated: true, completion: nil)
////

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


