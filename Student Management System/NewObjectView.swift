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
    
    private var attributes = [String]()
    
    private var objectType = DataModel.ObjectType.student {
        didSet {
            attributes = DataModel.AttributeNames[self.objectType.rawValue] ?? []
            
            setNeedsLayout()
            setNeedsDisplay()
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
        attributeTable.dataSource = self
        attributeTable.register(NewInfoCell.self, forCellReuseIdentifier: "newInfoCell")
        attributeTable.bounces = false
        
        attributeTable.allowsSelection =  false
    }
    
    
    // MARK: - Draw
    
//    override func layoutIfNeeded() {
//        setNeedsDisplay()
//        setNeedsLayout()
//    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsLayout()
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        objectType = DataModel.ObjectType.student
        
        let displayGap : CGFloat = 15
        let pictureEdge = min(self.frame.width/3, self.frame.height/5)
        let pictureFrame = CGRect(x: self.frame.midX - pictureEdge*0.5,
                                  y: displayGap,
                                  width: pictureEdge,
                                  height: pictureEdge)
        profileImageView.frame = pictureFrame
        profileImageView.layer.cornerRadius = pictureEdge*0.5
        
        profileImageView.image = UIImage(systemName: "person.circle.fill")
        profileImageView.tintColor = UIColor.black
        
        
        let tableY = pictureFrame.maxY + displayGap
        let tableHeight = min(self.frame.height - tableY, attributeTable.contentSize.height*2)
        
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
        
        "Course" : ["":""]
    ]
    
    static let AttributeNames = [
        "Student" : ["First name", "Last name", "Email", "ID", "Phone number", "Campus address"],
        
        "Professor" : ["First name", "Last name", "Email", "Home address", "Office address"]
    ]
}

