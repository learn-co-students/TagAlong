

//
//  PracticeViewController.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/20/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit
import FirebaseAuth
import CoreLocation
import GooglePlaces

class PreferenceViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout {

    


    
    //NOTE: - UI properties

    let phaedraDarkGreen = UIColor(red:0.00, green:0.64, blue:0.53, alpha:1.0)
    let phaedraOliveGreen = UIColor(red:0.47, green:0.74, blue:0.56, alpha:1.0)
    let phaedraLightGreen = UIColor(red:0.75, green:0.92, blue:0.62, alpha:1.0)
    let phaedraYellow = UIColor(red:1.00, green:1.00, blue:0.62, alpha:1.0)
    let phaedraOrange = UIColor(red:1.00, green:0.38, blue:0.22, alpha:1.0)
    
    let store = UsersDataStore.sharedInstance

    
    var usersCuisineSelectionsArray:[String] = []
    



    var preferencesLabel = UILabel()
    var budgetLabel = UILabel()
    var dineWithCompanyLabel = UILabel()
    var dineWithCompanySwitch = UISwitch()
    var replayTutorialButton: UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 30))
    var logoutButton: UIButton = UIButton(frame: CGRect(x: 100, y: 500, width: 100, height: 30))
    var cuisinePreferencesLabel = UILabel()
    var cuisineCollectionView:UICollectionView!
    let cuisineReuseIdentifier = "Cuisine Cell"
    var savePreferencesButton = UIButton(frame: CGRect(x: 100, y: 200, width: 100, height: 30))
    
    let cuisineImage:[UIImage] = [UIImage(named: "American")!, UIImage(named:"Asian")!, UIImage(named: "Healthy")!, UIImage(named: "Italian")!, UIImage(named: "Latin3x")!, UIImage(named: "Unhealthy2x")!]
  //  let cuisineImage = [UIImage(named: "Asian")!]
    
    let cuisineArray:[String] = ["american", "asian", "healthy", "italian", "latin", "unhealthy"]
    

    //NOTE: - user and rest properties
    let userStore = UsersDataStore.sharedInstance
    
    var randomCuisine  = ""
    let restStore = RestaurantDataStore.sharedInstance
    
    //NOTE: - google places / core location properties
    var placesClient: GMSPlacesClient?
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    //these are example lat and long for chelsea
    //    var latitude: Double = 40.748944899999998
    //    var longitude: Double = -74.0002432
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = phaedraBeige
        createSegmentedController()
        layoutCuisineCollectionView()
        formatButtons()
        formatLabels()


        
        print("getlocationVC is working")
        placesClient = GMSPlacesClient.shared()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()


    }
    
    func formatLabels() {
        view.addSubview(preferencesLabel)
        preferencesLabel.text = "PREFERENCES"
        preferencesLabel.font = UIFont(name: "OpenSans-Bold", size: 20.0)
        preferencesLabel.textColor = phaedraOrange
        preferencesLabel.textAlignment = .center
        preferencesLabel.translatesAutoresizingMaskIntoConstraints = false
        preferencesLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        preferencesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        preferencesLabel.specialConstrain(to: view)
        
        view.addSubview(budgetLabel)
        budgetLabel.text = "Choose your budget"
        budgetLabel.font = UIFont(name: "OpenSans-Light", size: 16.0)
        budgetLabel.textColor = phaedraOrange
        budgetLabel.textAlignment = .center
        budgetLabel.translatesAutoresizingMaskIntoConstraints = false
        budgetLabel.topAnchor.constraint(equalTo: preferencesLabel.bottomAnchor, constant: 10).isActive = true
        budgetLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        view.addSubview(cuisinePreferencesLabel)
        cuisinePreferencesLabel.text = "Choose Your Cuisines"
        cuisinePreferencesLabel.font = UIFont(name: "OpenSans-Light", size: 16.0)
        cuisinePreferencesLabel.textColor = phaedraOrange
        cuisinePreferencesLabel.textAlignment = .center
        cuisinePreferencesLabel.translatesAutoresizingMaskIntoConstraints = false
        cuisinePreferencesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cuisinePreferencesLabel.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 165).isActive = true
    }
    
    
    func createSegmentedController() {
        let budgetArray:[String] = ["💰", "💰💰", "💰💰💰", "💰💰💰💰"]
        let budgetSC = UISegmentedControl(items: budgetArray)
        budgetSC.selectedSegmentIndex = 0
        budgetSC.frame = CGRect.zero
        budgetSC.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Avenir Next", size: 12.0)! ], for: .normal)
        budgetSC.layer.cornerRadius = 5
        budgetSC.backgroundColor = phaedraLightGreen
        budgetSC.tintColor = phaedraDarkGreen
        budgetSC.addTarget(self, action: #selector(printChosenBudget(sender:)), for: .valueChanged)
        self.view.addSubview(budgetSC)
        budgetSC.translatesAutoresizingMaskIntoConstraints = false
        budgetSC.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 125).isActive = true
        budgetSC.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        budgetSC.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        budgetSC.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85).isActive = true
    }
    
    
    func layoutCuisineCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 90, height: 90)
        cuisineCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        cuisineCollectionView.delegate = self
        cuisineCollectionView.dataSource = self
        cuisineCollectionView.register(CuisineCollectionViewCell.self, forCellWithReuseIdentifier: cuisineReuseIdentifier)
        cuisineCollectionView.backgroundColor = phaedraDarkGreen
        view.addSubview(cuisineCollectionView)
        
        cuisineCollectionView.translatesAutoresizingMaskIntoConstraints = false
        cuisineCollectionView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 185).isActive = true
        cuisineCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cuisineCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.30).isActive = true
        cuisineCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95).isActive = true
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cuisineArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cuisineReuseIdentifier, for: indexPath) as! CuisineCollectionViewCell
        
        cell.imageView.image = cuisineImage[indexPath.item]
        cell.foodLabel.text = cuisineArray[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Hey SELECTING ME!!")
        let selectedCuisine = cuisineArray[indexPath.row]
        
        //Johann start
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }

        if userStore.preferredCuisineArray.contains(selectedCuisine) {
            
            cell.toggledSelectedState()
            
            let index = userStore.preferredCuisineArray.index(of: selectedCuisine)
            guard let unwrappedindex = index else { return }
            
            userStore.preferredCuisineArray.remove(at: unwrappedindex)
            UserDefaults.standard.set(userStore.preferredCuisineArray, forKey: "UserCuisineArray")
            print("array is now \(userStore.preferredCuisineArray)")


        }else{
            if cell.isHighlighted == false {
                userStore.preferredCuisineArray.append(selectedCuisine)
                UserDefaults.standard.set(userStore.preferredCuisineArray, forKey: "UserCuisineArray")
                print("array is now \(userStore.preferredCuisineArray)")
                cell.isHighlighted = true
                cell.toggledSelectedState()
            }
        }
        // Johann end
    }
    
    func printChosenBudget(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            UserDefaults.standard.set(1, forKey: "Budget")
            print("user chose 💰")
        case 1:
            UserDefaults.standard.set(2, forKey: "Budget")
            print("user chose 💰💰")
        case 2:
            UserDefaults.standard.set(3, forKey: "Budget")
            print("user chose 💰💰💰")
        case 3:
            UserDefaults.standard.set(4, forKey: "Budget")
            print("user chose 💰💰💰💰")
        default:
            print("user chose 💰💰")
        }
    }
    
    func formatButtons() {
        
        view.addSubview(replayTutorialButton)
        replayTutorialButton.backgroundColor = phaedraLightGreen
        replayTutorialButton.layer.cornerRadius = 5
        replayTutorialButton.layer.borderWidth = 1
        replayTutorialButton.layer.borderColor = phaedraDarkGreen.cgColor
        replayTutorialButton.setTitle("Replay Tutorial", for: UIControlState.normal)
        replayTutorialButton.setTitle("Tutorial Played", for: .highlighted)
        replayTutorialButton.titleLabel?.font = UIFont(name: "OpenSans-Light", size: 12.0)
        replayTutorialButton.titleLabel?.textAlignment = .center
        replayTutorialButton.translatesAutoresizingMaskIntoConstraints = false
        replayTutorialButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 390).isActive = true
        replayTutorialButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        replayTutorialButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        replayTutorialButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.30).isActive = true
        replayTutorialButton.addTarget(self, action: #selector(deleteUser), for: .touchUpInside)
        replayTutorialButton.setTitleColor(phaedraDarkGreen, for: .normal)
        replayTutorialButton.setTitleColor(phaedraYellow, for: .highlighted)
        
        view.addSubview(logoutButton)
        logoutButton.backgroundColor = phaedraOrange
        logoutButton.layer.cornerRadius = 5
        logoutButton.layer.borderWidth = 1
        logoutButton.layer.borderColor = phaedraDarkGreen.cgColor
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.titleLabel?.font = UIFont(name: "OpenSans-Light", size: 12.0)
        logoutButton.titleLabel?.textAlignment = .center
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
        logoutButton.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 460).isActive = true
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoutButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15).isActive = true
        logoutButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        logoutButton.addTarget(self, action: #selector(logoutUser), for: .touchUpInside)
        logoutButton.setTitleColor(phaedraYellow, for: .normal)
        logoutButton.setTitleColor(phaedraLightGreen, for: .highlighted)
        view.addSubview(replayTutorialButton)
        
        view.addSubview(savePreferencesButton)
        savePreferencesButton.backgroundColor = phaedraLightGreen
        savePreferencesButton.layer.cornerRadius = 5
        savePreferencesButton.layer.borderColor = phaedraDarkGreen.cgColor
        savePreferencesButton.layer.borderWidth = 1
        savePreferencesButton.setTitle("Save Preferences", for: .normal)
        savePreferencesButton.titleLabel?.font = UIFont(name: "OpenSans-Light", size: 14.0)
        savePreferencesButton.titleLabel?.textAlignment = .center
        savePreferencesButton.translatesAutoresizingMaskIntoConstraints = false
        savePreferencesButton.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 520).isActive = true
        savePreferencesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        savePreferencesButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.40).isActive = true
        savePreferencesButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        savePreferencesButton.addTarget(self, action: #selector(savePreferences), for: .touchUpInside)
        savePreferencesButton.setTitleColor(phaedraDarkGreen, for: .normal)
        savePreferencesButton.setTitleColor(phaedraYellow, for: .highlighted)
        
    }
    
    // MARK: - selector functions for buttons
    
    // TODO: - write function that displays replayTutorial
    func deleteUser() {
        let user = FIRAuth.auth()?.currentUser
        print(user)
        user?.delete { error in
            if let error = error {
                // An error happened.
            } else {
                // Account deleted.
            }
        }
        print("User deleted")
    }
    
    func replayTutorial() {
        print("Replay tutorial requested.")
    }
    
    // TODO: - write function that logs user out of the app
    func logoutUser() {
        print("User tapped button to logout.")
        
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            print("successfully logged out of firebase")
        } catch {
            print("Logout of app error")
        }
        
        let loginVC = LogInViewController()
        let nav = UINavigationController(rootViewController: loginVC)
        self.present(nav, animated: true, completion: nil)
        
    }

    func savePreferences() {
         getLocation()
        print("Save preferences tapped")
        // Send to shake instruction view controller
        let user = FIRAuth.auth()?.currentUser
        guard let unwrappedUser = user else { return }
        print(unwrappedUser)
        if   FIRAuth.auth()?.currentUser != nil {
            
        }

        print("Save preferences tapped")
        let saved = store.preferredCuisineArray
        
        var dict = [String: Any]()
        for save in saved{
            dict[save] = true
        }
   
        FirebaseManager.savePref(dictionary: dict)
        
        print(store.preferredCuisineArray)
        self.getRandomCuisine()
        
        let shakeInstructionVC = ShakeInstructionViewController()
        self.navigationController?.pushViewController(shakeInstructionVC, animated: true)
        
    }
    

        
    
        
    
        
//end of class

}
extension PreferenceViewController {
    
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
        
            APIClientGooglePlaces.getRestaurants(lat: self.latitude, long: self.longitude, queryString: self.randomCuisine, completion: { (JSON) in
                self.restStore.restaurantsInJSON = JSON
                self.restStore.filterSearchedRestaurants()
            })
            
            
            
        })
    }

    func getRandomCuisine()->String {
        
        let randomNum = Int(arc4random_uniform(UInt32(userStore.preferredCuisineArray.count)))
//        for rest in userStore.preferredCuisineArray {
//            randomRest =
//        }
        randomCuisine = userStore.preferredCuisineArray[randomNum]
        print("random cuisine is: \(randomCuisine)")
        return randomCuisine
    }

}

