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
        takePicture()
    }
    
    
    
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
        
        dismiss(animated: true)
    }
    
    
    
    
    
}
