//
//  RestaurantChatViewController.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 12/8/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit

class RestaurantChatViewController: UIViewController {
    
    var goToChatLabel = UILabel()
    var chatButton: UIButton = UIButton(frame: CGRect(x: 100, y: 500, width: 100, height: 30))

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = phaedraDarkGreen
        setupViews()
    }
  
    func setupViews() {
        view.addSubview(chatButton)
        chatButton.backgroundColor = phaedraOrange
        chatButton.layer.cornerRadius = 7
        chatButton.layer.borderWidth = 2
        chatButton.layer.borderColor = phaedraDarkGreen.cgColor
        chatButton.setTitle("Chat with Tag Along", for: .normal)
        chatButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 16.0)
        chatButton.titleLabel?.textAlignment = .center
        chatButton.translatesAutoresizingMaskIntoConstraints = false
        chatButton.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 400).isActive = true
        chatButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chatButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.60).isActive = true
        chatButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08).isActive = true
        chatButton.addTarget(self, action: #selector(goToChatVC), for: .touchUpInside)
        chatButton.setTitleColor(phaedraYellow, for: .normal)
        chatButton.setTitleColor(phaedraLightGreen, for: .highlighted)
        
        view.addSubview(goToChatLabel)
        goToChatLabel.text = "You've got a Tag Along!"
        goToChatLabel.font = UIFont(name: "OpenSans-Bold", size: 30.0)
        goToChatLabel.textColor = phaedraYellow
        goToChatLabel.lineBreakMode = .byWordWrapping
        goToChatLabel.numberOfLines = 0
        goToChatLabel.textAlignment = .center
        goToChatLabel.translatesAutoresizingMaskIntoConstraints = false
        goToChatLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        goToChatLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        goToChatLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
    }
    
    func goToChatVC() {
        print("chat button getting tapped")
        let chatVC = ChatViewController()
        //Erica's old nav controller
        //self.navigationController?.pushViewController(chatVC, animated: true)
        
        //Johann's test
//        self.present(chatVC, animated: true, completion: nil)


    }

}
