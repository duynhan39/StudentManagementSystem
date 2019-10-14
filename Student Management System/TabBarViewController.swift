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
    
    var mode : DataModel.ObjectType {
        get {
            return (self.selectedViewController as? MasterViewController)?.mode ?? .student
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let editButton = editButtonItem
        editButton.action = #selector(switchEditMode(_:))
        editButton.target = self
        
        navigationItem.leftBarButtonItem = editButton
 
        
        let studentItem = self.tabBar.items?[0]
        studentItem?.title = "Students"
        studentItem?.image = UIImage(systemName: "person.fill")
        
        let profItem = self.tabBar.items?[1]
        profItem?.title = "Professors"
        profItem?.image = UIImage(systemName: "person.crop.square")
        
        let courseItem = self.tabBar.items?[2]
        courseItem?.title = "Courses"
        courseItem?.image = UIImage(systemName: "book")
    }
    
    @IBAction func insertNewRow(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AddNewObjectViewController") as! AddObjectViewController
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @objc
    private func switchEditMode(_ sender: Any) {
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
