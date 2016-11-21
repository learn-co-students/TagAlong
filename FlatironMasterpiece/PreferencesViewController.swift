//
//  PracticeViewController.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/20/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit

class PreferenceViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
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
    var replayTutorialButton: UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 35))
    var logoutButton: UIButton = UIButton(frame: CGRect(x: 100, y: 500, width: 100, height: 35))
    var cuisineCollectionView:UICollectionView!
    let cuisineReuseIdentifier = "Cuisine Cell"
    
    // TODO: - import images for these cuisines
    
    let cuisineImage:[UIImage] = [UIImage(named: "american")!, UIImage(named:"asian")!]
    let cuisineArray:[String] = ["american", "asian", "italian", "latin", "healthy", "unhealthy" ]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = phaedraYellow
        createSegmentedController()
        formatPreferenceLabel()
        formatBudgetLabel()
        formatDineWithCompanyLabel()
        formatSwitch()
        formatButtons()
        layoutCuisineCollectionView()
    }
    
    func layoutCuisineCollectionView() {
        
        let frame = UIScreen.main.bounds
        let flowLayout = UICollectionViewFlowLayout()
        cuisineCollectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        print("cuisineCollectionView frame assigned")
        cuisineCollectionView.delegate = self
        cuisineCollectionView.dataSource = self
        
        cuisineCollectionView.backgroundColor = UIColor.green
        cuisineCollectionView.register(CuisineCollectionViewCell.self, forCellWithReuseIdentifier: cuisineReuseIdentifier)
        view.addSubview(cuisineCollectionView)
        cuisineCollectionView.reloadData()
        
        cuisineCollectionView.translatesAutoresizingMaskIntoConstraints = false
        cuisineCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 400).isActive = true
        cuisineCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
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
        
        // Configure the cell
        
        return cell
    }

    //MARK: - setup UI
    
    func formatSwitch() {
        view.addSubview(dineWithCompanySwitch)
        dineWithCompanySwitch.center = view.center
        dineWithCompanySwitch.setOn(false, animated: false)
        dineWithCompanySwitch.tintColor = phaedraDarkGreen
        dineWithCompanySwitch.onTintColor = phaedraDarkGreen
        dineWithCompanySwitch.thumbTintColor = phaedraLightGreen
        dineWithCompanySwitch.addTarget(self, action: #selector(findDiningPartner), for: UIControlEvents.valueChanged)
        dineWithCompanySwitch.translatesAutoresizingMaskIntoConstraints = false
        dineWithCompanySwitch.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        dineWithCompanySwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 95).isActive = true
        dineWithCompanySwitch.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        
    }
    
    func formatPreferenceLabel() {
        view.addSubview(preferencesLabel)
        preferencesLabel.text = "PREFERENCES"
        // TODO: - decide on preferences label font and font size
        preferencesLabel.font = UIFont(name: "AvenirNext-Bold", size: 20.0)
        preferencesLabel.textColor = phaedraOrange
        preferencesLabel.textAlignment = .center
        preferencesLabel.translatesAutoresizingMaskIntoConstraints = false
        preferencesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -275).isActive = true
        preferencesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        preferencesLabel.specialConstrain(to: view)
    }
    
    func formatBudgetLabel() {
        view.addSubview(budgetLabel)
        budgetLabel.text = "Choose your budget"
        budgetLabel.font = UIFont(name: "AvenirNext-Regular", size: 20.0)
        budgetLabel.textColor = phaedraOrange
        budgetLabel.textAlignment = .center
        budgetLabel.translatesAutoresizingMaskIntoConstraints = false
        budgetLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -230).isActive = true
        budgetLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        //add special constraint functionality
//        budgetLabel.specialConstrain(to: view)

    }
    
    func formatDineWithCompanyLabel() {
        view.addSubview(dineWithCompanyLabel)
        dineWithCompanyLabel.text = "Dine with company?"
        dineWithCompanyLabel.font = UIFont(name: "AvenirNext-Regular", size: 20.0)
        dineWithCompanyLabel.textColor = phaedraOrange
        // TODO: - decide on dineWithCompany label font and font size
        dineWithCompanyLabel.textAlignment = .center
        dineWithCompanyLabel.translatesAutoresizingMaskIntoConstraints = false
        dineWithCompanyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -50).isActive = true
        dineWithCompanyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        
    }
    
    func createSegmentedController() {
        let budgetArray:[String] = ["💰", "💰💰", "💰💰💰", "💰💰💰💰"]
        let budgetSC = UISegmentedControl(items: budgetArray)
        budgetSC.selectedSegmentIndex = 0
        let frame = UIScreen.main.bounds
        budgetSC.frame = CGRect(x: frame.minX + 10, y: frame.minY + 140, width: frame.width - 20, height: frame.height * 0.08)
        
        budgetSC.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Avenir Next", size: 16.0)! ], for: .normal)
        budgetSC.layer.cornerRadius = 5
        budgetSC.backgroundColor = phaedraLightGreen
        budgetSC.tintColor = phaedraDarkGreen
        budgetSC.addTarget(self, action: #selector(printChosenBudget(sender:)), for: .valueChanged)
        
        self.view.addSubview(budgetSC)
        
    }
    
    func printChosenBudget(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("user chose 💰")
        case 1:
            print("user chose 💰💰")
        case 2:
            print("user chose 💰💰💰")
        case 3:
            print("user chose 💰💰💰💰")
        default:
            print("user chose 💰")
        }
    }
    
    func formatButtons() {
        
        view.addSubview(logoutButton)
        logoutButton.backgroundColor = phaedraLightGreen
        logoutButton.layer.cornerRadius = 5
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.titleLabel?.font = UIFont(name: "Avenir Next", size: 20.0)
        
        logoutButton.titleLabel?.textAlignment = .center
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20).isActive = true
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoutButton.addTarget(self, action: #selector(logoutUser), for: .touchUpInside)
        logoutButton.setTitleColor(phaedraDarkGreen, for: .normal)
        logoutButton.setTitleColor(phaedraYellow, for: .highlighted)
        
        view.addSubview(replayTutorialButton)
        // TODO: - change button color
        replayTutorialButton.backgroundColor = phaedraLightGreen
        replayTutorialButton.layer.cornerRadius = 5
        replayTutorialButton.setTitle("Replay Tutorial", for: UIControlState.normal)
        replayTutorialButton.setTitle("Tutorial Played", for: .highlighted)
        replayTutorialButton.titleLabel?.font = UIFont(name: "Avenir Next", size: 20.0)
        replayTutorialButton.titleLabel?.textAlignment = .center
        replayTutorialButton.translatesAutoresizingMaskIntoConstraints = false
        replayTutorialButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40).isActive = true
        replayTutorialButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        replayTutorialButton.addTarget(self, action: #selector(replayTutorial), for: .touchUpInside)
        replayTutorialButton.setTitleColor(phaedraDarkGreen, for: .normal)
        replayTutorialButton.setTitleColor(phaedraYellow, for: .highlighted)
        
    }
    
    // MARK: - selector functions for buttons
    
    // TODO: - write function that finds a dining partner
    func findDiningPartner(sender: UISwitch!) {
        if !sender.isOn {print("User wants to dine alone.")} else {
            print("User wants to dine with a partner!")
        }
    }
    
    // TODO: - write function that displays replayTutorial
    func replayTutorial() {
        print("Replay tutorial requested.")
    }
    
    // TODO: - write function that logs user out of the app
    func logoutUser() {
        print("User tapped button to logout.")
    }
    
}


















