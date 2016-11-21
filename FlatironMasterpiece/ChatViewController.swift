//
//  ChatViewController.swift
//  FlatironMasterpiece
//
//  Created by Joyce Matos on 11/21/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var chatView = UITableView()
    var messages = ["Message", "Testing", "Tableview"]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = UIColor.white

        chatView.translatesAutoresizingMaskIntoConstraints = false
        chatView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -250).isActive = true
        chatView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        chatView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        chatView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.50).isActive = true

        
        
        
        chatView.delegate = self
        chatView.dataSource = self
        chatView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(chatView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = messages[indexPath.row]
        
        return cell
    }
    
    


}
