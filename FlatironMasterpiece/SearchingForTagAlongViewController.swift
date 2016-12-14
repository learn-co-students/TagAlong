//
//  SearchingForTagAlongViewController.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 12/3/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit

class SearchingForTagAlongViewController: UIViewController {
    
    let store = FirebaseManager.shared
    
    let searchingLabel: UILabel = UILabel()
    var searchAgainButton: UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 30))
    var beTagAlongGuestButton: UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 30))
    var tagAlongFoundLabel: UILabel = UILabel()
    var tagAlongDetailLabel: UILabel = UILabel()
    var acceptButton = UIButton()
    var denyButton = UIButton()
    var guestName = String()
    var guestJob = String()
    var guestPhoto = UIImageView()
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)

    var firstTimeLoaded = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = phaedraBeige
        observeTagalongRequests()
        setupViews()
        print(FirebaseManager.currentUser)
        print(firstTimeLoaded)
    }
    
    override func loadView() {
        super.loadView()
        setupViews()
        
        
    }
    
    func setupViews() {
        
        //NOTE: - Searching for tagalong label
        view.addSubview(searchingLabel)
        searchingLabel.font = UIFont(name: "OpenSans-Semibold", size: 25.0)
        searchingLabel.lineBreakMode = .byWordWrapping
        searchingLabel.numberOfLines = 0
        searchingLabel.text = "Searching for your tag along"
        searchingLabel.textColor = phaedraOrange
        searchingLabel.textAlignment = .center
        searchingLabel.translatesAutoresizingMaskIntoConstraints = false
        searchingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        searchingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        searchingLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        //NOTE: - Activity Indicator
        view.addSubview(activityIndicator)
        activityIndicator.color = phaedraOrange
        activityIndicator.layer.cornerRadius = 4
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.topAnchor.constraint(equalTo: searchingLabel.bottomAnchor, constant: 100).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        activityIndicator.startAnimating()
        
        //NOTE: - Search for a tagalong button
        view.addSubview(searchAgainButton)
        searchAgainButton.backgroundColor = phaedraOrange
        searchAgainButton.layer.cornerRadius = 5
        searchAgainButton.setTitle("Choose Another Restaurant", for: UIControlState.normal)
        //        searchAgainButton.setTitle("Tutorial Played", for: .highlighted)
        searchAgainButton.titleLabel?.font = UIFont(name: "OpenSans-Light", size: 15.0)
        searchAgainButton.titleLabel?.textAlignment = .center
        searchAgainButton.translatesAutoresizingMaskIntoConstraints = false
        searchAgainButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 340).isActive = true
        searchAgainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchAgainButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        searchAgainButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        searchAgainButton.addTarget(self, action: #selector(returnToDeckView), for: .touchUpInside)
        searchAgainButton.setTitleColor(phaedraYellow, for: .normal)
        searchAgainButton.setTitleColor(phaedraLightGreen, for: .highlighted)
        
        
        //NOTE: - Be a tagalong button
        view.addSubview(beTagAlongGuestButton)
        beTagAlongGuestButton.backgroundColor = phaedraOrange
        beTagAlongGuestButton.layer.cornerRadius = 5
        beTagAlongGuestButton.setTitle("Be A Tag Along Instead", for: UIControlState.normal)
        //        beTagAlongGuestButton.setTitle("Tutorial Played", for: .highlighted)
        beTagAlongGuestButton.titleLabel?.font = UIFont(name: "OpenSans-Light", size: 15.0)
        beTagAlongGuestButton.titleLabel?.textAlignment = .center
        beTagAlongGuestButton.translatesAutoresizingMaskIntoConstraints = false
        beTagAlongGuestButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 400).isActive = true
        beTagAlongGuestButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        beTagAlongGuestButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        beTagAlongGuestButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.55).isActive = true
        beTagAlongGuestButton.addTarget(self, action: #selector(seeOtherTagAlongs), for: .touchUpInside)
        beTagAlongGuestButton.setTitleColor(phaedraYellow, for: .normal)
        beTagAlongGuestButton.setTitleColor(phaedraLightGreen, for: .highlighted)
        
        //NOTE: - Label for tagalong found
        view.addSubview(tagAlongFoundLabel)
        tagAlongFoundLabel.font = UIFont(name: "OpenSans-Semibold", size: 25.0)
        tagAlongFoundLabel.lineBreakMode = .byWordWrapping
        tagAlongFoundLabel.numberOfLines = 0
        tagAlongFoundLabel.text = "Great! Looks like you've got a match."
        tagAlongFoundLabel.textColor = phaedraOrange
        tagAlongFoundLabel.textAlignment = .center
        tagAlongFoundLabel.translatesAutoresizingMaskIntoConstraints = false
        tagAlongFoundLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive = true
        tagAlongFoundLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        tagAlongFoundLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        tagAlongFoundLabel.isHidden = false
        
        //NOTE: - Image view for guest photo
        view.addSubview(guestPhoto)
        guestPhoto.backgroundColor = phaedraLightGreen
        guestPhoto.layer.borderColor = phaedraDarkGreen.cgColor
        guestPhoto.layer.cornerRadius = 0
        guestPhoto.translatesAutoresizingMaskIntoConstraints = false
        guestPhoto.topAnchor.constraint(equalTo: tagAlongFoundLabel.topAnchor, constant: 100).isActive = true
        guestPhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        guestPhoto.widthAnchor.constraint(equalToConstant: 120).isActive = true
        guestPhoto.heightAnchor.constraint(equalToConstant: 120).isActive = true
        guestPhoto.isHidden = true
        
        //NOTE: - Tag along details
        view.addSubview(tagAlongDetailLabel)
        tagAlongDetailLabel.font = UIFont(name: "OpenSans-Light", size: 20.0)
        tagAlongDetailLabel.text = "iOS Developer, Joyce, would like to tag along with you."
        tagAlongDetailLabel.lineBreakMode = .byWordWrapping
        tagAlongDetailLabel.numberOfLines = 0
        tagAlongDetailLabel.textColor = phaedraOrange
        tagAlongDetailLabel.textAlignment = .center
        tagAlongDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        tagAlongDetailLabel.topAnchor.constraint(equalTo: guestPhoto.topAnchor, constant: 150).isActive = true
        tagAlongDetailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        tagAlongDetailLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        tagAlongDetailLabel.isHidden = true
        
        //NOTE: - Accept tagalong button
        
        view.addSubview(acceptButton)
        acceptButton.backgroundColor = phaedraOrange
        acceptButton.layer.cornerRadius = 5
        acceptButton.setTitle("Accept", for: .normal)
        acceptButton.titleLabel?.font = UIFont(name: "OpenSans-Light", size: 17.0)
        acceptButton.titleLabel?.textAlignment = .center
        acceptButton.translatesAutoresizingMaskIntoConstraints = false
        acceptButton.topAnchor.constraint(equalTo: tagAlongDetailLabel.bottomAnchor, constant: 50).isActive = true
        acceptButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 80).isActive = true
        acceptButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        acceptButton.addTarget(self, action: #selector(acceptTagalongAction), for: .touchUpInside)
        acceptButton.setTitleColor(phaedraYellow, for: .normal)
        acceptButton.setTitleColor(phaedraLightGreen, for: .highlighted)
        acceptButton.isHidden = true
        
        //NOTE: - Deny tagalong button
        view.addSubview(denyButton)
        denyButton.backgroundColor = phaedraOrange
        denyButton.layer.cornerRadius = 5
        denyButton.setTitle("Deny", for: .normal)
        denyButton.titleLabel?.font = UIFont(name: "OpenSans-Light", size: 17.0)
        denyButton.titleLabel?.textAlignment = .center
        denyButton.translatesAutoresizingMaskIntoConstraints = false
        denyButton.topAnchor.constraint(equalTo: tagAlongDetailLabel.bottomAnchor, constant: 50).isActive = true
        denyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -80).isActive = true
        denyButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        denyButton.addTarget(self, action: #selector(denyTagalongAction), for: .touchUpInside)
        denyButton.setTitleColor(phaedraYellow, for: .normal)
        denyButton.setTitleColor(phaedraLightGreen, for: .highlighted)
        denyButton.isHidden = true
        
    }
    
    
    func returnToDeckView() {
        print("User wants to return to deck view")
        let shakeInstructionVC = ShakeInstructionViewController()
        self.navigationController?.pushViewController(shakeInstructionVC, animated: true)
    }
    
    
    func seeOtherTagAlongs() {
        print("User wants to see other tagalongs")
        let tagAlongsVC = TagAlongViewController()
        self.navigationController?.pushViewController(tagAlongsVC, animated: true)
    }
    
    func acceptTagalongAction() {
        print("getting hit")
        print(store.guestID)
        guard let acceptedGuestID = store.guestID else { print("leaving function");return }
        print(acceptedGuestID)
        
        store.acceptTagalong(guestID: acceptedGuestID) { (currentTagAlongKey) in
            self.store.updateGuestWithTagAlongKey(tagAlongkey: currentTagAlongKey)
            
            // Add true value to hidden node
            self.store.hideTagalong(for: currentTagAlongKey)
            
            let tabBarVC = TabBarController()
            tabBarVC.tagAlong = currentTagAlongKey
            
            self.navigationController?.pushViewController(tabBarVC, animated: true)
        }
    }
    
    
    func denyTagalongAction() {
        
        guard let deniedGuestID = store.guestID else { print("leaving function");return }
        print(deniedGuestID)
        
        store.denyTagalong(guestID: deniedGuestID)
        
        self.acceptButton.isHidden = true
        self.denyButton.isHidden = true
        self.tagAlongFoundLabel.isHidden = true
        self.tagAlongDetailLabel.isHidden = true
        self.searchingLabel.isHidden = false
        self.beTagAlongGuestButton.isHidden = false
        self.searchAgainButton.isHidden = false
        self.guestPhoto.isHidden = false
        activityIndicator.isHidden = false
        
    }
    
    
    func observeTagalongRequests() {
        
        store.observeTagalongRequests { (snapshot) in
            
            //Prevents old tagalongs to appear if
   //                     if self.firstTimeLoaded { self.firstTimeLoaded = false; return }
            
            // Only detects recents tagalongs
       //                 if !self.firstTimeLoaded {
            
            //Alert user of new tag along
            print("\n ==============Getting called.===============")
            
            guard snapshot != nil else { print("snapshot is nil");return }
            
            //Show labels and buttons
            self.acceptButton.isHidden = false
            self.denyButton.isHidden = false
            self.tagAlongFoundLabel.isHidden = false
            self.tagAlongDetailLabel.isHidden = false
            self.guestPhoto.isHidden = false
            self.searchingLabel.isHidden = true
            self.beTagAlongGuestButton.isHidden = true
            self.searchAgainButton.isHidden = true
            self.activityIndicator.isHidden = true
            
            // Grab info from guest
            self.store.guestID = snapshot?.key
            
            guard let guestID = self.store.guestID else { print("no guest info");return }
            
            self.store.createGuest(from: guestID , completion: { (guest) in
                
                self.guestName = guest.firstName
                self.guestJob = guest.jobTitle
                self.tagAlongDetailLabel.text = "\(self.guestJob), \(self.guestName), would like to tag along with you."
                
                print(guest.firstName)
                print(guest.jobTitle)
                
                
                
             FirebaseManager.downloadPic(uid: guestID, handler: { (image) in
             
                    self.guestPhoto.image = image
                    print("Helllooooo image is here")
             })
                
                
            })
                            
            //}
            
            print("\n\n")
            
            print("We have a new tag along person. \(snapshot)")
            
            
            
            
        }
    }
    
}
