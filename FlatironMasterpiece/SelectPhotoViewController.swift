//
//  SelectPhotoViewController.swift
//  FlatironMasterpiece
//
//  Created by Joyce Matos on 12/13/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit

class SelectPhotoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
//    var createAccountLabel = UILabel()
//    var firstNameEntry = UITextField()
//    var lastNameEntry = UITextField()
//    var emailEntry = UITextField()
//    var passwordEntry = UITextField()
//    var passwordVerification = UITextField()
//    var industryEntry = UITextField()
//    var jobEntry = UITextField()
//    var createAccountButton = UIButton()
    
    
    
    
    
    var picButton = UIButton()
    var picImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPhotoViews()
//        createViews()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func addPhotoViews() {
        
        
        
        
        view.addSubview(picButton)
        
        
        
        
        picButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectProfileImage)))
        
        
        picButton.isUserInteractionEnabled = true
        picButton.titleLabel?.numberOfLines = 2
        picButton.setTitle("Add\nPic", for: UIControlState.normal)
        picButton.titleLabel?.textAlignment = .center
        picButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14.0)
        picButton.setTitleColor(phaedraDarkGreen, for: UIControlState.normal)
        picButton.backgroundColor = phaedraYellow
        picButton.layer.borderColor = phaedraDarkGreen.cgColor
        //  picButton.layer.borderWidth = 2
        picButton.layer.cornerRadius = 60
        picButton.translatesAutoresizingMaskIntoConstraints = false
        picButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        picButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        picButton.widthAnchor.constraint(equalToConstant: self.view.bounds.width * 0.2).isActive = true
        picButton.heightAnchor.constraint(equalToConstant: self.view.bounds.height * 0.08).isActive = true
        
        
        view.addSubview(picImage)
        
        
        picImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectProfileImage)))
        
        // picImage.backgroundColor = UIColor.red
        picImage.layer.borderWidth = 0
        picImage.layer.cornerRadius = 60
        picImage.translatesAutoresizingMaskIntoConstraints = false
        //       picButton.setBackgroundImage(compressedJPGImage, forState: UIControlState.normal)
        
        picImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        picImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        picImage.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        picImage.heightAnchor.constraint(equalToConstant: 120.0).isActive = true

    }
    
    //Sets up pic button with relevant sizes text
    func createPicButton() {
        
    }
    //Constrains pic button to self.view
    func constrainPicButton() {
        
    }
    
//    func createViews() {
//        
//        // Create Account Label
//        view.addSubview(createAccountLabel)
//        createAccountLabel.text = "Create Account"
//        createAccountLabel.font = UIFont(name: "OpenSans-Bold", size: 20.0)
//        createAccountLabel.textColor = UIColor.white
//        createAccountLabel.textAlignment = .center
//        createAccountLabel.translatesAutoresizingMaskIntoConstraints = false
//        createAccountLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -250).isActive = true
//        createAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
//        createAccountLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
//        createAccountLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
    
        
        //        view.addSubview(picButton)
        //
        //
        //
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
        //
        //
        //
        //
        //        view.addSubview(picImage)
        //
        //
        //        picImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectProfileImage)))
        //
        //       // picImage.backgroundColor = UIColor.red
        //        picImage.layer.borderWidth = 0
        //        picImage.layer.cornerRadius = 60
        //        picImage.translatesAutoresizingMaskIntoConstraints = false
        //        //       picButton.setBackgroundImage(compressedJPGImage, forState: UIControlState.normal)
        //
        //        picImage.topAnchor.constraint(equalTo: createAccountLabel.bottomAnchor, constant: 20).isActive = true
        //        picImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        //        picImage.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        //        picImage.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
        
        // First Name Textfield
//        view.addSubview(firstNameEntry)
//        firstNameEntry.placeholder = "First Name"
//        
//        firstNameEntry.backgroundColor = UIColor.white
//        firstNameEntry.textAlignment = .center
//        firstNameEntry.layer.borderWidth = 2
//        firstNameEntry.layer.cornerRadius = 5
//        firstNameEntry.font = UIFont(name: "OpenSans-Light", size: 14.0)
//        firstNameEntry.layer.borderColor = phaedraDarkGreen.cgColor
//        firstNameEntry.translatesAutoresizingMaskIntoConstraints = false
//        firstNameEntry.topAnchor.constraint(equalTo: picButton.bottomAnchor, constant: 20).isActive = true
//        firstNameEntry.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
//        firstNameEntry.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
//        firstNameEntry.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
//        
//        // Last Name Textfield
//        view.addSubview(lastNameEntry)
//        lastNameEntry.placeholder = "Last Name"
//        lastNameEntry.textAlignment = .center
//        lastNameEntry.layer.borderWidth = 2
//        lastNameEntry.layer.cornerRadius = 5
//        lastNameEntry.layer.borderColor = phaedraDarkGreen.cgColor
//        lastNameEntry.font = UIFont(name: "OpenSans-Light", size: 14.0)
//        lastNameEntry.backgroundColor = UIColor.white
//        
//        lastNameEntry.translatesAutoresizingMaskIntoConstraints = false
//        lastNameEntry.topAnchor.constraint(equalTo: firstNameEntry.bottomAnchor, constant: 10).isActive = true
//        lastNameEntry.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
//        lastNameEntry.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
//        lastNameEntry.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
//        
//        // Email Address Texfield
//        view.addSubview(emailEntry)
//        emailEntry.placeholder = "Email Address"
//        emailEntry.layer.borderWidth = 2
//        emailEntry.layer.cornerRadius = 5
//        emailEntry.layer.borderColor = phaedraDarkGreen.cgColor
//        emailEntry.font = UIFont(name: "OpenSans-Light", size: 14.0)
//        emailEntry.textAlignment = .center
//        emailEntry.backgroundColor = UIColor.white
//        emailEntry.translatesAutoresizingMaskIntoConstraints = false
//        emailEntry.topAnchor.constraint(equalTo: lastNameEntry.bottomAnchor, constant: 10).isActive = true
//        emailEntry.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
//        emailEntry.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
//        emailEntry.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
//        
//        // Password Textfield
//        view.addSubview(passwordEntry)
//        passwordEntry.placeholder = "Password"
//        passwordEntry.layer.borderWidth = 2
//        passwordEntry.layer.cornerRadius = 5
//        passwordEntry.layer.borderColor = phaedraDarkGreen.cgColor
//        passwordEntry.font = UIFont(name: "OpenSans-Light", size: 14.0)
//        passwordEntry.textAlignment = .center
//        passwordEntry.backgroundColor = UIColor.white
//        
//        passwordEntry.translatesAutoresizingMaskIntoConstraints = false
//        passwordEntry.topAnchor.constraint(equalTo: emailEntry.bottomAnchor, constant: 10).isActive = true
//        passwordEntry.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
//        passwordEntry.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
//        passwordEntry.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
//        
//        // Password Verification Textfield
//        view.addSubview(passwordVerification)
//        passwordVerification.placeholder = "Verify Password"
//        passwordVerification.layer.borderWidth = 2
//        passwordVerification.layer.cornerRadius = 5
//        passwordVerification.layer.borderColor = phaedraDarkGreen.cgColor
//        passwordVerification.font = UIFont(name: "OpenSans-Light", size: 14.0)
//        passwordVerification.textAlignment = .center
//        
//        passwordVerification.backgroundColor = UIColor.white
//        passwordVerification.translatesAutoresizingMaskIntoConstraints = false
//        passwordVerification.topAnchor.constraint(equalTo: passwordEntry.bottomAnchor, constant: 10).isActive = true
//        passwordVerification.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
//        passwordVerification.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
//        passwordVerification.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
//        
//        // Industry Textfield
//        view.addSubview(industryEntry)
//        industryEntry.placeholder = "Industry"
//        industryEntry.layer.borderWidth = 2
//        industryEntry.layer.cornerRadius = 5
//        industryEntry.layer.borderColor = phaedraDarkGreen.cgColor
//        industryEntry.font = UIFont(name: "OpenSans-Light", size: 14.0)
//        industryEntry.textAlignment = .center
//        industryEntry.backgroundColor = UIColor.white
//        industryEntry.translatesAutoresizingMaskIntoConstraints = false
//        industryEntry.topAnchor.constraint(equalTo: passwordVerification.bottomAnchor, constant: 10).isActive = true
//        industryEntry.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
//        industryEntry.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
//        industryEntry.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
//        
//        // Job Title Textfield
//        view.addSubview(jobEntry)
//        jobEntry.placeholder = "Job Title"
//        jobEntry.layer.borderWidth = 2
//        jobEntry.layer.cornerRadius = 5
//        jobEntry.layer.borderColor = phaedraDarkGreen.cgColor
//        jobEntry.font = UIFont(name: "OpenSans-Light", size: 14.0)
//        jobEntry.textAlignment = .center
//        jobEntry.backgroundColor = UIColor.white
//        jobEntry.translatesAutoresizingMaskIntoConstraints = false
//        jobEntry.topAnchor.constraint(equalTo: industryEntry.bottomAnchor, constant: 10).isActive = true
//        jobEntry.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
//        jobEntry.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66).isActive = true
//        jobEntry.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
//        
//        // Create Account Button
//        view.addSubview(createAccountButton)
////        createAccountButton.addTarget(self, action: #selector(createAccountButtonTapped(sender:)), for: .touchUpInside)
//        createAccountButton.setTitle("Create Account", for: UIControlState.normal)
//        createAccountButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 15.0)
//        createAccountButton.setTitleColor(phaedraDarkGreen, for: UIControlState.normal)
//        createAccountButton.backgroundColor = phaedraYellow
//        createAccountButton.layer.borderColor = phaedraDarkGreen.cgColor
//        createAccountButton.layer.borderWidth = 2
//        createAccountButton.layer.cornerRadius = 6
//        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
//        createAccountButton.topAnchor.constraint(equalTo: jobEntry.bottomAnchor, constant: 40).isActive = true
//        createAccountButton.specialConstrain(to: view)
//        
//    }


//}
}
extension SelectPhotoViewController {
    
    
        
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
                    
                    print("view should dismiss")
                    
                    super.dismiss(animated: true, completion: nil)
                    
                    
                })
                picImage.image = selectedImage
                
                //       FirebaseManager.ref.child("users").child(FirebaseManager.currentUser).child("profilePic").setValue(["\()" : true])
                
            }
    }
}

