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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        passData()
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        objectInfoView.viewMode = .view
        objectInfoView.objectType = self.objectType
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

