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
    
    var imagePickerSourceType = UIImagePickerController.SourceType.camera
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showImagePickerOptions() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.imagePickerSourceType = .camera
            self.presentImagePicker()
        }))
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.imagePickerSourceType = .photoLibrary
            self.presentImagePicker()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func presentImagePicker() {
        print("Wut?!")
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        
        if imagePickerSourceType == .camera && UIImagePickerController.isSourceTypeAvailable(.camera) {
            pickerController.sourceType = .camera
        } else if  UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            pickerController.sourceType = .photoLibrary
        }
    
        self.present(pickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        updateProfile(with: image)
    }
    
    func updateProfile(with image: UIImage) {}


}
