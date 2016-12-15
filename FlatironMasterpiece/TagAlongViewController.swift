//
//  FinalViewController.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/27/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit
import Firebase
class TagAlongViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let store = FirebaseManager.shared
    let userDataStore = UsersDataStore.sharedInstance
    
    var tagalongs = [Tagalong]()
    //    var tagAlongUserArray:[User] = []
    var myTableView: UITableView!
    var tagAlongUsersLabel: UILabel = UILabel()
    let preferencesButton: UIButton = UIButton(type: UIButtonType.custom) as UIButton
    let preferencesLabel = UILabel()
    let preferencesImage = UIImage(named: "gear_redLarge.png")! as UIImage
    
    let cuisineImage:[UIImage] = [UIImage(named: "American")!, UIImage(named:"Asian")!, UIImage(named: "Healthy")!, UIImage(named: "Italian")!, UIImage(named: "Latin3x")!, UIImage(named: "Unhealthy2x")!]
    var hostTagAlongInsteadButton: UIButton = UIButton(frame: CGRect(x: 100, y: 500, width: 100, height: 30))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTags()
        
        //store.getTagalongs()
        // print(store.tagalongs.count)
        view.backgroundColor = phaedraOliveGreen
        formatViews()
        layoutTableView()
    }
    
    
    func formatViews() {
        view.addSubview(tagAlongUsersLabel)
        tagAlongUsersLabel.text = "Choose a Tag Along"
        tagAlongUsersLabel.font = UIFont(name: "OpenSans-Bold", size: 17.0)
        tagAlongUsersLabel.textColor = phaedraYellow
        tagAlongUsersLabel.textAlignment = .center
        tagAlongUsersLabel.translatesAutoresizingMaskIntoConstraints = false
        tagAlongUsersLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        tagAlongUsersLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        tagAlongUsersLabel.specialConstrain(to: view)
        
        view.addSubview(hostTagAlongInsteadButton)
        hostTagAlongInsteadButton.backgroundColor = phaedraOrange
        hostTagAlongInsteadButton.layer.cornerRadius = 5
        hostTagAlongInsteadButton.layer.borderWidth = 2
        hostTagAlongInsteadButton.layer.borderColor = phaedraYellow.cgColor
        hostTagAlongInsteadButton.setTitle("Host a Tag Along Instead", for: .normal)
        hostTagAlongInsteadButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14.0)
        hostTagAlongInsteadButton.titleLabel?.adjustsFontSizeToFitWidth = true
        hostTagAlongInsteadButton.titleLabel?.minimumScaleFactor = 2
        hostTagAlongInsteadButton.titleLabel?.numberOfLines = 1
        hostTagAlongInsteadButton.titleLabel?.textAlignment = .center
        hostTagAlongInsteadButton.translatesAutoresizingMaskIntoConstraints = false
        hostTagAlongInsteadButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        hostTagAlongInsteadButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        hostTagAlongInsteadButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.68).isActive = true
        hostTagAlongInsteadButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
        
        hostTagAlongInsteadButton.addTarget(self, action: #selector(goToShakeInstructions), for: .touchUpInside)
        hostTagAlongInsteadButton.setTitleColor(phaedraYellow, for: .normal)
        hostTagAlongInsteadButton.setTitleColor(phaedraLightGreen, for: .highlighted)
        
        view.addSubview(preferencesLabel)
        preferencesLabel.font = UIFont(name: "OpenSans-Bold", size: 12.0)
        preferencesLabel.lineBreakMode = .byWordWrapping
        preferencesLabel.numberOfLines = 0
        preferencesLabel.text = "Preferences"
        preferencesLabel.textColor = phaedraYellow
        //        preferencesLabel.textAlignment = .center
        preferencesLabel.textAlignment = .right
        preferencesLabel.translatesAutoresizingMaskIntoConstraints = false
        preferencesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        preferencesLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        preferencesLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        preferencesButton.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        preferencesButton.setImage(preferencesImage, for: .normal)
        view.addSubview(preferencesButton)
        preferencesButton.backgroundColor = phaedraOliveGreen
        preferencesButton.layer.cornerRadius = 5
        preferencesButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 20.0)
        preferencesButton.titleLabel?.textAlignment = .center
        preferencesButton.translatesAutoresizingMaskIntoConstraints = false
        preferencesButton.topAnchor.constraint(equalTo: preferencesLabel.bottomAnchor, constant: 4).isActive = true
        preferencesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        preferencesButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        preferencesButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.10).isActive = true
        preferencesButton.addTarget(self, action: #selector(goToPreferences), for: .touchUpInside)
        preferencesButton.imageView?.contentMode = .scaleAspectFit
        preferencesButton.setTitleColor(phaedraOrange, for: .normal)
        preferencesButton.setTitleColor(phaedraDarkGreen, for: .highlighted)
    }
    
    func goToShakeInstructions() {
        print("User wants to go to shakeinstructions")
        let shakeInstVC = ShakeInstructionViewController()
        self.navigationController?.pushViewController(shakeInstVC, animated: true)
    }
    
    func goToPreferences() {
        print("User wants to go to preferences")
        let preferencesVC = PreferenceViewController()
        self.navigationController?.pushViewController(preferencesVC, animated: true)
    }
    
    //Firebase functions --- this can be refined in firebaseManager during refactoring
    // Get tagalongs
    func getTags(){
        FirebaseManager.newTagalongRefHandle = FirebaseManager.ref.child("tagalongs").observe(.childAdded, with: { (snapshot) -> Void in
            
            let tagDict = snapshot.value as! [String: Any]
            print("------------------")
            print(tagDict)
            
            let tagId = snapshot.key
            var tagalong = Tagalong(snapshot: tagDict, tagID: tagId)
            
            print("****************"+tagId)
            
            FirebaseManager.createUserFrom(tagalong: tagId, completion: { (user) in
                tagalong.user = user
                tagalong.user.userID = tagDict["user"] as! String
                
                self.tagalongs.append(tagalong)
                
                // Remove tagalongs
                for (index, value) in self.tagalongs.enumerated() {
                    
                    if value.hidden == true {
                        self.tagalongs.remove(at: index)
                    }
                }
                self.myTableView.reloadData()
            })
        })
    }
    
    // MARK: - set up tableview
    func layoutTableView() {
        self.myTableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.backgroundColor = phaedraLightGreen
        
        //this determines the size of the tableview
        myTableView.frame = CGRect(x: 0, y: 70, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.77)
        myTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tagAlongCell")
        self.view.addSubview(myTableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tagalongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let myCell = tableView.dequeueReusableCell(withIdentifier: "tagAlongCell", for: indexPath) as! TableViewCell
        let selectedTag = self.tagalongs[indexPath.row]
        let fullName = selectedTag.user.firstName + " " + selectedTag.user.lastName
        
        
        myCell.userNameLabel.text = fullName
        myCell.userIndustryLabel.text = selectedTag.user.industry
        myCell.restNameLabel.text = selectedTag.restaurant
        myCell.restDistLabel.text = String(userDataStore.userDistanceToChosenRest)
        
        
        //        let date = NSDate()
        //        let time = String(NSCalendar.current.component(.hour, from: date as Date)) + ":" + String(NSCalendar.current.component(.minute, from: date as Date))
        // myCell.diningTimeLabel.text = "4:00"
        
        //  FirebaseManager.storageRef.child("\(selectedTag.user)")
        
        print("++++++++\(selectedTag.user.userID)-----------------------")
        
        FirebaseManager.downloadPic(uid: selectedTag.user.userID) { (image) in
            OperationQueue.main.addOperation {
                
                myCell.userImageView.image = image
                print("*********\(myCell.imageView?.image)***********")
            }
            
        }
        
        
        //    myCell.userImageView?.image = UIImage(named: "rock.png")
        
        //        let profilePic = FirebaseManager.ref.child("users").child(FirebaseManager.currentUser).child("ProfilePic")
        //        myCell.userImageView?.image = UIImage(named:  )
        return myCell
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("a cell was tapped")
        let selectedTag = tagalongs[indexPath.row]
        
        //ERICA added this nav controller code below
        let waitingForHostVC = WaitingForHostViewController()
        
        
        FirebaseManager.ref.child("tagalongs").child(selectedTag.tagID).child("user").observeSingleEvent(of: .value, with: { snapshot in
            
            //            DispatchQueue.main.async {
            //
            //                print("\n\n\n\n")
            //
            //                print(snapshot.value ?? "No Value")
            //                print("ZZZZZZZZZZZZZZZRRRRRRRRRRRRRRRRRR")
            //                let usersID = snapshot.value as? String
            //                print("++++++++++++++++\(usersID)++++++++++")
            //
            //                FirebaseManager.shared.checkIfBlocked(userID: usersID!, handler: { isBlocked in
            //
            //                    DispatchQueue.main.async {
            //
            //
            //                        if !isBlocked {
            //
            //                            self.navigationController?.pushViewController(waitingForHostVC, animated: true)
            //
            //                        } else {
            //
            //                            // TODO: Show an alert to the user that they are BLOCKED (they suck)
            //                        }
            //
            //                    }
            //                })
            //
            //            }
            //
        }, withCancel: nil)
        
        
        
        
        
        // TODO: At this point, take the uniqueID of the tagAlong. With that, grab the unique ID of the host (or creator) of the tagalon somehow.
        
        // TODO: After we get unique ID of creator (or host) then we call on that method to see if we're blocked.
        
        // TODO: The part where we check to see if we're blocked has a closure as one of the arguments to the function, in that closure, if WE AREN't blocked (if it returns false) then we push the viewcontroller.  If not, if we are blocked, show up an laert.
        
        self.navigationController?.pushViewController(waitingForHostVC, animated: true)
        
        // Create an alert to confirm tagalong request. Once user had confirmed, this function will be added to the alert
        FirebaseManager.requestTagAlong(key: selectedTag.tagID)
        
        // Store tagalongID and userID to firebase (This ID will later be used to observe child values for requests)
        store.selectedTagAlongID = selectedTag.tagID
        store.guestID = store.currentUser.userID
        
        print("This is selectedtagalongID \(store.selectedTagAlongID)")
        print("THis is guestID \(store.guestID)")
    }
    
    
}
