//
//  PicPickerViewController.swift
//  FlatironMasterpiece
//
//  Created by Nick Rigano on 12/6/16.
//  Copyright © 2016 Elias Miller. All rights reserved.
//


//var imageData = UIImageJPEGRepresentation(imagePicked.image, 0.6)
//var compressedJPGImage = UIImage(data: imageData)
//UIImageWriteToSavedPhotosAlbum(compressedJPGImage, nil, nil, nil)


//vdl - 


import Foundation
import UIKit


class PicPickerViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view is running")
        self.view.backgroundColor = UIColor.green
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Pic picker should appear")
  //      present(alertController, animated: true, completion: nil)
        selectPicture()
    }
    
    // this should create the alert that allows you to choose how you want to get your picture
    
//    let picAlertController = UIAlertController(title: "Add Account Picture", message: "Use Existing", preferredStyle: .alert)

    
    
    
    
//    let alertController = UIAlertController(title: "UIAlertController", message: "UIAlertController with multiple buttons", preferredStyle: .alert)
//    let buttonOne = UIAlertAction(title: "One", style: .Default, handler: { (action) -> Void in
//        println("Button One Pressed")
//    })
//    let buttonTwo = UIAlertAction(title: "Two", style: .Default, handler: { (action) -> Void in
//        println("Button Two Pressed")
//    })
//       let buttonCancel = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in
//        print("Cancel Button Pressed")
//    }
//    
//    alertController.addAction(buttonOne)
//    alertController.addAction(buttonTwo)
//    alertController.addAction(buttonCancel)
//    
//    presentViewController(alertController, animated: true, completion: nil)
//    
//    
    
    
    
    // Below this allows you to select a picture form the list or take a new picture
    
    func selectPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func takePicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var newImage: UIImage
        var sourceType: UIImagePickerControllerSourceType
        
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        
        // do something interesting here!
        print(newImage.size)
        guard let imageData = UIImageJPEGRepresentation(newImage, 0.6) else { return }
        guard let compressedJPGImage = UIImage(data: imageData) else { return }
       //send to firebase
        
        dismiss(animated: true)
    }
    
    
    
    
    
}
