//
//  LogInViewController.swift
//  FlatironMasterpiece
//
//  Created by Nick Rigano on 11/17/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var loginLabel = UILabel()
        var loginEmail = UITextField()
        var loginPassword = UITextField()
        var registerButton = UIButton()
        var forgotEmailButton = UIButton()
        var loginButton = UIButton()
        
        
        view.addSubview(loginLabel)
        loginLabel.text = "Log In"
        loginLabel.textAlignment = .center
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -250).isActive = true
        loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        loginLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        loginLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        // login email Textfield
        view.addSubview(loginEmail)
        loginEmail.placeholder = "  Email Address"
        loginEmail.layer.borderWidth = 1
        loginEmail.layer.cornerRadius = 5
        loginEmail.layer.borderColor = UIColor.lightGray.cgColor
        loginEmail.translatesAutoresizingMaskIntoConstraints = false
        loginEmail.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 30).isActive = true
        loginEmail.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        loginEmail.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        loginEmail.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        

    
    
    
    
    
    }


}
