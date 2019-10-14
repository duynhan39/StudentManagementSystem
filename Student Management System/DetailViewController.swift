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

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    var mode = DataModel.ObjectType.student

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
//                var text:String
//                var Type : Any
//                Type = Student.self
//                text = (detailItem as? Type).description ?? ""
//                switch mode {
//                case .student:
//                    text =
//
//                case .professor:
//                    <#code#>
//                case .course:
//                    <#code#>
//                }
//                label.text = text
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }

    var detailItem: NSManagedObject? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

