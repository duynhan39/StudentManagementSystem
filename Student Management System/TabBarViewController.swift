//
//  TabBarViewController.swift
//  Student Management System
//
//  Created by Nhan Cao on 10/13/19.
//  Copyright © 2019 Nhan Cao. All rights reserved.
//

import UIKit
//import CoreData

class TabBarViewController: UITabBarController {
    
    
    var studentTab = MasterViewController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
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
