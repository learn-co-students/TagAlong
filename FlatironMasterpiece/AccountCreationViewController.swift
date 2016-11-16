//
//  ViewController.swift
//  CreationAccount
//
//  Created by Joyce Matos on 11/16/16.
//  Copyright © 2016 Joyce Matos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var createAccountLabel = UILabel()
    var firstNameEntry = UITextField()
    var lastNameEntry = UITextField()
    var emailEntry = UITextField()
    var passwordEntry = UITextField()
    var passwordVerification = UITextField()
    var industryEntry = UITextField()
    var jobEntry = UITextField()
    var createAccountButton = UIButton()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(createAccountLabel)
        createAccountLabel.text = "Create Account"
        createAccountLabel.textAlignment = .center
        createAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        createAccountLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -250).isActive = true
        createAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        createAccountLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        createAccountLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        view.addSubview(firstNameEntry)
        firstNameEntry.placeholder = "  First Name"
        firstNameEntry.layer.borderWidth = 1
        firstNameEntry.layer.cornerRadius = 8
        firstNameEntry.layer.borderColor = UIColor.lightGray.cgColor
        // TODO: - Fix text field borders to include light grey outline.
        firstNameEntry.clearsOnBeginEditing = true
        firstNameEntry.translatesAutoresizingMaskIntoConstraints = false
        firstNameEntry.topAnchor.constraint(equalTo: createAccountLabel.bottomAnchor, constant: 30).isActive = true
        firstNameEntry.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        firstNameEntry.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        firstNameEntry.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        view.addSubview(lastNameEntry)
        lastNameEntry.placeholder = "  Last Name"
        lastNameEntry.layer.borderWidth = 1
        lastNameEntry.layer.cornerRadius = 8
        lastNameEntry.layer.borderColor = UIColor.lightGray.cgColor
        // TODO: - Fix text field borders to include light grey outline.
        lastNameEntry.clearsOnBeginEditing = true
        lastNameEntry.translatesAutoresizingMaskIntoConstraints = false
        lastNameEntry.topAnchor.constraint(equalTo: firstNameEntry.bottomAnchor, constant: 10).isActive = true
        lastNameEntry.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        lastNameEntry.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        lastNameEntry.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        view.addSubview(emailEntry)
        emailEntry.placeholder = "  Email Address"
        emailEntry.layer.borderWidth = 1
        emailEntry.layer.cornerRadius = 8
        emailEntry.layer.borderColor = UIColor.lightGray.cgColor
        // TODO: - Fix text field borders to include light grey outline.
        emailEntry.clearsOnBeginEditing = true
        emailEntry.translatesAutoresizingMaskIntoConstraints = false
        emailEntry.topAnchor.constraint(equalTo: lastNameEntry.bottomAnchor, constant: 10).isActive = true
        emailEntry.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        emailEntry.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        emailEntry.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        view.addSubview(passwordEntry)
        passwordEntry.placeholder = "  Password"
        passwordEntry.layer.borderWidth = 1
        passwordEntry.layer.cornerRadius = 8
        passwordEntry.layer.borderColor = UIColor.lightGray.cgColor
        // TODO: - Fix text field borders to include light grey outline.
        passwordEntry.clearsOnBeginEditing = true
        passwordEntry.translatesAutoresizingMaskIntoConstraints = false
        passwordEntry.topAnchor.constraint(equalTo: emailEntry.bottomAnchor, constant: 10).isActive = true
        passwordEntry.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        passwordEntry.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        passwordEntry.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        view.addSubview(passwordVerification)
        passwordVerification.placeholder = "  Verify Password"
        passwordVerification.layer.borderWidth = 1
        passwordVerification.layer.cornerRadius = 8
        passwordVerification.layer.borderColor = UIColor.lightGray.cgColor
        // TODO: - Fix text field borders to include light grey outline.
        passwordVerification.clearsOnBeginEditing = true
        passwordVerification.translatesAutoresizingMaskIntoConstraints = false
        passwordVerification.topAnchor.constraint(equalTo: passwordEntry.bottomAnchor, constant: 10).isActive = true
        passwordVerification.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        passwordVerification.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        passwordVerification.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
      
        view.addSubview(industryEntry)
        industryEntry.placeholder = "  Industry"
        industryEntry.layer.borderWidth = 1
        industryEntry.layer.cornerRadius = 8
        industryEntry.layer.borderColor = UIColor.lightGray.cgColor
        // TODO: - Fix text field borders to include light grey outline.
        industryEntry.clearsOnBeginEditing = true
        industryEntry.translatesAutoresizingMaskIntoConstraints = false
        industryEntry.topAnchor.constraint(equalTo: passwordVerification.bottomAnchor, constant: 10).isActive = true
        industryEntry.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        industryEntry.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        industryEntry.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
       
        
        
        view.addSubview(jobEntry)
        jobEntry.placeholder = "  Job Title"
        jobEntry.layer.borderWidth = 1
        jobEntry.layer.cornerRadius = 8
        jobEntry.layer.borderColor = UIColor.lightGray.cgColor
        // TODO: - Fix text field borders to include light grey outline.
        jobEntry.clearsOnBeginEditing = true
        jobEntry.translatesAutoresizingMaskIntoConstraints = false
        jobEntry.topAnchor.constraint(equalTo: industryEntry.bottomAnchor, constant: 10).isActive = true
        jobEntry.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        jobEntry.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        jobEntry.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        view.addSubview(createAccountButton)
        createAccountButton.setTitle("Create Account", for: UIControlState.normal)
        createAccountButton.setTitleColor(UIColor.blue, for: UIControlState.normal)

        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        createAccountButton.topAnchor.constraint(equalTo: jobEntry.bottomAnchor, constant: 40).isActive = true
        createAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        createAccountButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        createAccountButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true

        
        
        
        
        
        
        
    }




}

