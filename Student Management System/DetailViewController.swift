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
    
    var object : NSManagedObject? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        objectInfoView.viewMode = .view
        objectInfoView.objectType = self.objectType
        
        
    }
    
//    private func extractData() -> [String:Any] {
//        
//    }


}

