//
//  CreateNewObjectViewController.swift
//  Student Management System
//
//  Created by Nhan Cao on 10/12/19.
//  Copyright © 2019 Nhan Cao. All rights reserved.
//

import UIKit
import CoreData

class AddObjectViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // MARK: Valiables
    @IBOutlet weak var infoQueryView: ObjectInfoView!
    
    var objectType = DataModel.ObjectType.student
    
    // MARK: Set up
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        infoQueryView.objectType = self.objectType
        
        self.isModalInPresentation = true
        
        infoQueryView.parent = self
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
    
    override func presentImagePicker() {
        print("Wut?!")
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        if  UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            pickerController.sourceType = .photoLibrary
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            pickerController.sourceType = .camera
        }
    
        self.present(pickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        
        infoQueryView.profileImageView.image = image
        infoQueryView.didSetImage = true
        
    }

    private func createNewObject<T: NSManagedObject>(model: T) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext

        let newObject = T(context: context)
        let inputtedData = infoQueryView.getInputedData()
        for key in inputtedData.keys {
            print(key)
            newObject.setValue(inputtedData[key], forKey: key)
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





