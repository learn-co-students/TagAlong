//
//  CardViewController.swift
//
//
//  Created by Nick Rigano on 11/23/16.
//
//

import UIKit
import ZLSwipeableViewSwift
import Cartography
import CoreLocation
import GooglePlaces


var testArray1 = ["spreads", "De Mole", "Mexican", "$$", ".4 miles", "11AM-11:30PM"]
var testArray2 = ["spreads.jpg", "Rizzo's Pizza", "Italian", "$$", ".1 miles", "11AM-10PM"]


class CardViewController: UIViewController {
    
    var swipeableView: ZLSwipeableView!
    var hasPickedRestaurant: Bool = false
    
    //erica's code
    var userStore = UsersDataStore.sharedInstance
    var restStore = RestaurantDataStore.sharedInstance
    var restaurantArray = [Restaurant]()
    //NOTE: - google places / core location properties
    var placesClient: GMSPlacesClient?
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.restaurantArray = restStore.restaurantsArray
        
        swipeableView.numberOfActiveView = UInt(restStore.restaurantsArray.count)
        swipeableView.nextView = {
            return self.nextCardView()
        }
    }
    
    let testLabel = UILabel()
    let shakeImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = phaedraOrange
        makeLabels()
        formatSwipeableView()
        print("getlocationVC is working")
        placesClient = GMSPlacesClient.shared()
        
        //NOTE: hides top nav controller
        navigationController?.isNavigationBarHidden = true
        
        print("running")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func formatSwipeableView() {
        swipeableView = ZLSwipeableView()
        swipeableView.backgroundColor = UIColor.clear
        view.addSubview(swipeableView)
        
        swipeableView.didStart = {view, location in
            print("Did start swiping view at location: \(location)")
        }
        swipeableView.swiping = {view, location, translation in
            print("Swiping at view location: \(location) translation: \(translation)")
        }
        swipeableView.didEnd = {view, location in
            print("Did end swiping view at location: \(location)")
        }
        //INCLUDE LOGIC ON SAVING SWIPED RESTAURANT
        swipeableView.didSwipe = {view, direction, vector in
            print("Did swipe view in direction: \(direction), vector: \(vector)")
            if direction.description == "Right" {
                self.hasPickedRestaurant = true
                let selectedRestVC = SelectedRestaurantViewController()
                self.navigationController?.pushViewController(selectedRestVC, animated: true)
            }
        }
        swipeableView.didCancel = {view in
            print("Did cancel swiping view")
        }
        swipeableView.didTap = {view, location in
            print("Did tap at location \(location)")
        }
        swipeableView.didDisappear = { view in
            print("Did disappear swiping view")
            
        }
        
        constrain(swipeableView, view) { view1, view2 in
            view1.left == view2.left+30
            view1.right == view2.right-30
            view1.top == view2.top + 80
            view1.bottom == view2.bottom - 60
        }

    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if(event?.subtype == UIEventSubtype.motionShake) {
            print("shaken")
                    
            var currentRandomCuisine = userStore.currentChosenCuisine
            //if the current random cuisine is not the new random cuisine
            let randomNum = Int(arc4random_uniform(UInt32(userStore.preferredCuisineArray.count)))
            if currentRandomCuisine != userStore.preferredCuisineArray[randomNum] {
                userStore.currentChosenCuisine = userStore.preferredCuisineArray[randomNum]
                print("random cuisine is: \(userStore.currentChosenCuisine)")
                getLocation()
                let shakeVC = ShakeInstructionViewController()
                self.navigationController?.pushViewController(shakeVC, animated: false)
            }
        }
    }
    
    
    
    func makeLabels() {
        view.addSubview(testLabel)
        testLabel.text = "Whoops, out of options!  Shake the app to choose a new cuisine."
        testLabel.font = UIFont(name: "OpenSans-Bold", size: 25.0)
        testLabel.textColor = phaedraYellow
        testLabel.textAlignment = .center
        testLabel.lineBreakMode = .byWordWrapping
        testLabel.numberOfLines = 6
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        testLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        testLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65).isActive = true
        
        view.addSubview(shakeImage)
        shakeImage.image = UIImage(named: "shake_yellow")
        shakeImage.translatesAutoresizingMaskIntoConstraints = false
        shakeImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.30).isActive = true
        shakeImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        shakeImage.topAnchor.constraint(equalTo: testLabel.bottomAnchor, constant: 30).isActive = true
        shakeImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    // MARK:  - this is the call to make the next card appear
    func nextCardView() -> UIView? {
    
        while restaurantArray.count != 0{
            let restaurant = restaurantArray.removeFirst()
            var cardView = CardView(restaurant: restaurant, frame: swipeableView.bounds)
            cardView.backgroundColor = phaedraYellow
            
            //NOTE: - calculates distance in km between user and the restaurant
            var distance: Double
            distance = Double(acos(sin(userStore.userLat.radians) * sin((restaurant.latitude?.radians)!) + cos(self.userStore.userLat.radians) * cos((restaurant.latitude?.radians)!) * cos(self.userStore.userLong.radians-(restaurant.longitude?.radians)!)) * 6371000 / 1000)
            print(distance)
            
            let numberOfPlaces = 2.0
            let multiplier = pow(10.0, numberOfPlaces)
            
            let rounded = round(distance * 0.621371 * multiplier) / multiplier
            print("\(restaurant.name) distance as miles \(rounded)")
 
            cardView.restDistanceLabel.text = "\(rounded) mi"

            return cardView
        }

        //if i have a next card then return view if i do not return the default cardview
        return CardView(restaurant: nil, frame: swipeableView.bounds)
    }
    
    func createDefaultCard()->CardView {
        let defaultCard = CardView(restaurant: nil, frame: swipeableView.bounds)
        swipeableView = ZLSwipeableView()
        swipeableView.backgroundColor = UIColor.red
        view.addSubview(swipeableView)
        self.view.backgroundColor = phaedraOrange
                
        swipeableView.didStart = {view, location in
            print("Did start swiping view at location: \(location)")
        }
        swipeableView.swiping = {view, location, translation in
            print("Swiping at view location: \(location) translation: \(translation)")
        }
        swipeableView.didEnd = {view, location in
            print("Did end swiping view at location: \(location)")
        }
        swipeableView.didSwipe = {view, direction, vector in
            print("Did swipe view in direction: \(direction), vector: \(vector)")
            if direction.description == "Right" {

                let selectedRestVC = SelectedRestaurantViewController()
                self.navigationController?.pushViewController(selectedRestVC, animated: true)
            }
        }
        swipeableView.didCancel = {view in
            print("Did cancel swiping view")
        }
        swipeableView.didTap = {view, location in
            print("Did tap at location \(location)")
        }
        swipeableView.didDisappear = { view in
            print("Did disappear swiping view")
            
        }
        
        // +50 -50 +120 -100
        constrain(swipeableView, view) { view1, view2 in
            view1.left == view2.left+50
            view1.right == view2.right-50
            view1.top == view2.top + 50
            view1.bottom == view2.bottom - 50
        }
        return defaultCard
    }
    

    
}

extension CardViewController {
    
    func getLocation() {
        placesClient?.currentPlace(callback: { (placeLikelihoodList, error) in
            
            if let error = error {
                print("there is an error in getlocation")
                print("this is the \(error.localizedDescription)")
                return
            }
            
            guard let placeLikelihoodList = placeLikelihoodList else { return }
            
            guard let place = placeLikelihoodList.likelihoods.first?.place else { return }
            
            let placeName = place.name
            let placeAddressComponents = place.addressComponents
            
            guard let placeAddress = place.formattedAddress?.components(separatedBy: ", ").joined(separator: "\n") else { print("Error with placeAddress"); return }
            let placeCoordinates = (place.coordinate.latitude, place.coordinate.longitude)
            self.latitude = place.coordinate.latitude
            self.longitude = place.coordinate.longitude
            print("\nplease work - getting a location")
            
            APIClientGooglePlaces.getRestaurants(lat: self.latitude, long: self.longitude, queryString: self.userStore.currentChosenCuisine, completion: { (JSON) in
                
                self.restStore.restaurantsInJSON = JSON
                self.restStore.filterSearchedRestaurants(completion: { _ in
                    // TO DO: determine whether completion will be used here.
                })
                
                print("\ngetting restaurants")
                for restaurant in self.restStore.restaurantsArray {
                    APIClientGooglePlaces.getRestImages(photoRef: restaurant.photoRef, completion: {
                        data in
                        
                        if let rawData = data {
                            print("\ngetting restaurant photos")
                            restaurant.photoImage = UIImage(data: rawData)
                        }
                    })
                }
            })
        })
    }
    
}


extension Double {
    var radians: Double {
        return self * M_PI / 180
    }
    var feet: Double {
        return self * 3280.84
    }
}

