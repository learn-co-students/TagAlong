//
//  FinalViewController.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 11/27/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit

class TagAlongViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UIView!
    
    var tagAlongUserArray:[User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = phaedraDarkGreen
        createFakeUsers()
        layoutTableView()
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

    // MARK: - set up tableview
    func layoutTableView() {
        var myTableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.backgroundColor = phaedraDarkGreen
        //this determines the size of the tableview
        myTableView.frame = CGRect(x: 10, y: 50, width: 350, height: 400)
        myTableView.layer.cornerRadius = 6
        
        myTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tagAlongCell")
        self.view.addSubview(myTableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: - 5 is a default value, we can change this number of cells
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "tagAlongCell", for: indexPath) as! TableViewCell
        let fullName = tagAlongUserArray[indexPath.row].firstName + " " + tagAlongUserArray[indexPath.row].lastName
        myCell.userNameLabel.text = fullName
        myCell.userIndustryLabel.text = tagAlongUserArray[indexPath.row].industry
        myCell.restNameLabel.text = "Applebees"
        myCell.restDistLabel.text = "0.4"
        myCell.diningTimeLabel.text = "1:00pm"
        myCell.userImageView?.image = UIImage(named: "asian.png")
    
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
