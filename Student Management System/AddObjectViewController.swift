//
//  CreateNewObjectViewController.swift
//  Student Management System
//
//  Created by Nhan Cao on 10/12/19.
//  Copyright © 2019 Nhan Cao. All rights reserved.
//

import UIKit

class AddObjectViewController: UIViewController {
    
    @IBOutlet weak var infoQueryView: NewObjectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveInfo(_ sender: Any) {
        createNewObject()
        goBackToPreviousView()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        goBackToPreviousView()
    }
    
    
    // MARK: Helper Function
    private func createNewObject() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let newStudent = Student(context: context)
        let inputtedData = infoQueryView.getInputedData()
        
        
        for key in inputtedData.keys {
            newStudent[key] = inputtedData[key]
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
    
    private func goBackToPreviousView() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//
//
//    }
     
    
}


extension Student {
    subscript(key:String) -> Any? {
        get {return nil}
        set(newValue) {
            switch key {
            case "firstName":
                self.firstName = newValue as? String
            case "lastName":
                self.lastName = newValue as? String
            case "email":
                self.email = newValue as? String
            case "id":
                self.id = newValue as? String
            case "phone":
                self.phone = newValue as? String
            case "campusAddress":
                self.campusAddress = newValue as? String
            case "photo":
                self.photo = newValue as? Data
            default:
                print("Attribute does not exits")
                return
            }
        }
    }
    
    override public var description: String {
        return "\(self.firstName ?? "") \(self.lastName ?? "")"
    }
}





