//
//  DeletePopUpVC.swift
//  Pouch
//
//  Created by Prince on 07/02/23.
//

import UIKit

class DeletePopUpVC: UIViewController {
    
    @IBOutlet weak var deleteMessageLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        information()
    }

    func information() {
            let attributedString = NSMutableAttributedString(string: "Are you sure you want to delete /n the membership.")
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5
            paragraphStyle.alignment = .center
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        deleteMessageLabel.attributedText = attributedString
        }

    
    
    
}
