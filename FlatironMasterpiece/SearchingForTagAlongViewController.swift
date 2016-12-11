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
    var acceptButton = UIButton()
    var denyButton = UIButton()
    var firstTimeLoaded = true

    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = phaedraBeige
        observeTagalongRequests()

        print(FirebaseManager.currentUser)
        print(firstTimeLoaded)
    }

    override func loadView() {
        super.loadView()
        setupLabel()
        setupSpinner()
        setupButtons()

        setupTagAlongMessageAndButtons()

    }

    func setupLabel() {
        view.addSubview(searchingLabel)
        searchingLabel.text = "Searching for your Tag Along..."
        searchingLabel.font = UIFont(name: "OpenSans-Bold", size: 16.0)
        searchingLabel.textColor = phaedraOrange
        searchingLabel.textAlignment = .center
        searchingLabel.translatesAutoresizingMaskIntoConstraints = false
        searchingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        searchingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        searchingLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }

    func setupSpinner() {
        activityIndicator.color = phaedraDarkGreen
        activityIndicator.layer.cornerRadius = 4
        activityIndicator.layer.backgroundColor = phaedraLightGreen.cgColor
        activityIndicator.layer.borderWidth = 1
        activityIndicator.layer.borderColor = phaedraDarkGreen.cgColor
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }

    func setupButtons() {
        view.addSubview(searchAgainButton)
        searchAgainButton.backgroundColor = phaedraLightGreen
        searchAgainButton.layer.cornerRadius = 5
        searchAgainButton.layer.borderWidth = 1
        searchAgainButton.layer.borderColor = phaedraDarkGreen.cgColor
        searchAgainButton.setTitle("Choose Another Restaurant", for: UIControlState.normal)
        searchAgainButton.setTitle("Tutorial Played", for: .highlighted)
        searchAgainButton.titleLabel?.font = UIFont(name: "OpenSans-Light", size: 12.0)
        searchAgainButton.titleLabel?.textAlignment = .center
        searchAgainButton.translatesAutoresizingMaskIntoConstraints = false
        searchAgainButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 340).isActive = true
        searchAgainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchAgainButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        searchAgainButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.50).isActive = true
        searchAgainButton.addTarget(self, action: #selector(returnToDeckView), for: .touchUpInside)
        searchAgainButton.setTitleColor(phaedraDarkGreen, for: .normal)
        searchAgainButton.setTitleColor(phaedraYellow, for: .highlighted)

        view.addSubview(beTagAlongGuestButton)
        beTagAlongGuestButton.backgroundColor = phaedraLightGreen
        beTagAlongGuestButton.layer.cornerRadius = 5
        beTagAlongGuestButton.layer.borderWidth = 1
        beTagAlongGuestButton.layer.borderColor = phaedraDarkGreen.cgColor
        beTagAlongGuestButton.setTitle("Be a Tag Along Guest Instead", for: UIControlState.normal)
        beTagAlongGuestButton.setTitle("Tutorial Played", for: .highlighted)
        beTagAlongGuestButton.titleLabel?.font = UIFont(name: "OpenSans-Light", size: 12.0)
        beTagAlongGuestButton.titleLabel?.textAlignment = .center
        beTagAlongGuestButton.translatesAutoresizingMaskIntoConstraints = false
        beTagAlongGuestButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 390).isActive = true
        beTagAlongGuestButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        beTagAlongGuestButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        beTagAlongGuestButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.50).isActive = true
        beTagAlongGuestButton.addTarget(self, action: #selector(seeOtherTagAlongs), for: .touchUpInside)
        beTagAlongGuestButton.setTitleColor(phaedraDarkGreen, for: .normal)
        beTagAlongGuestButton.setTitleColor(phaedraYellow, for: .highlighted)

    }

    func setupTagAlongMessageAndButtons() {
        view.addSubview(tagAlongFoundLabel)
        tagAlongFoundLabel.isHidden = true
        tagAlongFoundLabel.text = "You have been matched with /n'Person"
        tagAlongFoundLabel.font = UIFont(name: "OpenSans-Bold", size: 20.0)
        tagAlongFoundLabel.textColor = phaedraOrange
        tagAlongFoundLabel.textAlignment = .center
        tagAlongFoundLabel.translatesAutoresizingMaskIntoConstraints = false
        tagAlongFoundLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        tagAlongFoundLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        tagAlongFoundLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true

        view.addSubview(acceptButton)
        acceptButton.isHidden = true
        acceptButton.backgroundColor = phaedraLightGreen
        acceptButton.layer.cornerRadius = 5
        acceptButton.layer.borderWidth = 1
        acceptButton.layer.borderColor = phaedraDarkGreen.cgColor
        acceptButton.setTitle("Accept Tag Along", for: UIControlState.normal)
        acceptButton.setTitle("Tutorial Played", for: .highlighted)
        acceptButton.titleLabel?.font = UIFont(name: "OpenSans-Light", size: 12.0)
        acceptButton.titleLabel?.textAlignment = .center
        acceptButton.translatesAutoresizingMaskIntoConstraints = false
        acceptButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 250).isActive = true
        acceptButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        acceptButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        acceptButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.50).isActive = true
        acceptButton.addTarget(self, action: #selector(acceptTagalongAction), for: .touchUpInside)
        acceptButton.setTitleColor(phaedraDarkGreen, for: .normal)
        acceptButton.setTitleColor(phaedraYellow, for: .highlighted)

        view.addSubview(denyButton)
        denyButton.isHidden = true
        denyButton.backgroundColor = phaedraLightGreen
        denyButton.layer.cornerRadius = 5
        denyButton.layer.borderWidth = 1
        denyButton.layer.borderColor = phaedraDarkGreen.cgColor
        denyButton.setTitle("Deny Tag Along", for: UIControlState.normal)
        denyButton.setTitle("Tutorial Played", for: .highlighted)
        denyButton.titleLabel?.font = UIFont(name: "OpenSans-Light", size: 12.0)
        denyButton.titleLabel?.textAlignment = .center
        denyButton.translatesAutoresizingMaskIntoConstraints = false
        denyButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        denyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        denyButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        denyButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.50).isActive = true
        denyButton.addTarget(self, action: #selector(denyTagalongAction), for: .touchUpInside)
        denyButton.setTitleColor(phaedraDarkGreen, for: .normal)
        denyButton.setTitleColor(phaedraYellow, for: .highlighted)

    }
    func johann(){
        print("wooo hoo")
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
            self.store.hideTagalong()

            let tabBarVC = TabBarController()
            tabBarVC.tagAlong = currentTagAlongKey

            self.navigationController?.pushViewController(tabBarVC, animated: true)
        }

        // Segue into chat/tab bar view

    }

    func denyTagalongAction() {

        guard let deniedGuestID = store.guestID else { print("leaving function");return }
        print(deniedGuestID)

        store.denyTagalong(guestID: deniedGuestID)

    }


    func observeTagalongRequests() {

        store.observeTagalongRequests { (snapshot) in

            //Prevents old tagalongs to appear if
//            if self.firstTimeLoaded { self.firstTimeLoaded = false; return }

            // Only detects recents tagalongs
//            if !self.firstTimeLoaded {

                //Alert user of new tag along
                print("\n ==============Getting called.===============")

            guard snapshot != nil else { print("snapshot is nil");return }

                //Show labels and buttons
                self.acceptButton.isHidden = false
                self.denyButton.isHidden = false
                self.tagAlongFoundLabel.isHidden = false
                                // Grab info from guest

//                guard let tagalongID = self.store.selectedTagAlongID else { return }

                self.store.guestID = snapshot?.key

//                self.store.createGuestFrom(tagalong: self.store.selectedTagAlongID, completion: { (guest) in
//
//                    print("\(guest.firstName), \(guest.jobTitle), would like to tag along with you at 'restaurant'. Would you like them to tag along?")
//
//
//
//                })

                print("\n\n")

                print("We have a new tag along person. \(snapshot)")
//            }




        }



    }
}
