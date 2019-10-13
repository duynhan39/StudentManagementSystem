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
    
    var attributeTable = UITableView()
    var profileImageView = UIImageView()
    
    var attributes = [String]()
    var objectType = DataModel.ObjectType.student {
        didSet {
            switch self.objectType {
            case .student:
                attributes = DataModel.Attributes["student"] ?? []
            case .professor:
                attributes = DataModel.Attributes["professor"] ?? []
            default:
                attributes = []
            }
            setNeedsLayout()
            setNeedsDisplay()
        }
    }
    
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
    
    override func draw(_ rect: CGRect) {
        objectType = DataModel.ObjectType.student
        
        let displayGap : CGFloat = 15
        let pictureEdge = self.frame.width/3
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attributes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newInfoCell", for: indexPath) as! NewInfoCell
        
        let attName = attributes[indexPath.row]
        cell.labelName = attName //" \(attName)"
        cell.placeHolderText = attName

        return cell
    }
    
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
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

