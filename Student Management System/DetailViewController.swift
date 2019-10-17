//
//  DetailViewController.swift
//  Student Management System
//
//  Created by Nhan Cao on 10/2/19.
//  Copyright © 2019 Nhan Cao. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: InfoViewController {

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
            
            saveObjectData()
            
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
    
    private func saveObjectData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        
        let inputtedData = objectInfoView.getInputedData()
        for key in inputtedData.keys {
            object?.setValue(inputtedData[key], forKey: key)
        }
        
        
        // Save the context.
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    override func updateProfile(with image: UIImage) {
        objectInfoView.profileImageView.image = image
        objectInfoView.didSetImage = true
    }

}

