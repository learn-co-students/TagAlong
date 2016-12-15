//
//  SelectPhotoViewController.swift
//  FlatironMasterpiece
//
//  Created by Joyce Matos on 12/13/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit

class SelectPhotoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var welcomeLabel = UILabel()
    var picButton = UIButton()
    var picImage = UIImageView()
    var userChoseImage:Bool = false
    var savePreferencesButton = UIButton(frame: CGRect(x: 100, y: 200, width: 100, height: 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = phaedraBeige
        addPhotoViews()
        print("viewDidLoad() - userChoseImage: \(userChoseImage)")
     }

    func addPhotoViews() {
        
        view.addSubview(welcomeLabel)
        welcomeLabel.text = "Choose your picture!"
        welcomeLabel.textColor = phaedraOrange
        welcomeLabel.textAlignment = .center
//        welcomeLabel.layer.borderWidth = 2
//        welcomeLabel.layer.cornerRadius = 5
        welcomeLabel.font = UIFont(name: "OpenSans-Bold", size: 16.0)
//        welcomeLabel.layer.borderColor = phaedraDarkGreen.cgColor
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        
        
        view.addSubview(picButton)
        picButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectProfileImage)))
        picButton.isUserInteractionEnabled = true
        picButton.titleLabel?.numberOfLines = 2
        picButton.setTitle("Add\nPic", for: UIControlState.normal)
        picButton.titleLabel?.textAlignment = .center
        picButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14.0)
        picButton.setTitleColor(phaedraDarkGreen, for: UIControlState.normal)
        picButton.backgroundColor = phaedraLightGreen
        picButton.layer.borderColor = phaedraDarkGreen.cgColor
        //  picButton.layer.borderWidth = 2
        picButton.layer.cornerRadius = 0
        picButton.translatesAutoresizingMaskIntoConstraints = false
        picButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        picButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        picButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        picButton.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        view.addSubview(picImage)
        picImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectProfileImage)))
//         picImage.backgroundColor = UIColor.red.withAlphaComponent(0.2)
        picImage.layer.borderWidth = 0
        picImage.layer.cornerRadius = 0
        picImage.translatesAutoresizingMaskIntoConstraints = false
        //       picButton.setBackgroundImage(compressedJPGImage, forState: UIControlState.normal)
        picImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        
        picImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        picImage.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        picImage.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
        
        view.addSubview(savePreferencesButton)
        savePreferencesButton.backgroundColor = phaedraLightGreen
        savePreferencesButton.layer.cornerRadius = 5
        savePreferencesButton.layer.borderColor = phaedraDarkGreen.cgColor
        savePreferencesButton.layer.borderWidth = 2
        savePreferencesButton.setTitle("Set Profile Pic", for: .normal)
        savePreferencesButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14.0)
        savePreferencesButton.titleLabel?.textAlignment = .center
        savePreferencesButton.translatesAutoresizingMaskIntoConstraints = false
//        savePreferencesButton.topAnchor.constraint(greaterThanOrEqualTo: picImage.bottomAnchor, constant: 250).isActive = true
        savePreferencesButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120).isActive = true
        savePreferencesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        savePreferencesButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45).isActive = true
        savePreferencesButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08).isActive = true
        savePreferencesButton.addTarget(self, action: #selector(goToPreferencesButtonTapped), for: .touchUpInside)
        savePreferencesButton.setTitleColor(phaedraDarkGreen, for: .normal)
        savePreferencesButton.setTitleColor(phaedraOrange, for: .highlighted)
    }
    
    func goToPreferencesButtonTapped() {
        print("save preferences tapped")
        if userChoseImage {
            let preferencesVC = PreferenceViewController()
            self.navigationController?.pushViewController(preferencesVC, animated: true)
        } else {
            //noPhotoChosen alert is called
            let noPhotoAlert = UIAlertController(title: "Missing Profile Photo", message: "Please upload a profile photo.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                print("User closed alert controller")
            })
            noPhotoAlert.addAction(okAction)
            self.present(noPhotoAlert, animated: true, completion: nil)
        }
    }
    
    //Sets up pic button with relevant sizes text
    func createPicButton() {
        
    }
    //Constrains pic button to self.view
    func constrainPicButton() {
        
    }
    
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
                
               
                
                
               
                picImage.image = selectedImage
                userChoseImage = true
                print("imagePickerController() - userChoseImage: \(userChoseImage)")
                //       FirebaseManager.ref.child("users").child(FirebaseManager.currentUser).child("profilePic").setValue(["\()" : true])
                super.dismiss(animated: true, completion: {
                    FirebaseManager.sendToStorage(data: imageData, handler: { success in
                        
                        print("view should dismiss")
                        
                        
                        
                    })
                })
            }
    }
}

