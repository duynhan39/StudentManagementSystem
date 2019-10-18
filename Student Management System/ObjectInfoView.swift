//
//  NewObjectView.swift
//  Student Management System
//
//  Created by Nhan Cao on 10/13/19.
//  Copyright © 2019 Nhan Cao. All rights reserved.
//

import UIKit
@IBDesignable

class ObjectInfoView: UIView, UITableViewDataSource  {
    
    // MARK: - Variables
    private var tableView = UITableView()
    var profileImageView = UIImageView()
    private var viewLabel = UILabel()
    private var segmentedSwitch = UISegmentedControl(items: ["Info", "Courses"])
    private var addRelationButton = UIButton()
    
    let defaultSystemImage = "person.circle.fill"
    var didSetImage = false
    
    var parent :InfoViewController? = nil
    
    var objectData = [String:Any]() {
        didSet {
            updateProperties()
            showProfilePicture()
        }
    }
    
    var tableContent : [Any] {
        switch viewTarget {
        case .info:
            return attributeNames
        default:
            switch objectType {
            case .student:
                return objectData["enrolledIn"] as? [Any] ?? [Any]()
            case .professor:
                return [Any]()
            case .course:
                return [Any]()
            }
            
        }
    }
    
    private var attributeNames : [String] {
        get {
            return ObjectInfoView.AttributeNames[self.objectType.rawValue] ?? []
        }
    }
    
    var objectType = DataModel.ObjectType.student {
        didSet {
            refresh()
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
            updateProperties()
        }
    }
    
    var viewTarget = ObjectInfoView.ViewTarget.info {
        didSet {
            tableView.reloadData()
            switch viewTarget {
            case .info:
                addRelationButton.isHidden = true
            case .relation:
                addRelationButton.isHidden = false
            }
        }
    }
    
    var isEditable : Bool {
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
        addSubview(tableView)
        addSubview(viewLabel)
        addSubview(segmentedSwitch)
        addSubview(addRelationButton)
        
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(pickImage(_:)))
        profileImageView.addGestureRecognizer(tapGuesture)
        profileImageView.image = UIImage(systemName: defaultSystemImage)
        
        tableView.dataSource = self
        tableView.register(InfoCell.self, forCellReuseIdentifier: "newInfoCell")
        tableView.bounces = false
        tableView.allowsSelection =  false
//        tableView.isEditing = true
        
        viewLabel.textAlignment = .center
        
        segmentedSwitch.selectedSegmentIndex = 0
        segmentedSwitch.addTarget(self, action: #selector(changeTargetView(_:)), for: .valueChanged)
        
        addRelationButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        addRelationButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .highlighted)
        addRelationButton.isHidden = true
        addRelationButton.addTarget(self, action: #selector(openObjectPicker(_:)), for: .touchUpInside)
        
    }
    
    // MARK: Functional features
    
    @objc private func pickImage(_ sender: Any) {
        if parent != nil {
            parent?.showImagePickerOptions()
        }
    }
    
    @objc private func changeTargetView(_ sender: Any) {
        viewTarget = ObjectInfoView.ViewTarget(rawValue: segmentedSwitch.selectedSegmentIndex) ?? .info
    }
    
    @objc private func openObjectPicker(_ sender: Any) {

    }
    
    // MARK: - Retrieve Data
    func getInputedData() -> [String:Any] {
        let attributeIds : [String:String] = ObjectInfoView.AttributeDecodedValue[self.objectType.rawValue] ?? ["":""]
        var data = [String:Any]()
        for i in 0..<attributeNames.count {
            let attName = attributeNames[i]
            let indexPath = IndexPath(row: i, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) as? InfoCell {
                let attVal : String = cell.attributeInputTextField.text ?? ""
                data[attributeIds[attName] ?? "None"] = attVal
            }
        }
        
        if didSetImage {
            data["photo"] = profileImageView.image?.pngData()
        }
        
        objectData = data
        return data
    }
    
    
    // MARK: - Display
    fileprivate func refresh() {
        setNeedsLayout()
        setNeedsDisplay()
        updateProperties()
    }
    
    func showProfilePicture() {
        if viewMode != .add {
            if let data = objectData["photo"] as? NSData {
                var image = UIImage(data: data as Data)
                if image == nil {
                    didSetImage = false
                    image = UIImage(systemName: defaultSystemImage)
                }
                profileImageView.image = image
            }
        }
    }
    
    private func updateProperties() {
        tableView.reloadData()
        tableView.isUserInteractionEnabled = isEditable
        profileImageView.isUserInteractionEnabled = isEditable
        
        if viewMode == .view {
            segmentedSwitch.isHidden = false
        } else {
            segmentedSwitch.isHidden = true
        }
        
        switch objectType {
        case .student, .professor:
            segmentedSwitch.setTitle("Courses", forSegmentAt: 1)
        case .course:
            segmentedSwitch.setTitle("People", forSegmentAt: 1)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsLayout()
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        clearsContextBeforeDrawing = true
        tableView.separatorStyle = .none
        
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
            let profilePicFrame = CGRect(x: (self.frame.width - pictureEdge)*0.5,
                                      y: currentAvaiY,
                                      width: pictureEdge,
                                      height: pictureEdge)
            
            profileImageView.frame = profilePicFrame
            profileImageView.layer.cornerRadius = pictureEdge*0.5
            profileImageView.clipsToBounds = true
            
            profileImageView.tintColor = UIColor.black
            
            currentAvaiY = profilePicFrame.maxY + displayGap
        }
        
        // MARK: Segmented Control
        
        let segmentHeight : CGFloat = segmentedSwitch.frame.height
        segmentedSwitch.center = CGPoint(x: self.frame.width/2, y: currentAvaiY+segmentHeight/2)
        
        // MARK: Add relation button
        
        addRelationButton.frame = CGRect(x: self.frame.width - segmentHeight, y: currentAvaiY, width: segmentHeight, height: segmentHeight)
//         = addRelaButtonFrame
        
        if viewMode == .view || viewMode == .edit {
            currentAvaiY = segmentedSwitch.frame.maxY + displayGap
        }
        
        // MARK: Attribute table
        let tableHeight = self.frame.height - currentAvaiY
        let tableFrame = CGRect(x: 0,
                                y: currentAvaiY + displayGap,
                                width: self.frame.width,
                                height: tableHeight)
        
        tableView.frame = tableFrame
        
        let indexPath = IndexPath(row: 0, section: 0)
        if tableView.numberOfRows(inSection: 0) > 0 {
            tableView.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableContent.count
    }
    
    // MARK: Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newInfoCell", for: indexPath) as! InfoCell
        
        switch viewTarget {
        case .info:
            setUpAttribute(for: cell, at: indexPath.row)
        case .relation:
            setUpRelation(for: cell, at: indexPath.row)
        }
        
        return cell
    }
    
    private func setUpAttribute(for cell: InfoCell, at index: Int){
        let attName : String = attributeNames[index]
        cell.labelName = attName
        cell.viewMode = viewMode
        
        var textFieldContent : String
        switch viewMode {
        case .edit, .view:
            let keyDict = ObjectInfoView.AttributeDecodedValue[objectType.description]
            textFieldContent = (objectData[keyDict?[attName] ?? ""] as? String) ?? ""
        default:
            textFieldContent = ""
        }
        cell.attributeInputTextField.text = textFieldContent
    }
    
    private func setUpRelation(for cell: InfoCell, at index: Int){
//        let attName : String = attributeNames[index]
//        cell.labelName = attName
//        cell.viewMode = viewMode
//
//        var textFieldContent : String
//        switch viewMode {
//        case .edit, .view:
//            textFieldContent = (objectData[ObjectInfoView.AttributeDecodedValue[objectType.description]?[attName] ?? ""] as? String) ?? ""
//        default:
//            textFieldContent = ""
//        }
//        cell.attributeInputTextField.text = textFieldContent
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
extension ObjectInfoView {
    enum ViewMode: Int {
        case add = 0, edit, view
    }
    
    enum ViewTarget: Int {
        case info = 0, relation
    }
    
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

//extension UIViewController {
//    @objc func presentImagePicker() {}
//}
