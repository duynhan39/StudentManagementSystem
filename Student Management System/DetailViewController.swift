//
//  DetailViewController.swift
//  Student Management System
//
//  Created by Nhan Cao on 10/2/19.
//  Copyright © 2019 Nhan Cao. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

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
        // Do any additional setup after loading the view.
        configureView()
    }
    
    func configureView() {
        // Update the user interface for the detail item.

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItem.Style.plain, target: self, action: #selector(switchEditMode(_:)))
        navigationItem.title = "Info"
        
        objectInfoView.viewMode = .view
        objectInfoView.objectType = self.objectType
        passData()
    }
    
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


}

