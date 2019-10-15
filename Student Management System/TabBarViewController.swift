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
    
//    let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(switchEditMode(_:)))
    
    var mode : DataModel.ObjectType {
        return (self.selectedViewController as? MasterViewController)?.mode ?? .student
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpBarButtonItems()
        
        let tabBarTitles = ["Students", "Professor", "Courses"]
        let tabBarImages = ["person.fill", "person.crop.square", "book"]
        
        for i in 0..<3 {
            let barItem = self.tabBar.items?[i]
            barItem?.title = tabBarTitles[i]
            barItem?.image = UIImage(systemName: tabBarImages[i])
            (self.viewControllers?[i] as? MasterViewController)?.mode = DataModel.ObjectType.all[i]
            barItem?.badgeColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        }
    }
    
    private func setUpBarButtonItems() {
        let editButton = editButtonItem
        editButtonItem.action = #selector(switchEditMode(_:))
        editButtonItem.target = self
        navigationItem.leftBarButtonItem = editButton
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewRow(_:)))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func insertNewRow(_ sender: Any) {
        turnOffEditMode()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newAddObjectController = storyBoard.instantiateViewController(withIdentifier: "AddNewObjectViewController") as! AddObjectViewController
        newAddObjectController.mode = self.mode
        
        self.present(newAddObjectController, animated: true, completion: nil)
    }
    
    @objc private func switchEditMode(_ sender: Any) {
        var buttonTitle = "Edit"
        var setEditting = false
        if navigationItem.leftBarButtonItem?.title == "Edit" {
            buttonTitle = "Done"
            setEditting = true
        }
        
        navigationItem.leftBarButtonItem?.title = buttonTitle
        self.selectedViewController?.isEditing = setEditting
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        turnOffEditMode()
    }
    
    private func turnOffEditMode() {
        navigationItem.leftBarButtonItem?.title = "Edit"
        for view in self.viewControllers ?? [] {
            (view as? MasterViewController)?.isEditing = false
        }
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
