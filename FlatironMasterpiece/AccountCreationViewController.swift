

//
//  ViewController.swift
//  CreationAccount
//
//  Created by Joyce Matos on 11/16/16.
//  Copyright © 2016 Joyce Matos. All rights reserved.
//



//Fix compressed image on background
// XX make image selector appear when button pressed
//replace button background with image when selected


import UIKit
import Foundation
import FirebaseAuth
import Firebase
import FirebaseDatabase
import CoreLocation

struct Constants {
    static let FIRSTNAME = "firstNameTextField"
    static let LASTNAME = "lastNameTextField"
    static let EMAILCONFIRMATION = "emailTextField"
    static let PASSWORD = "password"
    static let PASSWORDVERIFICATION = "passwordverification"
    static let INDUSTRY = "industry"
    static let JOBTITLE = "jobtitle"

}


class AccountCreationViewController: UIViewController, CLLocationManagerDelegate , UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var createAccountLabel = UILabel()
    var firstNameEntry = UITextField()
    var lastNameEntry = UITextField()
    var emailEntry = UITextField()
    var passwordEntry = UITextField()
    var passwordVerification = UITextField()
    var industryEntry = UITextField()
    var jobEntry = UITextField()
    var createAccountButton = UIButton()
    var picButton = UIButton()
    var picImage = UIImageView()
  
    var firstNameConfirmed = false
    var lastNameConfirmed = false
    var emailConfirmed = false
    var password = false
    var industry = false
    var jobtitle = false
  
    let store = FirebaseManager.shared

    var manager = CLLocationManager()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        Locate()

        //Just this line creates the blur
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"foodWoodenTable")!)
        //below this creates the actual picture
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "foodWoodenTable")?.draw(in: self.view.bounds)

        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!

        UIGraphicsEndImageContext()

        self.view.backgroundColor = UIColor(patternImage: image)

        createViews()
                let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
 //       view.backgroundColor = phaedraLightGreen
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
  
    func Locate() {
        
        manager.delegate = self
                manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        func locationManager(manager: CLLocationManager,
                             didChangeAuthorizationStatus status: CLAuthorizationStatus)
        {
            if status == .authorizedAlways || status == .authorizedWhenInUse {
                manager.startUpdatingLocation()
                // ...
            }
        }
    }
  
    //ELI - revisit this func
    func tapCreateButtonOnce() {
        self.createAccountButton.isEnabled = false
        let tap = UITapGestureRecognizer(target: self, action: Selector("tapDelay"))
        tap.numberOfTapsRequired = 1
        createAccountButton.addGestureRecognizer(tap)
        //       Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: <#T##(Timer) -> Void#>)
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: "enableButton", userInfo: nil, repeats: false)
        //createAccountButton.addGestureRecognizer(tap)
    }

    func enableButton() {
        createAccountButton.isEnabled = true
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
        createAccountLabel.font = UIFont(name: "OpenSans-Bold", size: 20.0)
        createAccountLabel.textColor = UIColor.white
        createAccountLabel.textAlignment = .center
        createAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        createAccountLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -180).isActive = true
        createAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        createAccountLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        createAccountLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        // First Name Textfield
        view.addSubview(firstNameEntry)
        firstNameEntry.placeholder = "First Name"
        
        firstNameEntry.backgroundColor = UIColor.white
        firstNameEntry.textAlignment = .center
        firstNameEntry.layer.borderWidth = 2
        firstNameEntry.layer.cornerRadius = 5
        firstNameEntry.font = UIFont(name: "Abel-Regular", size: 14.0)
        firstNameEntry.layer.borderColor = phaedraDarkGreen.cgColor
        firstNameEntry.translatesAutoresizingMaskIntoConstraints = false
        firstNameEntry.topAnchor.constraint(equalTo: createAccountLabel.bottomAnchor, constant: 20).isActive = true
        firstNameEntry.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        firstNameEntry.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        firstNameEntry.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        // Last Name Textfield
        view.addSubview(lastNameEntry)
        lastNameEntry.placeholder = "Last Name"
        lastNameEntry.textAlignment = .center
        lastNameEntry.layer.borderWidth = 2
        lastNameEntry.layer.cornerRadius = 5
        lastNameEntry.layer.borderColor = phaedraDarkGreen.cgColor
        lastNameEntry.font = UIFont(name: "Abel-Regular", size: 14.0)
        lastNameEntry.backgroundColor = UIColor.white
        
        lastNameEntry.translatesAutoresizingMaskIntoConstraints = false
        lastNameEntry.topAnchor.constraint(equalTo: firstNameEntry.bottomAnchor, constant: 10).isActive = true
        lastNameEntry.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        lastNameEntry.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        lastNameEntry.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        // Email Address Texfield
        view.addSubview(emailEntry)
        emailEntry.placeholder = "Email Address"
        emailEntry.layer.borderWidth = 2
        emailEntry.layer.cornerRadius = 5
        emailEntry.layer.borderColor = phaedraDarkGreen.cgColor
        emailEntry.font = UIFont(name: "Abel-Regular", size: 14.0)
        emailEntry.textAlignment = .center
        emailEntry.backgroundColor = UIColor.white
        emailEntry.translatesAutoresizingMaskIntoConstraints = false
        emailEntry.topAnchor.constraint(equalTo: lastNameEntry.bottomAnchor, constant: 10).isActive = true
        emailEntry.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        emailEntry.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        emailEntry.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        // Password Textfield
        view.addSubview(passwordEntry)
        passwordEntry.placeholder = "Password"
        passwordEntry.layer.borderWidth = 2
        passwordEntry.layer.cornerRadius = 5
        passwordEntry.layer.borderColor = phaedraDarkGreen.cgColor
        passwordEntry.font = UIFont(name: "Abel-Regular", size: 14.0)
        passwordEntry.textAlignment = .center
        passwordEntry.backgroundColor = UIColor.white
        
        passwordEntry.translatesAutoresizingMaskIntoConstraints = false
        passwordEntry.topAnchor.constraint(equalTo: emailEntry.bottomAnchor, constant: 10).isActive = true
        passwordEntry.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        passwordEntry.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        passwordEntry.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        // Password Verification Textfield
        view.addSubview(passwordVerification)
        passwordVerification.placeholder = "Verify Password"
        passwordVerification.layer.borderWidth = 2
        passwordVerification.layer.cornerRadius = 5
        passwordVerification.layer.borderColor = phaedraDarkGreen.cgColor
        passwordVerification.font = UIFont(name: "Abel-Regular", size: 14.0)
        passwordVerification.textAlignment = .center
        
        passwordVerification.backgroundColor = UIColor.white
        passwordVerification.translatesAutoresizingMaskIntoConstraints = false
        passwordVerification.topAnchor.constraint(equalTo: passwordEntry.bottomAnchor, constant: 10).isActive = true
        passwordVerification.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        passwordVerification.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        passwordVerification.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        // Industry Textfield
        view.addSubview(industryEntry)
        industryEntry.placeholder = "Industry"
        industryEntry.layer.borderWidth = 2
        industryEntry.layer.cornerRadius = 5
        industryEntry.layer.borderColor = phaedraDarkGreen.cgColor
        industryEntry.font = UIFont(name: "Abel-Regular", size: 14.0)
        industryEntry.textAlignment = .center
        industryEntry.backgroundColor = UIColor.white
        industryEntry.translatesAutoresizingMaskIntoConstraints = false
        industryEntry.topAnchor.constraint(equalTo: passwordVerification.bottomAnchor, constant: 10).isActive = true
        industryEntry.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        industryEntry.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        industryEntry.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        // Job Title Textfield
        view.addSubview(jobEntry)
        jobEntry.placeholder = "Job Title"
        jobEntry.layer.borderWidth = 2
        jobEntry.layer.cornerRadius = 5
        jobEntry.layer.borderColor = phaedraDarkGreen.cgColor
        jobEntry.font = UIFont(name: "Abel-Regular", size: 14.0)
        jobEntry.textAlignment = .center
        jobEntry.backgroundColor = UIColor.white
        jobEntry.translatesAutoresizingMaskIntoConstraints = false
        jobEntry.topAnchor.constraint(equalTo: industryEntry.bottomAnchor, constant: 10).isActive = true
        jobEntry.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        jobEntry.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
        jobEntry.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        
        // Create Account Button
        view.addSubview(createAccountButton)
        
        createAccountButton.addTarget(self, action: #selector(createAccountButtonTapped(sender:)), for: .touchUpInside)
        createAccountButton.setTitle("Create Account", for: UIControlState.normal)
        createAccountButton.titleLabel?.font = UIFont(name: "Abel-Regular", size: 18.0)
        createAccountButton.setTitleColor(phaedraDarkGreen, for: UIControlState.normal)
        createAccountButton.backgroundColor = phaedraYellow
        createAccountButton.layer.borderColor = phaedraDarkGreen.cgColor
        createAccountButton.layer.borderWidth = 2
        createAccountButton.layer.cornerRadius = 6
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        createAccountButton.topAnchor.constraint(equalTo: jobEntry.bottomAnchor, constant: 40).isActive = true
        createAccountButton.specialConstrain(to: view)
        
    }

    func selectProfileImage() {
        print(123)
        
        let picker = UIImagePickerController()
        picker.delegate = self
        print("I WANNA EDIT A DAMN PHOTO")
        picker.isEditing = true
        picker.allowsEditing = true
        
        
        present(picker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       
        var selectedImageFromPicker: UIImage?
       
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {

            
            print("This is an edited image \(editedImage)")
            selectedImageFromPicker = editedImage
        } else if let original = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            print("This is the original \(original)")
            selectedImageFromPicker = original
        }
     
        
        
        if let selectedImage = selectedImageFromPicker {
            let data = UIImagePNGRepresentation(selectedImage)
            guard let imageData = data else { return }
            print("okkkkkkkkk\(imageData)")
            FirebaseManager.sendToStorage(data: imageData, handler: { success in
                print("*************\(FirebaseManager.currentUser)")
                print("view should dismiss")
                
                super.dismiss(animated: true, completion: nil)
                
                
            })
            picImage.image = selectedImage
    }
}

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
        print("Really, dismiss!")
        //AccountCreationViewController()
    }


    func sendEmail() {

        FirebaseManager.sendEmailVerification()
    }

    //ERICA - what is this?  Who wrote this?  What is it for?
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }


    func createAccountButtonTapped(sender: UIButton!) {
        createAccountButton.isEnabled = false
        // TODO: Disable button
        //        createAccountButton.isEnabled = true
                let tapGesture = UITapGestureRecognizer(target: self, action: "disableButton" )
                let tapped = tapGesture.numberOfTapsRequired == 1
        //        if tapGesture.numberOfTapsRequired == 1 {
        //            createAccountButton.isEnabled = false
        //        }
        //        createAccountButton.addGestureRecognizer(tapGesture )

        if (firstNameEntry.text?.isEmpty)! || (lastNameEntry.text?.isEmpty)! || (emailEntry.text?.isEmpty)! || (passwordEntry.text?.isEmpty)! || (passwordVerification.text?.isEmpty)! || (industryEntry.text?.isEmpty)! || (jobEntry.text?.isEmpty)! {
            //       self.ref.child("users").child(user.uid).setValue(["username": firstName])
            print("PRESS ACCOUNT BUTTON")
            let invalidCredentialsAlert = UIAlertController(title: "Invalid Submission", message: "Please complete the entire form.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                print("User clicked alert controller")
                self.createAccountButton.isEnabled = true
            })
            invalidCredentialsAlert.addAction(okAction)
            self.present(invalidCredentialsAlert, animated: true, completion: nil)
        }

        guard let firstName = firstNameEntry.text, !firstName.isEmpty else { print("Need first name"); return }
        guard let lastName = lastNameEntry.text, !lastName.isEmpty else { print("Need a last name"); return }
        guard let email = emailEntry.text, !email.isEmpty else { print("No email"); return }
        guard let password = passwordEntry.text, !password.isEmpty else { print("Password doesn't meet reqs"); return }
        guard let passwordVerify = passwordVerification.text, !passwordVerify.isEmpty else { print("Password doesn't match"); return }
        guard let industry = industryEntry.text, !industry.isEmpty else { print("Need an industry"); return }
        guard let job = jobEntry.text, !job.isEmpty else { print("Need a job"); return }
        //let userID = FirebaseManager.currentUser
       // let userID = store.currentUser.userID
        
    
        //TODO: - Add a check to see if password matches password verification
        print("Enter email or password")
 
        //ERICA - THIS SHOULD PROBABLY BE DELETED
        if firstName != "" && lastName != "" && email != "" && password != "" && passwordVerify != "" && industry != "" && job != "" {
            //       self.ref.child("users").child(user.uid).setValue(["username": firstName])
        }

        //1 - create an instance of a user

        let currentUser = User(firstName: firstName, lastName: lastName, emailAddress: email, passWord: password, industry: industry, jobTitle: job )


        //2 - called on FirebaseManger to create a user based on the above currentUser
        FirebaseManager.createNewUser(currentUser: currentUser, completion: { success,user in

            if success {  
                
                currentUser.userID = (FIRAuth.auth()?.currentUser?.uid)!

                self.store.currentUser = user
        

                let selectPhotoVC = SelectPhotoViewController()
                self.navigationController?.pushViewController(selectPhotoVC, animated: true)

            } else {
                    print("error!")
                    let invalidCredentialsAlert = UIAlertController(title: "Invalid Submission", message: "An account with this information already exists.  Please login.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    print("User clicked alert controller")})
                    invalidCredentialsAlert.addAction(okAction)
                    self.present(invalidCredentialsAlert, animated: true, completion: nil)
            }

        })

    }//end of createAccountButtonTapped

    
}

