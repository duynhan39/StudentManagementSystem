//
//  CreateNewObjectViewController.swift
//  Student Management System
//
//  Created by Nhan Cao on 10/12/19.
//  Copyright © 2019 Nhan Cao. All rights reserved.
//

import UIKit

@IBDesignable
class NewPersonViewController: UIViewController {

    
    @IBOutlet weak var WholeView: UIView!
    
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
            refreshUI()
        }
    }
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        attributeTable.dataSource = self
        objectType = DataModel.ObjectType.student
        
        WholeView.addSubview(profileImageView)
        WholeView.addSubview(attributeTable)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refreshUI()
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return attributes.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "newInfoCell", for: indexPath) as! NewInfoCell
//
////        let formattedString = NSMutableAttributedString()
//
//        cell.attributeLabel.text = " \(attributes[indexPath.row])"
////        attributedText = formattedString.bold(" \(attributes[indexPath.row])")
//
//        return cell
//    }
    
    private func refreshUI() {
        let pictureEdge = WholeView.frame.width/3
        let pictureFrame = CGRect(x: WholeView.frame.midX - pictureEdge*0.5,
                                  y: 15,
                                  width: pictureEdge,
                                  height: pictureEdge)
        profileImageView.frame = pictureFrame
        profileImageView.layer.cornerRadius = pictureEdge*0.5
        
        profileImageView.image = UIImage(systemName: "contact")
        
        
//        pictureFrame.s =
//        pictureFrame.height =
//        pictureFrame.width = WholeView.frame.width/3
        
        
        
        
        
        
        
        
        
//        let indexPath = IndexPath(row: 0, section: 0)
//        if attributeTable.numberOfRows(inSection: 0) > 0 {
//            attributeTable.scrollToRow(at: indexPath, at: .top, animated: false)
//        }
    
        
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

extension DataModel {
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

