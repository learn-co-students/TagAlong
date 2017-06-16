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
    var instructionLabel = UILabel()
    var picButton = UIButton()
    var picImage = UIImageView()
    var userChoseImage:Bool = false
    var setPhoto = UIButton(frame: CGRect(x: 100, y: 200, width: 200, height: 25))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = phaedraBeige
        addPhotoViews()
        print("viewDidLoad() - userChoseImage: \(userChoseImage)")
     }
    
    // MARK: - View Methods

    func addPhotoViews() {
        
        view.addSubview(welcomeLabel)
        welcomeLabel.text = "Select a photo"
        welcomeLabel.textColor = phaedraOrange
        welcomeLabel.textAlignment = .center
        welcomeLabel.font = UIFont(name: "OpenSans-Bold", size: 20.0)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        view.addSubview(instructionLabel)
        instructionLabel.text = "To continue you must upload a photo. Tap on 'Add Photo' to select a photo"
        instructionLabel.textColor = phaedraOrange
        instructionLabel.textAlignment = .center
        instructionLabel.font = UIFont(name: "OpenSans-Regular", size: 16.0)
        instructionLabel.lineBreakMode = .byTruncatingTail
        instructionLabel.numberOfLines = 0
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 30).isActive = true
        instructionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        instructionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true

        view.addSubview(picButton)
        picButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectProfileImage)))
        picButton.isUserInteractionEnabled = true
        picButton.titleLabel?.numberOfLines = 2
        picButton.setTitle("Add Photo", for: UIControlState.normal)
        picButton.titleLabel?.textAlignment = .center
        picButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14.0)
        picButton.setTitleColor(phaedraDarkGreen, for: UIControlState.normal)
        picButton.backgroundColor = phaedraLightGreen
        picButton.layer.borderColor = phaedraDarkGreen.cgColor
        picButton.layer.cornerRadius = 0
        picButton.translatesAutoresizingMaskIntoConstraints = false
        picButton.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 70).isActive = true
        picButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        picButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        picButton.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        view.addSubview(picImage)
        picImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectProfileImage)))
        picImage.layer.borderWidth = 0
        picImage.layer.cornerRadius = 0
        picImage.translatesAutoresizingMaskIntoConstraints = false
        picImage.topAnchor.constraint(equalTo: picButton.topAnchor, constant: 0).isActive = true
        picImage.centerXAnchor.constraint(equalTo: picButton.centerXAnchor, constant: 0).isActive = true
        picImage.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        picImage.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
        
        view.addSubview(setPhoto)
        setPhoto.backgroundColor = phaedraOrange
        setPhoto.layer.cornerRadius = 5
        setPhoto.setTitle("Set Profile Photo", for: .normal)
        setPhoto.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14.0)
        setPhoto.titleLabel?.textAlignment = .center
        setPhoto.translatesAutoresizingMaskIntoConstraints = false
        setPhoto.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120).isActive = true
        setPhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        setPhoto.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45).isActive = true
        setPhoto.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08).isActive = true
        setPhoto.addTarget(self, action: #selector(goToPreferencesButtonTapped), for: .touchUpInside)

    }
    
    func goToPreferencesButtonTapped() {
        if userChoseImage {
            let preferencesVC = PreferenceViewController()
            self.show(preferencesVC, sender: nil)
            
        } else {

            let noPhotoAlert = UIAlertController(title: "Missing Profile Photo", message: "Please upload a profile photo.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                print("User closed alert controller")
            })
            noPhotoAlert.addAction(okAction)
            self.present(noPhotoAlert, animated: true, completion: nil)
        }
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

