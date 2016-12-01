//
//  ViewController.swift
//  CreationAccount
//
//  Created by Joyce Matos on 11/16/16.
//  Copyright © 2016 Joyce Matos. All rights reserved.
//

import UIKit

import FirebaseAuth
import Firebase
import FirebaseDatabase


struct Constants {
    static let FIRSTNAME = "firstNameTextField"
    static let LASTNAME = "lastNameTextField"
    static let EMAILCONFIRMATION = "emailTextField"
    static let PASSWORD = "password"
    static let PASSWORDVERIFICATION = "passwordverification"
    static let INDUSTRY = "industry"
    static let JOBTITLE = "jobtitle"

}


class AccountCreationViewController: UIViewController {

    var ref: FIRDatabaseReference!

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

        self.ref = FIRDatabase.database().reference().root

        createViews()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        view.backgroundColor = UIColor.white
        firstNameEntry.accessibilityLabel = Constants.FIRSTNAME
        lastNameEntry.accessibilityLabel = Constants.LASTNAME
        emailEntry.accessibilityLabel = Constants.EMAILCONFIRMATION
        passwordEntry.accessibilityLabel = Constants.PASSWORD
        passwordEntry.isSecureTextEntry = true
        passwordEntry.autocapitalizationType = .none
        passwordVerification.accessibilityLabel = Constants.PASSWORDVERIFICATION
        passwordVerification.isSecureTextEntry = true
        passwordVerification.autocapitalizationType = .none
        industryEntry.accessibilityLabel = Constants.INDUSTRY
        jobEntry.accessibilityLabel = Constants.JOBTITLE
//        let specialViews: [UIView] = [createAccountLabel, firstNameEntry, lastNameEntry, emailEntry]
//
//        for specialView in specialViews {
//
//            specialView.specialConstrain(to: view)
//
//        }

    }

    func dismissKeyboard() {
     view.endEditing(true)
    }



    func createAccountButton(_ sender: UIButton) {
       print("working")
        guard let firstName = firstNameEntry.text, !firstName.isEmpty else { print("Need first name"); return }
        guard let lastName = lastNameEntry.text, !lastName.isEmpty else { print("Need a last name"); return }
        guard let email = emailEntry.text, !email.isEmpty else { print("No email"); return }
        guard let password = passwordEntry.text, !password.isEmpty else { print("Password doesn't meet reqs"); return }
        guard let passwordVerify = passwordVerification.text, !passwordVerify.isEmpty else { print("Password doesn't match"); return }
        guard let industry = industryEntry.text, !industry.isEmpty else { print("Need an industry"); return }
        guard let job = jobEntry.text, !job.isEmpty else { print("Need a job"); return }


        if firstName != "" && lastName != "" && email != "" && password != "" && passwordVerify != "" && industry != "" && job != "" {
     //       self.ref.child("users").child(user.uid).setValue(["username": firstName])
        }


        if email != "" && password != "" {
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                 //   self.ref.child("UID").child((user?.uid)!).setValue(email)

                   // self.ref.child("users").child((user?.uid)!).setValue(email)
                    self.ref.child("users").child((user?.uid)!).child("email").setValue(email)
                    self.ref.child("users").child((user?.uid)!).child("firstName").setValue(firstName)
                    self.ref.child("users").child((user?.uid)!).child("lastName").setValue(lastName)
                    self.ref.child("users").child((user?.uid)!).child("jobTitle").setValue(job)
                    self.ref.child("users").child((user?.uid)!).child("industry").setValue(industry)

                    print(email)
                    print(firstName)
                    print(lastName)
                    print(job)
                    print(industry)

                    
                    // Send to Preferences VC
                    let preferencesVC = PreferenceViewController()
                    self.navigationController?.pushViewController(preferencesVC, animated: true)

                } else {
                    //TODO: - create alert controller that says enter a password and email
                    if error != nil {
                        print(error!)
                    }
                }
        })

    }

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
        createAccountButton.addTarget(self, action: #selector(createAccountButtonTapped(sender:)), for: .touchUpInside)
        createAccountButton.setTitle("Create Account", for: UIControlState.normal)
        createAccountButton.setTitleColor(UIColor.blue, for: UIControlState.normal)
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        createAccountButton.topAnchor.constraint(equalTo: jobEntry.bottomAnchor, constant: 40).isActive = true
        createAccountButton.specialConstrain(to: view)
        createAccountButton.addTarget(self, action: #selector(AccountCreationViewController.createAccountButton(_:)), for: .touchUpInside)
        //createAccountButton.addTarget(self, action: "createAccountButton:", for: .touchUpInside)

    }


    func sendEmail() {
        FIRAuth.auth()?.currentUser?.sendEmailVerification(completion: { (error) in
            if error == nil {
                print("Email sent")
            }
            else {
                print(error?.localizedDescription)
            }
        })

    }




    func createAccountButtonTapped(sender: UIButton!) {

        if self.emailEntry.text == "" || passwordEntry.text == "" || passwordVerification.text == "" {


            //TODO: - Add a check to see if password matches password verification

            print("Enter email or password")
        }

        else {

            //TODO: Unwrap optionals for email and password

            FIRAuth.auth()?.createUser(withEmail: emailEntry.text!, password: passwordVerification.text!, completion: { (user, error) in

                if error == nil {
                    print("Successful Account Creation")
                   self.sendEmail()
                    //TODO: - Send user to the next screen after logging in

                }

                else {

                    //TODO: - Notify user of their error
                    print(error?.localizedDescription)

                }

            })
        }


    }

}

extension AccountCreationViewController {



}
