//
//  FinalViewController.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/27/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit

class TagAlongViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let store = FirebaseManager.shared

    var tagalongs = [Tagalong]()
//    var tagAlongUserArray:[User] = []
    var myTableView: UITableView!
    var tagAlongUsersLabel: UILabel = UILabel()

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
        
//        for tag in tagalongs {
//            
//            print(tag.tagID)
//        }
//        createFakeUsers()
        
        
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
        hostTagAlongInsteadButton.layer.borderColor = phaedraDarkGreen.cgColor
        hostTagAlongInsteadButton.setTitle("Be a Tag Along Host Instead", for: .normal)
        hostTagAlongInsteadButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14.0)
        hostTagAlongInsteadButton.titleLabel?.adjustsFontSizeToFitWidth = true
        hostTagAlongInsteadButton.titleLabel?.minimumScaleFactor = 2
        hostTagAlongInsteadButton.titleLabel?.numberOfLines = 1
        hostTagAlongInsteadButton.titleLabel?.textAlignment = .center
        hostTagAlongInsteadButton.translatesAutoresizingMaskIntoConstraints = false
        hostTagAlongInsteadButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        hostTagAlongInsteadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        hostTagAlongInsteadButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.68).isActive = true
        hostTagAlongInsteadButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08).isActive = true
        hostTagAlongInsteadButton.addTarget(self, action: #selector(goToShakeInstructions), for: .touchUpInside)
        hostTagAlongInsteadButton.setTitleColor(phaedraYellow, for: .normal)
        hostTagAlongInsteadButton.setTitleColor(phaedraLightGreen, for: .highlighted)
    }
    
//    func createFakeUsers() {
//        let user1:User = User(firstName: "Dwayne", lastName: "Johnson", emailAddress: "therock@peoplesElbow.com", passWord: "rock", industry: "Entertainment", jobTitle: "Beast")
//        let user2:User = User(firstName: "Erica", lastName: "Millado", emailAddress: "erica@lovestacos.com", passWord: "tacos", industry: "iOS", jobTitle: "iOS Developer")
//        let user3:User = User(firstName: "Michelle", lastName: "Obama", emailAddress: "michelle@firstlady.com", passWord: "first", industry: "Being Awesome", jobTitle: "BossLady")
//        let user4: User = User(firstName: "Johann", lastName: "Kerr", emailAddress: "johann@kerr.com", passWord: "ilovecode", industry: "iOS", jobTitle: "instructor")
//        let user5: User = User(firstName: "Kermit", lastName: "The Frog", emailAddress: "livin@thegreenlife.com", passWord: "frogs", industry: "Entertainment", jobTitle: "Comedian")
//        tagAlongUserArray.append(user1)
//        tagAlongUserArray.append(user2)
//        tagAlongUserArray.append(user3)
//        tagAlongUserArray.append(user4)
//        tagAlongUserArray.append(user5)
//    }
    
    func goToShakeInstructions() {
        let shakeInstVC = ShakeInstructionViewController()
        self.navigationController?.pushViewController(shakeInstVC, animated: true)
    }
    
    //Firebase functions --- this can be refined in firebaseManager during refactoring
    // Get tagalongs
    func getTags(){
        FirebaseManager.newTagalongRefHandle = FirebaseManager.ref.child("tagalongs").observe(.childAdded, with: { (snapshot) -> Void in
            
            let tagDict = snapshot.value as! [String: Any]
            let tagId = snapshot.key
            var tagalong = Tagalong(snapshot: tagDict, tagID: tagId)
            
            print("****************"+tagId)
            
            FirebaseManager.createUserFrom(tagalong: tagId, completion: { (user) in
                tagalong.user = user

                self.tagalongs.append(tagalong)
                self.myTableView.reloadData()
            })
            
        })
        
    }
    
    // MARK: - set up tableview
    func layoutTableView() {
        self.myTableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        myTableView.dataSource = self
        myTableView.delegate = self
//        myTableView.backgroundColor = phaedraOliveGreen
        myTableView.backgroundColor = phaedraLightGreen
        
        //this determines the size of the tableview
        myTableView.frame = CGRect(x: 0, y: 70, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.60)
        //        myTableView.layer.cornerRadius = 8
        
//        myTableView.register(TableViewCell.self, forCellReuseIdentifier: "tagAlongCell")
        
        myTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tagAlongCell")
        self.view.addSubview(myTableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Make this tagalongKey.count
        return self.tagalongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let myCell = tableView.dequeueReusableCell(withIdentifier: "tagAlongCell", for: indexPath) as! TableViewCell
        
        let selectedTag = self.tagalongs[indexPath.row]
        let fullName = selectedTag.user.firstName + " " + selectedTag.user.lastName
        
        myCell.userNameLabel.text = fullName
        myCell.userIndustryLabel.text = selectedTag.user.industry
        myCell.restNameLabel.text = selectedTag.restaurant
        myCell.restDistLabel.text = "0.4"
        myCell.diningTimeLabel.text = "1:00pm"
        myCell.userImageView?.image = UIImage(named: "rock.png")
        
        return myCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        let selectedTag = tagalongs[indexPath.row]
        
        //ERICA added this nav controller code below
        let waitingForHostVC = WaitingForHostViewController()
        self.navigationController?.pushViewController(waitingForHostVC, animated: true)
        
        ///////////////////////////////
        // Create an alert to confirm tagalong request. Once user had confirmed, this function will be added to the alert
        FirebaseManager.requestTagAlong(key: selectedTag.tagID)
                
        // Store tagalongID and userID to firebase (This ID will later be used to observe child values for requests)
        store.selectedTagAlongID = selectedTag.tagID
        store.guestID = FirebaseManager.currentUser
        
        // Remove tagalongID from Array
//        for (index, value) in tagalongs.enumerated() {
//            if value == selectedTag {
//                tagalongs.remove(at: index)
//            }
//        }
        
        
    }
    
    
}
