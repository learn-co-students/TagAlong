

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
    //static let shared = AccountCreationViewController()
   
    
    let phaedraDarkGreen = UIColor(red:0.00, green:0.64, blue:0.53, alpha:1.0)
    let phaedraOliveGreen = UIColor(red:0.47, green:0.74, blue:0.56, alpha:1.0)
    let phaedraLightGreen = UIColor(red:0.75, green:0.92, blue:0.62, alpha:1.0)
    let phaedraYellow = UIColor(red:1.00, green:1.00, blue:0.62, alpha:1.0)
    let phaedraOrange = UIColor(red:1.00, green:0.38, blue:0.22, alpha:1.0)

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
//        
    }
    
        
        
    func dismissKeyboard() {
        view.endEditing(true)
    }

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

  
    func selectProfileImage() {
        print(123)
        
        let picker = UIImagePickerController()
        picker.delegate = self
        print("I WANNA EDIT A DAMN PHOTO")
        picker.isEditing = true
        picker.allowsEditing = true
        
        
        present(picker, animated: true, completion: nil)
    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        print("cancelled PICKER")
//        
//    }
    
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
            
     //       FirebaseManager.ref.child("users").child(FirebaseManager.currentUser).child("profilePic").setValue(["\()" : true])
    
    }
}

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

//        view.addSubview(picButton)
//        //picButton.addTarget(self, action: #selector(picButtonTapped), for: .touchUpInside)
//        //   picButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: selector("selectProfileImage")))
//        picButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectProfileImage)))
//        //picButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectProfileImage)))
//        picButton.isUserInteractionEnabled = true
//        picButton.titleLabel?.numberOfLines = 2
//        picButton.setTitle("Add\nPic", for: UIControlState.normal)
//        picButton.titleLabel?.textAlignment = .center
//        picButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14.0)
//        picButton.setTitleColor(phaedraDarkGreen, for: UIControlState.normal)
//        picButton.backgroundColor = phaedraYellow
//        picButton.layer.borderColor = phaedraDarkGreen.cgColor
//      //  picButton.layer.borderWidth = 2
//        picButton.layer.cornerRadius = 60
//        picButton.translatesAutoresizingMaskIntoConstraints = false
//        picButton.topAnchor.constraint(equalTo: createAccountLabel.bottomAnchor, constant: 20).isActive = true
//        picButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
//        picButton.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
//        picButton.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
//      
//        view.addSubview(picImage)
//        picImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectProfileImage)))
//       // picImage.backgroundColor = UIColor.red
//        picImage.layer.borderWidth = 0
//        picImage.layer.cornerRadius = 60
//        picImage.translatesAutoresizingMaskIntoConstraints = false
//        //       picButton.setBackgroundImage(compressedJPGImage, forState: UIControlState.normal)
//        picImage.topAnchor.constraint(equalTo: createAccountLabel.bottomAnchor, constant: 20).isActive = true
//        picImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
//        picImage.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
//        picImage.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
//        
        // First Name Textfield
        view.addSubview(firstNameEntry)
        firstNameEntry.placeholder = "First Name"

        firstNameEntry.backgroundColor = UIColor.white
        firstNameEntry.textAlignment = .center
        firstNameEntry.layer.borderWidth = 2
        firstNameEntry.layer.cornerRadius = 5
        firstNameEntry.font = UIFont(name: "OpenSans-Light", size: 14.0)
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
        lastNameEntry.font = UIFont(name: "OpenSans-Light", size: 14.0)
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
        emailEntry.font = UIFont(name: "OpenSans-Light", size: 14.0)
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
        passwordEntry.font = UIFont(name: "OpenSans-Light", size: 14.0)
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
        passwordVerification.font = UIFont(name: "OpenSans-Light", size: 14.0)
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
        industryEntry.font = UIFont(name: "OpenSans-Light", size: 14.0)
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
        jobEntry.font = UIFont(name: "OpenSans-Light", size: 14.0)
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
        createAccountButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 15.0)
        createAccountButton.setTitleColor(phaedraDarkGreen, for: UIControlState.normal)
        createAccountButton.backgroundColor = phaedraYellow
        createAccountButton.layer.borderColor = phaedraDarkGreen.cgColor
        createAccountButton.layer.borderWidth = 2
        createAccountButton.layer.cornerRadius = 6
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        createAccountButton.topAnchor.constraint(equalTo: jobEntry.bottomAnchor, constant: 40).isActive = true
        createAccountButton.specialConstrain(to: view)

    }

    

    
    
    func sendEmail() {

        FirebaseManager.sendEmailVerification()


    }

//    func picButtonTapped(){
////        let pic = PicPickerViewController()
////        self.present(pic, animated: true, completion: nil)
//        
//        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//        let buttonOne = UIAlertAction(title: "Use Existing", style: .default, handler: { (action) -> Void in
//            self.selectPicture()
//        })
////        let buttonTwo = UIAlertAction(title: "Take New", style: .default, handler: { (action) -> Void in
////            self.takePicture()
////        })
//        let buttonCancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
//            print("Cancel Button Pressed")
//        }
//
//        alertController.addAction(buttonOne)
////        alertController.addAction(buttonTwo)
//        alertController.addAction(buttonCancel)
//        present(alertController, animated: true, completion: nil)
//
//
//
//    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
//    func selectPicture() {
//        print("selected piccccc")
//        let picker = UIImagePickerController()
//        picker.allowsEditing = true
//        picker.delegate = self
//        present(picker, animated: true)
//    }

//    func takePicture() {
//        let picker = UIImagePickerController()
//        picker.allowsEditing = true
//        picker.sourceType = .camera
//        picker.delegate = self
//        present(picker, animated: true)
//        if let image = UIImage(named: "example.png") {
//            if let data = UIImageJPEGRepresentation(image, 0.8) {
//                let filename = getDocumentsDirectory().appendingPathComponent("copy.png")
//                print("saved")
//                try? data.write(to: filename)
//            }
//        }
//    }

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
 
        if firstName != "" && lastName != "" && email != "" && password != "" && passwordVerify != "" && industry != "" && job != "" {
            //       self.ref.child("users").child(user.uid).setValue(["username": firstName])
        }

        //1 - create an instance of a user


        let currentUser = User(firstName: firstName, lastName: lastName, emailAddress: email, passWord: password, industry: industry, jobTitle: job )


        //2 - called on FirebaseManger to create a user based on the above currentUser
        FirebaseManager.createNewUser(currentUser: currentUser, completion: { success,user in

            if success {  
                
                //print("Current User \(FirebaseManager.currentUser!)")
                //guard let userid = FirebaseManager.currentUser else { return }
                //ERICA - we kept the below line when merging
                currentUser.userID = (FIRAuth.auth()?.currentUser?.uid)!

                self.store.currentUser = user
        

                //SEND USER TO ONBOARDING VIEWCONTROLLER
//                let onboardingVC = OnboardingViewController()
//                self.navigationController?.modalPresentationStyle
//                self.navigationController?.pushViewController(onboardingVC, animated: true)
                
//                let preferencesVC = PreferenceViewController()
//                self.navigationController?.pushViewController(preferencesVC, animated: true)
                
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

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
        print("Really, dismiss!")
        //AccountCreationViewController()
    }

//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//
//        var newImage: UIImage
//        var sourceType: UIImagePickerControllerSourceType
//
//        if let possibleImage = info[UIImagePickerControllerEditedImage] as? UIImage {
//            newImage = possibleImage
//        } else if let possibleImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            newImage = possibleImage
//        } else {
//            return
//        }
//
//        // do something interesting here!
//        print(newImage.size)
//        guard let imageData = UIImageJPEGRepresentation(newImage, 0.6) else { return }
//        guard let compressedJPGImage = UIImage(data: imageData) else { return }
        //send to firebase

        //        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
        //            newImage = image
        //        } else {
        //            print("Something went wrong")
        //        }
        //
//        print("view should dismiss")
//        super.dismiss(animated: true, completion: nil)
}

