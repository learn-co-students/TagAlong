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


//ADD: take picture button, choose picture button, view with picture


import Foundation
import UIKit


class PicPickerViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print("view is running")
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Pic picker should appear")
  //      present(alertController, animated: true, completion: nil)
        selectPicture()
    }
    
    // this should create the alert that allows you to choose how you want to get your picture
    
    
//
//    
    
    
    
    // Below this allows you to select a picture form the list or take a new picture
    //maybe stick this whole thing inside the viw controller it is to be dismissed to
    
    func selectPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
        imagePickerControllerDidCancel(picker)

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
        print("Really, dismiss!")
        //AccountCreationViewController()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var newImage: UIImage
        var sourceType: UIImagePickerControllerSourceType
        
        if let possibleImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        
        // do something interesting here!
        print(newImage.size)
        guard let imageData = UIImageJPEGRepresentation(newImage, 0.6) else { return }
        guard let compressedJPGImage = UIImage(data: imageData) else { return }
        //send to firebase

//        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            newImage = image
//        } else {
//            print("Something went wrong")
//        }
//        
        print("view should dismiss")
        super.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
}
