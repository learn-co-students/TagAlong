//
//  ViewController.swift
//  CreationAccount
//
//  Created by Joyce Matos on 11/16/16.
//  Copyright © 2016 Joyce Matos. All rights reserved.
//

import UIKit

class AccountCreationViewController: UIViewController {

    var createAccountLabel = UILabel()
    var firstNameEntry = UITextField()
    var lastNameEntry = UITextField()
    var emailEntry = UITextField()
    var passwordEntry = UITextField()
    var passwordVerification = UITextField()
    var industryEntry = UITextField()
    var jobEntry = UITextField()
    var createAccountButton = UIButton()

    var firstNameConfirmed = false
    var lastNameConfirmed = false
    var emailConfirmed = false
    var password = false
    var industry = false
    var jobtitle = false
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViews()
        
        view.backgroundColor = UIColor.white
        
//        let specialViews: [UIView] = [createAccountLabel, firstNameEntry, lastNameEntry, emailEntry]
//        
//        for specialView in specialViews {
//            
//            specialView.specialConstrain(to: view)
//            
//        }
        
    }

}

// MARK: Validation
extension UIView {
    
    func specialConstrain(to view: UIView) {
        
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        self.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        self.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        
        
    }
    
    
}


// MARK: Set Up

extension AccountCreationViewController {

    func createViews() {
        
        // Create Account Label
        view.addSubview(createAccountLabel)
        createAccountLabel.text = "Create Account"
        createAccountLabel.textAlignment = .center
        createAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        createAccountLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -250).isActive = true
        createAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        createAccountLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        createAccountLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        // First Name Textfield
        view.addSubview(firstNameEntry)
        firstNameEntry.placeholder = "  First Name"
        firstNameEntry.layer.borderWidth = 1
        firstNameEntry.layer.cornerRadius = 5
        firstNameEntry.layer.borderColor = UIColor.lightGray.cgColor
        firstNameEntry.translatesAutoresizingMaskIntoConstraints = false
        firstNameEntry.topAnchor.constraint(equalTo: createAccountLabel.bottomAnchor, constant: 30).isActive = true
        firstNameEntry.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        firstNameEntry.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        firstNameEntry.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        
        // Last Name Textfield
        view.addSubview(lastNameEntry)
        lastNameEntry.placeholder = "  Last Name"
        lastNameEntry.layer.borderWidth = 1
        lastNameEntry.layer.cornerRadius = 5
        lastNameEntry.layer.borderColor = UIColor.lightGray.cgColor
        lastNameEntry.translatesAutoresizingMaskIntoConstraints = false
        lastNameEntry.topAnchor.constraint(equalTo: firstNameEntry.bottomAnchor, constant: 10).isActive = true
        lastNameEntry.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        lastNameEntry.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        lastNameEntry.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        // Email Address Texfield
        view.addSubview(emailEntry)
        emailEntry.placeholder = "  Email Address"
        emailEntry.layer.borderWidth = 1
        emailEntry.layer.cornerRadius = 5
        emailEntry.layer.borderColor = UIColor.lightGray.cgColor
        emailEntry.translatesAutoresizingMaskIntoConstraints = false
        emailEntry.topAnchor.constraint(equalTo: lastNameEntry.bottomAnchor, constant: 10).isActive = true
        emailEntry.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        emailEntry.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        emailEntry.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        // Password Textfield
        view.addSubview(passwordEntry)
        passwordEntry.placeholder = "  Password"
        passwordEntry.layer.borderWidth = 1
        passwordEntry.layer.cornerRadius = 5
        passwordEntry.layer.borderColor = UIColor.lightGray.cgColor
        passwordEntry.translatesAutoresizingMaskIntoConstraints = false
        passwordEntry.topAnchor.constraint(equalTo: emailEntry.bottomAnchor, constant: 10).isActive = true
        passwordEntry.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        passwordEntry.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        passwordEntry.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        // Password Verification Textfield
        view.addSubview(passwordVerification)
        passwordVerification.placeholder = "  Verify Password"
        passwordVerification.layer.borderWidth = 1
        passwordVerification.layer.cornerRadius = 5
        passwordVerification.layer.borderColor = UIColor.lightGray.cgColor
        passwordVerification.translatesAutoresizingMaskIntoConstraints = false
        passwordVerification.topAnchor.constraint(equalTo: passwordEntry.bottomAnchor, constant: 10).isActive = true
        passwordVerification.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        passwordVerification.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        passwordVerification.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        // Industry Textfield
        view.addSubview(industryEntry)
        industryEntry.placeholder = "  Industry"
        industryEntry.layer.borderWidth = 1
        industryEntry.layer.cornerRadius = 5
        industryEntry.layer.borderColor = UIColor.lightGray.cgColor
        industryEntry.translatesAutoresizingMaskIntoConstraints = false
        industryEntry.topAnchor.constraint(equalTo: passwordVerification.bottomAnchor, constant: 10).isActive = true
        industryEntry.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        industryEntry.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        industryEntry.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        // Job Title Textfield
        view.addSubview(jobEntry)
        jobEntry.placeholder = "  Job Title"
        jobEntry.layer.borderWidth = 1
        jobEntry.layer.cornerRadius = 5
        jobEntry.layer.borderColor = UIColor.lightGray.cgColor
        jobEntry.translatesAutoresizingMaskIntoConstraints = false
        jobEntry.topAnchor.constraint(equalTo: industryEntry.bottomAnchor, constant: 10).isActive = true
        jobEntry.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        jobEntry.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        jobEntry.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        // Create Account Button
        view.addSubview(createAccountButton)
        createAccountButton.setTitle("Create Account", for: UIControlState.normal)
        createAccountButton.setTitleColor(UIColor.blue, for: UIControlState.normal)
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        createAccountButton.topAnchor.constraint(equalTo: jobEntry.bottomAnchor, constant: 40).isActive = true
        createAccountButton.specialConstrain(to: view)
        
        
    }


}



