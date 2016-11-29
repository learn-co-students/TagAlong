//
//  FinalViewController.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/27/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit

class TagAlongViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tagAlongUsersLabel: UILabel = UILabel()
    
    var tagAlongUserArray:[User] = []
    
    let cuisineImage:[UIImage] = [UIImage(named: "american")!, UIImage(named:"asian")!, UIImage(named: "Healthy")!, UIImage(named: "Italian")!, UIImage(named: "Latin3x")!, UIImage(named: "Unhealthy2x")!]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = phaedraOliveGreen
        formatLabels()
        createFakeUsers()
        layoutTableView()
        layoutScrollView()
    }
    
    func formatLabels() {
        view.addSubview(tagAlongUsersLabel)
        tagAlongUsersLabel.text = "Choose a Tag Along"
        // TODO: - decide on preferences label font and font size
        tagAlongUsersLabel.font = UIFont(name: "AvenirNext-Bold", size: 20.0)
        tagAlongUsersLabel.textColor = phaedraYellow
        tagAlongUsersLabel.textAlignment = .center
        tagAlongUsersLabel.translatesAutoresizingMaskIntoConstraints = false
        tagAlongUsersLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -300).isActive = true
        tagAlongUsersLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        tagAlongUsersLabel.specialConstrain(to: view)
    }
    
    func createFakeUsers() {
        let user1:User = User(firstName: "Dwayne", lastName: "Johnson", emailAddress: "therock@peoplesElbow.com", passWord: "rock", industry: "Entertainment", jobTitle: "Beast")
        let user2:User = User(firstName: "Erica", lastName: "Millado", emailAddress: "erica@lovestacos.com", passWord: "tacos", industry: "iOS", jobTitle: "iOS Developer")
        let user3:User = User(firstName: "Michelle", lastName: "Obama", emailAddress: "michelle@firstlady.com", passWord: "first", industry: "Being Awesome", jobTitle: "BossLady")
        let user4: User = User(firstName: "Johann", lastName: "Kerr", emailAddress: "johann@kerr.com", passWord: "ilovecode", industry: "iOS", jobTitle: "instructor")
        let user5: User = User(firstName: "Kermit", lastName: "The Frog", emailAddress: "livin@thegreenlife.com", passWord: "frogs", industry: "Entertainment", jobTitle: "Comedian")
        tagAlongUserArray.append(user1)
        tagAlongUserArray.append(user2)
        tagAlongUserArray.append(user3)
        tagAlongUserArray.append(user4)
        tagAlongUserArray.append(user5)
    }

    func layoutScrollView() {
//        var myImageView: UIImageView!
//        var aspectRatio: NSLayoutConstraint?
//        let burger = UIImage(named: "american")
//        myImageView = UIImageView(image: burger)
//        aspectRatio = NSLayoutConstraint(item: myImageView, attribute: .height, relatedBy: .lessThanOrEqual, toItem: myImageView, attribute: .width, multiplier: (burger?.size.height)!/(burger?.size.width)!, constant: 1)
//        myImageView.addConstraint(aspectRatio!)
        
//        let myScrollView = UIScrollView(frame: CGRect(x: 0, y: 465, width: 380, height: 180))
//        myScrollView.backgroundColor = phaedraOrange
//        myScrollView.addSubview(myImageView)
//        myScrollView.contentSize = myImageView.frame.size
//        view.addSubview(myScrollView)
        
        let myScrollView: UIScrollView = UIScrollView(frame: CGRect(x: 0, y: 465, width: 380, height: 180))
        let imageWidth: CGFloat = 355
        let imageHeight: CGFloat = 180
        var xPosition: CGFloat = 10
        var yPosition: CGFloat = 0
        var scrollViewContentSize: CGFloat = 0
        
        for image in cuisineImage {
            let myImage: UIImage = image
            let myImageView: UIImageView = UIImageView()
            myImageView.image = myImage
            
            myImageView.contentMode = UIViewContentMode.scaleAspectFit
            myImageView.frame.size.width = imageWidth
            myImageView.frame.size.height = imageHeight
            myImageView.center = self.view.center
            myImageView.frame.origin.x = xPosition
            myImageView.frame.origin.y = yPosition
            
            myScrollView.addSubview(myImageView)
            
            let spacer: CGFloat = 30
//            yPosition += imageHeight + spacer
            xPosition += imageWidth + spacer
//            scrollViewContentSize += imageHeight
            scrollViewContentSize += imageWidth
            
            
            myScrollView.contentSize = CGSize(width: imageWidth, height: scrollViewContentSize)
            myScrollView.contentSize = CGSize(width: scrollViewContentSize + 175, height: imageHeight)
        }
        
        view.addSubview(myScrollView)
    
    }
    
    
    
    
    // MARK: - set up tableview
    func layoutTableView() {
        var myTableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.backgroundColor = phaedraOliveGreen
        
        //this determines the size of the tableview
        myTableView.frame = CGRect(x: 0, y: 50, width: 380, height: 400)
//        myTableView.layer.cornerRadius = 8
        
        
        myTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tagAlongCell")
        self.view.addSubview(myTableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: - 4 is a default value, we can change this number of cells
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "tagAlongCell", for: indexPath) as! TableViewCell
        let fullName = tagAlongUserArray[indexPath.row].firstName + " " + tagAlongUserArray[indexPath.row].lastName
        myCell.userNameLabel.text = fullName
        myCell.userIndustryLabel.text = tagAlongUserArray[indexPath.row].industry
        myCell.restNameLabel.text = "Applebees"
        myCell.restDistLabel.text = "0.4"
        myCell.diningTimeLabel.text = "1:00pm"
        myCell.userImageView?.image = UIImage(named: "rock.png")
    
        return myCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
