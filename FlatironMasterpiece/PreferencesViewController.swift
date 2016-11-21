//
//  PreferencesViewController.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/17/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit

//TODO: - adopt UICollectionViewDelegate and UICollectionViewDataSource protocols if we figure out how to use a collectionView
class PreferencesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    let phaedraDarkGreen = UIColor(red: 0, green: 163, blue: 136, alpha: 1)
    
    let phaedraOliveGreen = UIColor(red: 121, green: 189, blue: 143, alpha: 1)
    
    let phaedraLightGreen = UIColor(red: 190, green: 235, blue: 159, alpha: 1)
    
    let phaedraYellow = UIColor(red: 255, green: 255, blue: 157, alpha: 1)
    
    let phaedraOrange = UIColor(red: 255, green: 97, blue: 56, alpha: 1)
    
    var preferencesLabel = UILabel()
    var dineWithCompanySwitch = UISwitch()
    var dineWithCompanyLabel = UILabel()
    var replayTutorialButton: UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 50))
    var logoutButton: UIButton = UIButton(frame: CGRect(x: 100, y: 500, width: 100, height: 50))
 
    var cuisineCollectionView:UICollectionView!
    let cuisineReuseIdentifier = "Cuisine Cell"
    
    // TODO: - import images for these cuisines
    
    let cuisineImage:[UIImage] = [UIImage(named: "american")!, UIImage(named:"asian")!]
    let cuisineArray:[String] = ["american", "asian", "italian", "latin", "healthy", "unhealthy" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatSwitch()
        formatLabels()
        formatButtons()
        layoutCuisineCollectionView()
     }
    
   
    
    func layoutCuisineCollectionView() {
        
        let frame = CGRect.zero
        let flowLayout = UICollectionViewFlowLayout()
        cuisineCollectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        
        cuisineCollectionView.delegate = self
        cuisineCollectionView.dataSource = self
        
        cuisineCollectionView.backgroundColor = UIColor.green
        cuisineCollectionView.register(CuisineCollectionViewCell.self, forCellWithReuseIdentifier: cuisineReuseIdentifier)
        view.addSubview(cuisineCollectionView)
        cuisineCollectionView.reloadData()
        
        cuisineCollectionView.translatesAutoresizingMaskIntoConstraints = false
        cuisineCollectionView.topAnchor.constraint(equalTo: replayTutorialButton.bottomAnchor, constant: 100).isActive = true
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
    
    // TODO: - write function that displays replayTutorial
    func replayTutorial() {
        print("Replay tutorial requested.")
    }
    
    // TODO: - write function that finds a dining partner
    func findDiningPartner(sender: UISwitch!) {
        print("Switch value is \(sender.isOn)")
    }
    
    // TODO: - write function that logs user out of the app
    func logoutUser() {
        print("User tapped button to logout.")
    }
 
    func formatButtons() {
        
        view.addSubview(logoutButton)
        logoutButton.backgroundColor = UIColor.orange
        logoutButton.layer.cornerRadius = 5
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.titleLabel?.font = UIFont(name: "Avenir Next", size: 20.0)
        logoutButton.titleLabel?.textAlignment = .center
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 75).isActive = true
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoutButton.addTarget(self, action: #selector(logoutUser), for: .touchUpInside)
        logoutButton.setTitleColor(UIColor.green, for: .highlighted)
        
        view.addSubview(replayTutorialButton)
        // TODO: - change button color
        replayTutorialButton.backgroundColor = UIColor.orange
        replayTutorialButton.layer.cornerRadius = 5
        replayTutorialButton.setTitle("Replay Tutorial", for: UIControlState.normal)
        replayTutorialButton.setTitle("Tutorial Played", for: .highlighted)
        replayTutorialButton.titleLabel?.font = UIFont(name: "Avenir Next", size: 20.0)
        replayTutorialButton.titleLabel?.textAlignment = .center
        replayTutorialButton.translatesAutoresizingMaskIntoConstraints = false
        replayTutorialButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        replayTutorialButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        replayTutorialButton.addTarget(self, action: #selector(replayTutorial), for: .touchUpInside)
        replayTutorialButton.setTitleColor(UIColor.green, for: .highlighted)
        
    }
    
    func formatLabels() {
        view.addSubview(preferencesLabel)
        preferencesLabel.text = "PREFERENCES"
        // TODO: - decide on preferences label font and font size
        preferencesLabel.font = UIFont(name: "Avenir Next", size: 20.0)
        preferencesLabel.textAlignment = .center
        preferencesLabel.translatesAutoresizingMaskIntoConstraints = false
        preferencesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -275).isActive = true
        preferencesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        preferencesLabel.specialConstrain(to: view)
        
        view.addSubview(dineWithCompanyLabel)
        dineWithCompanyLabel.text = "Dine with company?"
        dineWithCompanyLabel.font = UIFont(name: "Avenir Next", size: 20.0)
        // TODO: - decide on dineWithCompany label font and font size
        dineWithCompanyLabel.textAlignment = .center
        dineWithCompanyLabel.translatesAutoresizingMaskIntoConstraints = false
        dineWithCompanyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -50).isActive = true
        dineWithCompanyLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    }
    
    func formatSwitch() {
        view.addSubview(dineWithCompanySwitch)
        dineWithCompanySwitch.center = view.center
        dineWithCompanySwitch.setOn(false, animated: false)
        dineWithCompanySwitch.tintColor = UIColor.green
        dineWithCompanySwitch.onTintColor = UIColor.green
        dineWithCompanySwitch.thumbTintColor = UIColor.lightGray
        dineWithCompanySwitch.addTarget(self, action: #selector(findDiningPartner), for: UIControlEvents.valueChanged)
        dineWithCompanySwitch.translatesAutoresizingMaskIntoConstraints = false
        dineWithCompanySwitch.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        dineWithCompanySwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 85).isActive = true
        dineWithCompanySwitch.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    }

    //american, asian, italian, healthy, latin, unhealthy

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


