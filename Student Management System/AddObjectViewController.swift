//
//  CreateNewObjectViewController.swift
//  Student Management System
//
//  Created by Nhan Cao on 10/12/19.
//  Copyright © 2019 Nhan Cao. All rights reserved.
//

import UIKit
import CoreData

class AddObjectViewController: UIViewController {
    
    // MARK: Valiables
    @IBOutlet weak var infoQueryView: ObjectInfoView!
    
    var objectType = DataModel.ObjectType.student
    
    // MARK: Set up
    override func viewDidLoad() {
        super.viewDidLoad()
        infoQueryView.objectType = self.objectType
        
        self.isModalInPresentation = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    // MARK: Functional Features
    @IBAction func saveInfo(_ sender: Any) {
        switch objectType {
        case .student:
            createNewObject(model: Student())
        case .professor:
            createNewObject(model: Professor())
        case .course:
            createNewObject(model: Course())
        }
        
        goBackToPreviousView()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        goBackToPreviousView()
    }
    
    
    // MARK: Helper Function
    private func createNewObject<T: NSManagedObject>(model: T) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext

        let newObject = T(context: context)
        let inputtedData = infoQueryView.getInputedData()
        
        for key in inputtedData.keys {
            newObject.setValue(inputtedData[key], forKey: key)
//            newObject[key] = inputtedData[key]
        }
        
        newObject.setValue(newObject.description, forKey: "descriptionID")
        
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





