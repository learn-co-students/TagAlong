//
//  PreferenceViewController.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/20/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//
import UIKit
import FirebaseAuth

class PreferenceViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout {
    
    //NOTE: - UI properties
    let phaedraDarkGreen = UIColor(red:0.00, green:0.64, blue:0.53, alpha:1.0)
    let phaedraOliveGreen = UIColor(red:0.47, green:0.74, blue:0.56, alpha:1.0)
    let phaedraLightGreen = UIColor(red:0.75, green:0.92, blue:0.62, alpha:1.0)
    let phaedraYellow = UIColor(red:1.00, green:1.00, blue:0.62, alpha:1.0)
    let phaedraOrange = UIColor(red:1.00, green:0.38, blue:0.22, alpha:1.0)
    let store = UsersDataStore.sharedInstance
    
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
    
    let cuisineArray:[String] = ["American", "Asian", "Healthy", "Italian", "Latin", "Unhealthy"]
    
    //NOTE: - userStore properties
    let userStore = UsersDataStore.sharedInstance
    var usersCuisineSelectionsArray:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = phaedraBeige
        
        //NOTE: hides top navController
        self.title = "Preferences"
        navigationController?.isNavigationBarHidden = true
        createSegmentedController()
        layoutCuisineCollectionView()
        formatButtons()
        formatLabels()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func formatLabels() {
        view.addSubview(preferencesLabel)
        preferencesLabel.text = "PREFERENCES"
        preferencesLabel.font = UIFont(name: "OpenSans-Bold", size: 20.0)
        preferencesLabel.textColor = phaedraOrange
        preferencesLabel.textAlignment = .center
        preferencesLabel.translatesAutoresizingMaskIntoConstraints = false
        preferencesLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        preferencesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        preferencesLabel.specialConstrain(to: view)
        
        view.addSubview(budgetLabel)
        budgetLabel.text = "Choose your budget"
        budgetLabel.font = UIFont(name: "OpenSans-Bold", size: 16.0)
        budgetLabel.textColor = phaedraOrange
        budgetLabel.textAlignment = .center
        budgetLabel.translatesAutoresizingMaskIntoConstraints = false
        budgetLabel.topAnchor.constraint(equalTo: preferencesLabel.bottomAnchor, constant: 5).isActive = true
        budgetLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        view.addSubview(cuisinePreferencesLabel)
        cuisinePreferencesLabel.text = "Choose at least 2 cuisines"
        cuisinePreferencesLabel.font = UIFont(name: "OpenSans-Light", size: 16.0)
        
        cuisinePreferencesLabel.textColor = phaedraOrange
        cuisinePreferencesLabel.textAlignment = .center
        cuisinePreferencesLabel.translatesAutoresizingMaskIntoConstraints = false
        cuisinePreferencesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cuisinePreferencesLabel.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 145).isActive = true
    }
    
    
    func createSegmentedController() {
        let budgetArray:[String] = ["💰", "💰💰", "💰💰💰", "💰💰💰💰"]
        let budgetSC = UISegmentedControl(items: budgetArray)
        budgetSC.selectedSegmentIndex = 0
        budgetSC.frame = CGRect.zero
        budgetSC.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Avenir Next", size: 12.0)! ], for: .normal)
        budgetSC.layer.cornerRadius = 5
        budgetSC.layer.borderWidth = 2
        budgetSC.layer.borderColor = phaedraDarkGreen.cgColor
        budgetSC.backgroundColor = phaedraLightGreen
        budgetSC.tintColor = phaedraDarkGreen
        budgetSC.addTarget(self, action: #selector(printChosenBudget(sender:)), for: .valueChanged)
        self.view.addSubview(budgetSC)
        budgetSC.translatesAutoresizingMaskIntoConstraints = false
        //       budgetSC.topAnchor.constraint(equalTo: budgetLabel.bottomAnchor, constant: 20).isActive = true
        budgetSC.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 100).isActive = true
        budgetSC.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        budgetSC.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        budgetSC.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85).isActive = true
    }
    
    
    func layoutCuisineCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 86, height: 86)
        
        cuisineCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        cuisineCollectionView.delegate = self
        cuisineCollectionView.dataSource = self
        cuisineCollectionView.register(CuisineCollectionViewCell.self, forCellWithReuseIdentifier: cuisineReuseIdentifier)
        cuisineCollectionView.backgroundColor = phaedraLightGreen
        view.addSubview(cuisineCollectionView)
        cuisineCollectionView.layer.cornerRadius = 5
        cuisineCollectionView.layer.borderWidth = 2
        cuisineCollectionView.layer.borderColor = phaedraDarkGreen.cgColor
        
        cuisineCollectionView.translatesAutoresizingMaskIntoConstraints = false
        cuisineCollectionView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 170).isActive = true
        cuisineCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cuisineCollectionView.heightAnchor.constraint(equalToConstant: 225).isActive = true
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
        
        //this gets back the cuisines from the
        let ustoredUserCuisines = UserDefaults.standard.stringArray(forKey: "UserCuisineArray") ?? [""]
        print("this is user defaults cuisines \(ustoredUserCuisines)")
        self.userStore.preferredCuisineArray = ustoredUserCuisines
        print("the userstore.preferredCuisineArray is set to the userdefaultscuisineArray and is now \(self.userStore.preferredCuisineArray)")
        for cuisine in ustoredUserCuisines {
            
            if cuisineArray[indexPath.item] == cuisine {
                cell.alpha = 1.0
                cell.layer.borderColor = phaedraOrange.cgColor
                cell.layer.borderWidth = 4
                cell.layer.cornerRadius = 43
            }
        }
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
            print("userdefaults cuisines array is now \(userStore.preferredCuisineArray)")
            
            
        }else{
            if cell.isHighlighted == false {
                userStore.preferredCuisineArray.append(selectedCuisine)
                UserDefaults.standard.set(userStore.preferredCuisineArray, forKey: "UserCuisineArray")
                print("userdefaults cuisines array is now \(userStore.preferredCuisineArray)")
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
        replayTutorialButton.layer.borderWidth = 2
        replayTutorialButton.layer.borderColor = phaedraDarkGreen.cgColor
        replayTutorialButton.setTitle("Replay Tutorial", for: UIControlState.normal)
        replayTutorialButton.setTitle("Tutorial Played", for: .highlighted)
        replayTutorialButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 12.0)
        replayTutorialButton.titleLabel?.textAlignment = .center
        replayTutorialButton.translatesAutoresizingMaskIntoConstraints = false
        replayTutorialButton.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 400).isActive = true
        replayTutorialButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 40).isActive = true
        // replayTutorialButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        replayTutorialButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        replayTutorialButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        replayTutorialButton.addTarget(self, action: #selector(replayTutorial), for: .touchUpInside)
        replayTutorialButton.setTitleColor(phaedraDarkGreen, for: .normal)
        replayTutorialButton.setTitleColor(phaedraYellow, for: .highlighted)
        replayTutorialButton.isHidden = true
        
        view.addSubview(logoutButton)
        logoutButton.backgroundColor = phaedraOrange
        logoutButton.layer.cornerRadius = 5
        logoutButton.layer.borderWidth = 2
        logoutButton.layer.borderColor = phaedraDarkGreen.cgColor
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 12.0)
        logoutButton.titleLabel?.textAlignment = .center
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -50).isActive = true
        logoutButton.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 400).isActive = true
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoutButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        logoutButton.addTarget(self, action: #selector(logoutUser), for: .touchUpInside)
        logoutButton.setTitleColor(phaedraYellow, for: .normal)
        logoutButton.setTitleColor(phaedraLightGreen, for: .highlighted)
        logoutButton.isHidden = true
        
        view.addSubview(savePreferencesButton)
        savePreferencesButton.backgroundColor = phaedraLightGreen
        savePreferencesButton.layer.cornerRadius = 5
        savePreferencesButton.layer.borderColor = phaedraDarkGreen.cgColor
        savePreferencesButton.layer.borderWidth = 2
        savePreferencesButton.setTitle("Save Preferences", for: .normal)
        savePreferencesButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14.0)
        savePreferencesButton.titleLabel?.textAlignment = .center
        savePreferencesButton.translatesAutoresizingMaskIntoConstraints = false
        
        savePreferencesButton.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 435).isActive = true
        savePreferencesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        //        savePreferencesButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.40).isActive = true
        savePreferencesButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        //        savePreferencesButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        savePreferencesButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        savePreferencesButton.addTarget(self, action: #selector(savePreferencesButtonTapped), for: .touchUpInside)
        savePreferencesButton.setTitleColor(phaedraDarkGreen, for: .normal)
        savePreferencesButton.setTitleColor(phaedraOrange, for: .highlighted)
        
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
        let onboardingVC = OnboardingViewController()
        self.navigationController?.pushViewController(onboardingVC, animated: true)
    }
    
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
    
    func savePreferencesButtonTapped() {
        print("Save preferences tapped")
        
        //ASK ELI WHAT THIS FIRAUTH CODE IS ABOUT
        let user = FIRAuth.auth()?.currentUser
        guard let unwrappedUser = user else { return }
        print(unwrappedUser)
        if   FIRAuth.auth()?.currentUser != nil {
            
        }
        
        if userStore.preferredCuisineArray.count < 2 {
            let noCuisineAlert = UIAlertController(title: "Cuisines Needed", message: "Please select at least 2 cuisines.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            noCuisineAlert.addAction(okAction)
            self.present(noCuisineAlert, animated: true, completion: nil)
        } else {
            
            //send to search/tagalongVC
            let hostOrTagAlongVC = HostOrTagAlongViewController()
            self.navigationController?.pushViewController(hostOrTagAlongVC, animated: true)
        }
        
        let saved = store.preferredCuisineArray
        
        var dict = [String: Any]()
        for save in saved{
            dict[save] = true
        }
        
        FirebaseManager.savePref(dictionary: dict)
        
        print(store.preferredCuisineArray)
    }

//end of class
}
