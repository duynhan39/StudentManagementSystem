//
//  NewObjectView.swift
//  Student Management System
//
//  Created by Nhan Cao on 10/13/19.
//  Copyright © 2019 Nhan Cao. All rights reserved.
//

import UIKit
@IBDesignable

class NewObjectView: UIView, UITableViewDataSource {
    
    // MARK: - Variables
    private var attributeTable = UITableView()
    private var profileImageView = UIImageView()
    private var viewLabel = UILabel()
    
    private var attributes : [String] {
        get {
            return DataModel.AttributeNames[self.objectType.rawValue] ?? []
        }
    }
    
    var objectType = DataModel.ObjectType.student {
        didSet {
            setNeedsLayout()
            setNeedsDisplay()
            
            viewLabel.text = "Create new \(self.objectType.description.lowercased())"
            
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
        
        addSubview(profileImageView)
        addSubview(attributeTable)
        addSubview(viewLabel)
        
        attributeTable.dataSource = self
        attributeTable.register(NewInfoCell.self, forCellReuseIdentifier: "newInfoCell")
//        attributeTable.bounces = false
        
        attributeTable.allowsSelection =  false
        
        viewLabel.text = "Create new student"
        viewLabel.textAlignment = .center
    }
    
    
    // MARK: - Draw
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsLayout()
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        
        clearsContextBeforeDrawing = true
        
        clearsContextBeforeDrawing = true
        
//        for i in 0...10 { print("++-------") }
//        print("\(objectType)")
//        for i in 0...10 { print("++-------") }
        
        let displayGap : CGFloat = 15
        
        // MARK: Name label
        
        let labelFontSize : CGFloat = 20
        let labelFrame = CGRect(x: 0, y: displayGap, width: self.frame.width, height: labelFontSize)
        viewLabel.frame = labelFrame
        
        viewLabel.font = UIFont.boldSystemFont(ofSize: labelFontSize)
        
//        viewLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: displayGap).isActive = true
//        viewLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        
        // MARK: Profile picture
        let pictureEdge = min(self.frame.width/3, self.frame.height/5)
        let pictureFrame = CGRect(x: (self.frame.width - pictureEdge)*0.5,
                                  y: displayGap + viewLabel.frame.maxY,
                                  width: pictureEdge,
                                  height: pictureEdge)
        profileImageView.frame = pictureFrame
        profileImageView.layer.cornerRadius = pictureEdge*0.5
        
        profileImageView.image = UIImage(systemName: "person.circle.fill")
        profileImageView.tintColor = UIColor.black
        
        // MARK: Attribute table
        let tableY = pictureFrame.maxY + displayGap
        let tableHeight = self.frame.height - tableY
        //min(self.frame.height - tableY, attributeTable.contentSize.height*2)
        
        let tableFrame = CGRect(x: 0,
                                y: tableY,
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newInfoCell", for: indexPath) as! NewInfoCell
        
        let attName = attributes[indexPath.row]
        cell.labelName = attName
        cell.placeHolderText = attName
        
        return cell
    }
    
    // MARK: - Retrieve Data
    func getInputedData() -> [String:Any] {
        var inputtedData = [String:Any]()
        
        let attributeIds : [String:String] = DataModel.AttributeDecodedValue[self.objectType.rawValue] ?? ["":""]
        
        for i in 0..<attributes.count {
            let attName = attributes[i]
            let indexPath = IndexPath(row: i, section: 0)
            let cell = attributeTable.cellForRow(at: indexPath) as! NewInfoCell
            let inputtedText = cell.getInputtedContent()
            
            inputtedData[attributeIds[attName] ?? "None"] = inputtedText
        }
        
        // Retrieve Image
        
        return inputtedData
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

// MARK: - Extension
extension DataModel {
    static let AttributeDecodedValue : [String : [String:String]] = [
        "Student" :     ["First name" : "firstName",
                         "Last name" : "lastName",
                         "Email" : "email",
                         "ID" : "id",
                         "Phone number" : "phone",
                         "Campus address" : "campusAddress"],
        
        "Professor" :   ["First name" :"firstName",
                         "Last name" : "lastName",
                         "Email" : "email",
                         "Home address" : "homeAddress",
                         "Office address" : "officeAddress"],
        
        "Course" :      ["Department Code" : "departmentCode",
                         "Course number" : "number",
                         "Name" : "name",
                         "Meeting days" : "meetingDay",
                         "Time" : "time"]
    ]
    
    static let AttributeNames = [
        "Student" : ["First name", "Last name", "Email", "ID", "Phone number", "Campus address"],
        
        "Professor" : ["First name", "Last name", "Email", "Home address", "Office address"],
        
        "Course" : ["Department Code", "Course number", "Name", "Meeting days", "Time"]
    ]
}

