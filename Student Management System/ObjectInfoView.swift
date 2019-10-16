//
//  NewObjectView.swift
//  Student Management System
//
//  Created by Nhan Cao on 10/13/19.
//  Copyright © 2019 Nhan Cao. All rights reserved.
//

import UIKit
@IBDesignable

class ObjectInfoView: UIView, UITableViewDataSource {
    
    // MARK: - Variables
    private var attributeTable = UITableView()
    private var profileImageView = UIImageView()
    private var viewLabel = UILabel()
    
    var objectData = [String:Any]() {
        didSet {
            setNeedsLayout()
            setNeedsDisplay()
            attributeTable.reloadData()
        }
    }
    
    private var attributes : [String] {
        get {
            return DataModel.AttributeNames[self.objectType.rawValue] ?? []
        }
    }
    
    var objectType = DataModel.ObjectType.student {
        didSet {
            setNeedsLayout()
            setNeedsDisplay()
        }
    }
    
    var viewLabelText : String {
        get {
            var text = ""
            switch viewMode {
            case .add:
                text = "Create new \(self.objectType.description.lowercased())"
            case .edit, .view:
                text = "\(self.objectType)"
            }
            return text
        }
    }
    
    var viewMode = ObjectInfoView.ViewMode.add {
        didSet {
            setNeedsLayout()
            setNeedsDisplay()
        }
    }
    
    var isCellEditable : Bool {
        switch viewMode {
        case .view:
            return false
        case .add, .edit:
            return true
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        objectType = DataModel.ObjectType.student
        
        addSubview(profileImageView)
        addSubview(attributeTable)
        addSubview(viewLabel)
        
        attributeTable.dataSource = self
        attributeTable.register(InfoCell.self, forCellReuseIdentifier: "newInfoCell")
        attributeTable.bounces = false
        
        attributeTable.allowsSelection =  false
        viewLabel.textAlignment = .center
        
    }
    
    
    // MARK: - Draw
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsLayout()
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        clearsContextBeforeDrawing = true
        attributeTable.separatorStyle = .none
        
        let displayGap : CGFloat = 15
        var currentAvaiY : CGFloat = displayGap
        
        
        // MARK: Name label
        
        let labelFontSize : CGFloat = 20
        let labelFrame = CGRect(x: 0, y: currentAvaiY, width: self.frame.width, height: labelFontSize)
        viewLabel.frame = labelFrame
        viewLabel.font = UIFont.boldSystemFont(ofSize: labelFontSize)
        
        currentAvaiY = viewLabel.frame.maxY + displayGap
        
        viewLabel.text = viewLabelText
        
        // MARK: Profile picture
        
        if objectType != .course {
            let pictureEdge = min(self.frame.width/3, self.frame.height/5)
            let pictureFrame = CGRect(x: (self.frame.width - pictureEdge)*0.5,
                                      y: currentAvaiY,
                                      width: pictureEdge,
                                      height: pictureEdge)
            profileImageView.frame = pictureFrame
            profileImageView.layer.cornerRadius = pictureEdge*0.5
            
            profileImageView.image = UIImage(systemName: "person.circle.fill")
            profileImageView.tintColor = UIColor.black
            
            currentAvaiY = pictureFrame.maxY + displayGap
        }
        
        // MARK: Attribute table
        let tableHeight = self.frame.height - currentAvaiY
        //min(self.frame.height - tableY, attributeTable.contentSize.height*2)
        
        let tableFrame = CGRect(x: 0,
                                y: currentAvaiY + displayGap,
                                width: self.frame.width,
                                height: tableHeight)
        
        attributeTable.frame = tableFrame
        
        let indexPath = IndexPath(row: 0, section: 0)
        if attributeTable.numberOfRows(inSection: 0) > 0 {
            attributeTable.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attributes.count
    }
    
    // MARK: Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let attName : String = attributes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newInfoCell", for: indexPath) as! InfoCell
        
        cell.labelName = attName
        cell.viewMode = viewMode
        
//        for i in 0...10 {print()}
        print(viewMode)
        
        var textFieldContent : String
        switch viewMode {
        case .edit, .view:
            print(attName)
            print(objectData["firstName"])
            textFieldContent = (objectData[DataModel.AttributeDecodedValue[objectType.description]?[attName] ?? ""] as? String) ?? ""
            print(textFieldContent)
        default:
            textFieldContent = ""
        }
        cell.attributeInputTextField.text = textFieldContent
        cell.attributeInputTextField.isUserInteractionEnabled = isCellEditable
        
//        for i in 0...100 {print()}
        
        return cell
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: - Retrieve Data
    func getInputedData() -> [String:Any] {
        
        let attributeIds : [String:String] = DataModel.AttributeDecodedValue[self.objectType.rawValue] ?? ["":""]
        
        for i in 0..<attributes.count {
            let attName = attributes[i]
            let indexPath = IndexPath(row: i, section: 0)
            if let cell = attributeTable.cellForRow(at: indexPath) as? InfoCell {
                objectData[attributeIds[attName] ?? "None"] = cell.getInputtedContent()
            }
        }
        
        // Retrieve Image
        
        return objectData
    }
    
}

extension ObjectInfoView {
    enum ViewMode: Int {
        case add, edit, view
    }
}

// MARK: - Extension
extension DataModel {
    static let AttributeDecodedValue : [String : [String:String]] = [
        "Student" :     ["First name" : "firstName",
                         "Last name" : "lastName",
                         "Email" : "email",
                         "Student ID" : "id",
                         "Phone number" : "phone",
                         "Campus address" : "campusAddress"],
        
        "Professor" :   ["First name" :"firstName",
                         "Last name" : "lastName",
                         "Email" : "email",
                         "Home address" : "homeAddress",
                         "Office address" : "officeAddress"],
        
        "Course" :      ["Department Code" : "departmentCode",
                         "Course number" : "number",
                         "Course name" : "name",
                         "Meeting days" : "meetingDay",
                         "Time" : "time",
                         "Location" : "location"]
    ]
    
    static let AttributeNames = [
        "Student" : ["First name", "Last name", "Email", "Student ID", "Phone number", "Campus address"],
        
        "Professor" : ["First name", "Last name", "Email", "Home address", "Office address"],
        
        "Course" : ["Department Code", "Course number", "Course name", "Meeting days", "Time", "Location"]
    ]
}

