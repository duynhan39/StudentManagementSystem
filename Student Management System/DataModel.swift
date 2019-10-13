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
}
