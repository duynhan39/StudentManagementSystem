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
    
    var mode = DataModel.ObjectType.student
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoQueryView.objectType = self.mode
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
        
        let newObject = Student(context: context)
        let inputtedData = infoQueryView.getInputedData()
        
        for key in inputtedData.keys {
            newObject[key] = inputtedData[key]
        }
        
        newObject.descriptionID = newObject.description
        
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





