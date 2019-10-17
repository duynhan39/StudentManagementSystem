//
//  InfoViewController.swift
//  Student Management System
//
//  Created by Nhan Cao on 10/17/19.
//  Copyright © 2019 Nhan Cao. All rights reserved.
//

import UIKit
import CoreData

class InfoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

//    weak var objectInfoView: ObjectInfoView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func presentImagePicker() {
        print("Wut?!")
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        if  UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            pickerController.sourceType = .photoLibrary
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            pickerController.sourceType = .camera
        }
    
        self.present(pickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        
//        objectInfoView.profileImageView.image = image
//        objectInfoView.didSetImage = true
        updateProfile(with: image)
        
    }
    
    func updateProfile(with image: UIImage) {}


}
