//
//  OnboardingViewController.swift
//  FlatironMasterpiece
//
//  Created by Erica Millado on 12/12/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    var welcomeLabel = UILabel()
    var goToLoginButton: UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 30))
    let friendsArray = ["👫", "👬", "👭", "🍔", "🌮", "🍕", "🍝", "🍜", "🍣", "🍰", "🍦", "🍻"] //11
    var friendsLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = phaedraOrange
        setupViews()
        

        // Do any additional setup after loading the view.
    }

    func setupViews() {
        view.addSubview(welcomeLabel)
        
        welcomeLabel.font = UIFont(name: "OpenSans-Bold", size: 33.0)
        welcomeLabel.lineBreakMode = .byWordWrapping
        welcomeLabel.numberOfLines = 0
        welcomeLabel.text = "Share a meal with someone, Tag Along for lunch!"
        welcomeLabel.textColor = phaedraYellow
        welcomeLabel.textAlignment = .center
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        welcomeLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
//        welcomeLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        view.addSubview(friendsLabel)
        friendsLabel.text = friendsArray[11]
        friendsLabel.textAlignment = .center
        friendsLabel.translatesAutoresizingMaskIntoConstraints = false
        friendsLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 50).isActive = true
        friendsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        friendsLabel.font = friendsLabel.font.withSize(102)
        
//        view.addSubview(waitingHostLabel)
//        waitingHostLabel.font = UIFont(name: "OpenSans-Semibold", size: 25.0)
//        waitingHostLabel.lineBreakMode = .byWordWrapping
//        waitingHostLabel.numberOfLines = 0
//        waitingHostLabel.text = "We're waiting for your host to approve the Tag Along!"
//        waitingHostLabel.textColor = phaedraYellow
//        waitingHostLabel.textAlignment = .center
//        waitingHostLabel.translatesAutoresizingMaskIntoConstraints = false
//        waitingHostLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
//        waitingHostLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
//        waitingHostLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        view.addSubview(goToLoginButton)
        goToLoginButton.backgroundColor = phaedraLightGreen
        goToLoginButton.layer.cornerRadius = 5
        goToLoginButton.layer.borderWidth = 2
        goToLoginButton.layer.borderColor = phaedraDarkGreen.cgColor
        goToLoginButton.setTitle("Let's Tag Along!", for: UIControlState.normal)
        goToLoginButton.setTitle("Tutorial Played", for: .highlighted)
        goToLoginButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 12.0)
        goToLoginButton.titleLabel?.textAlignment = .center
        goToLoginButton.translatesAutoresizingMaskIntoConstraints = false
        goToLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        goToLoginButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 200).isActive = true
        goToLoginButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        goToLoginButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        goToLoginButton.addTarget(self, action: #selector(gotoLogin), for: .touchUpInside)
        goToLoginButton.setTitleColor(phaedraDarkGreen, for: .normal)
        goToLoginButton.setTitleColor(phaedraYellow, for: .highlighted)
    }
    
    func gotoLogin() {
        let loginVC = LogInViewController()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }


}
