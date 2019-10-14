//
//  TabBarViewController.swift
//  Student Management System
//
//  Created by Nhan Cao on 10/13/19.
//  Copyright © 2019 Nhan Cao. All rights reserved.
//

import UIKit
import CoreData

class TabBarViewController: UITabBarController {
    
    var managedObjectContext: NSManagedObjectContext? = nil {
        didSet {
            studentTab.managedObjectContext = managedObjectContext
        }
    }
    
    var studentTab = MasterViewController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.tabBarController?.viewControllers?.count)

        studentTab = self.tabBarController?.viewControllers?[0] as! MasterViewController
        
        studentTab.managedObjectContext = managedObjectContext
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
