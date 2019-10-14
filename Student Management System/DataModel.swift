//
//  DataModel.swift
//  Student Management System
//
//  Created by Nhan Cao on 10/12/19.
//  Copyright © 2019 Nhan Cao. All rights reserved.
//

import Foundation

class DataModel {
    
    enum ObjectType: String, CustomStringConvertible {
        var description: String {
            return self.rawValue
        }
        case student = "Student"
        case professor = "Professor"
        case course = "Course"
        
        static var all = [DataModel.ObjectType.student, .professor, .course]
    }
}

//extension NSMutableAttributedString {
//    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
//        let fontName = "HelveticaNeue-Bold"
//        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont(name: fontName, size: 17)!]
//        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
//        append(boldString)
//
//        return self
//    }
//
//    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
//        let normal = NSAttributedString(string: text)
//        append(normal)
//
//        return self
//    }
//}

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

extension Professor {
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
            case "officeAddress":
                self.officeAddress = newValue as? String
            case "homeAddress":
                self.homeAddress = newValue as? String
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

extension Course {
    subscript(key:String) -> Any? {
        get {return nil}
        set(newValue) {
            switch key {
            case "departmentCode":
                self.departmentCode = newValue as? String
//            case "lastName":
//                self.lastName = newValue as? String
//            case "email":
//                self.email = newValue as? String
//            case "id":
//                self.id = newValue as? String
//            case "phone":
//                self.phone = newValue as? String
//            case "campusAddress":
//                self.campusAddress = newValue as? String
//            case "photo":
//                self.photo = newValue as? Data
            default:
                print("Attribute does not exits")
                return
            }
        }
    }
    
    override public var description: String {
        return "\(self.departmentCode ?? "")\(self.number ?? "") - \(self.name ?? "")"
    }
}


