//
//  SelectPhotoViewController.swift
//  FlatironMasterpiece
//
//  Created by Joyce Matos on 12/13/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//

import UIKit

class SelectPhotoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var picButton = UIButton()
    var picImage = UIImageView()
    var userChoseImage:Bool = false
    var goToPreferencesButton = UIButton(frame: CGRect(x: 100, y: 200, width: 100, height: 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = phaedraBeige
        addPhotoViews()
        print("viewDidLoad() - userChoseImage: \(userChoseImage)")
//        createViews()

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
        picButton.backgroundColor = phaedraLightGreen
        picButton.layer.borderColor = phaedraDarkGreen.cgColor
        //  picButton.layer.borderWidth = 2
        picButton.layer.cornerRadius = 60
        picButton.translatesAutoresizingMaskIntoConstraints = false
        picButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 125).isActive = true
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
        
        view.addSubview(goToPreferencesButton)
        goToPreferencesButton.backgroundColor = phaedraLightGreen
        goToPreferencesButton.layer.cornerRadius = 5
        goToPreferencesButton.layer.borderColor = phaedraDarkGreen.cgColor
        goToPreferencesButton.layer.borderWidth = 2
        goToPreferencesButton.setTitle("Save Preferences", for: .normal)
        goToPreferencesButton.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 14.0)
        goToPreferencesButton.titleLabel?.textAlignment = .center
        goToPreferencesButton.translatesAutoresizingMaskIntoConstraints = false
        goToPreferencesButton.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 435).isActive = true
        goToPreferencesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        goToPreferencesButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45).isActive = true
        goToPreferencesButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08).isActive = true
        goToPreferencesButton.addTarget(self, action: #selector(goToPreferencesButtonTapped), for: .touchUpInside)
        goToPreferencesButton.setTitleColor(phaedraDarkGreen, for: .normal)
        goToPreferencesButton.setTitleColor(phaedraOrange, for: .highlighted)
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
                FirebaseManager.sendToStorage(data: imageData, handler: { success in
                    
                    print("view should dismiss")
                    
                    super.dismiss(animated: true, completion: nil)
                    
                })
                picImage.image = selectedImage
                userChoseImage = true
                print("imagePickerController() - userChoseImage: \(userChoseImage)")
                //       FirebaseManager.ref.child("users").child(FirebaseManager.currentUser).child("profilePic").setValue(["\()" : true])
                
            }
    }
}

