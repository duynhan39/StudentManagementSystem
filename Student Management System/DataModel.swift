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
    }
    
    static let Attributes = [
        "student" : ["First name", "Last name", "Email", "ID", "Phone number", "Campus address"],
        "professor" : ["First name", "Last name", "Email", "Home address", "Office address"]
    ]
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


