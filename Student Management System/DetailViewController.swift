//
//  DetailViewController.swift
//  Student Management System
//
//  Created by Nhan Cao on 10/2/19.
//  Copyright © 2019 Nhan Cao. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var objectInfoView: ObjectInfoView!
    
    var objectType = DataModel.ObjectType.student {
        didSet {
            if objectInfoView != nil {
                objectInfoView.objectType = self.objectType
            }
        }
    }
    
    var object : NSManagedObject? = nil {
        didSet {
            passData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        // Do any additional setup after loading the view.
        configureView()
    }
    
    func configureView() {
        // Update the user interface for the detail item.

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItem.Style.plain, target: self, action: #selector(switchEditMode(_:)))
        navigationItem.title = "Info"
        
        objectInfoView.viewMode = .view
        objectInfoView.objectType = self.objectType
        objectInfoView.parent = self
        passData()
    }
    
    // MARK: Functional Feature
    @objc private func switchEditMode(_ sender: Any) {
        var buttonTitle : String
        
        if navigationItem.rightBarButtonItem?.title == "Edit" {
            // Just hit [Edit]
            objectInfoView.viewMode = .edit
            buttonTitle = "Done"
        } else {
            // Just hit [Done]
            
            let inputtedData = objectInfoView.getInputedData()
            for key in inputtedData.keys {
                object?.setValue(inputtedData[key], forKey: key)
            }
            objectInfoView.viewMode = .view
            buttonTitle = "Edit"
            
        }
        navigationItem.rightBarButtonItem?.title = buttonTitle
    }
    
    private func passData() {
        var data = [String:Any]()
        let attributesByName = object?.entity.attributesByName ?? [String:Any]()
        
        for (key, _) in attributesByName {
            data[key] = object?.value(forKey: key)
        }

        if objectInfoView != nil {
            objectInfoView.objectData = data
        }
    }
    
    override func presentImagePicker() {
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

        objectInfoView.profileImageView.image = image
        objectInfoView.didSetImage = true
    }


}

