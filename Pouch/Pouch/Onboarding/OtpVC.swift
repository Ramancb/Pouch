//
//  OtpVC.swift
//  Pouch
//
//  Created by Piyush Kumar on 01/02/23.
//

import UIKit
import SVPinView

class OtpVC: UIViewController {

    @IBOutlet weak var verifyNumberLabel: UILabel!
    @IBOutlet weak var otpView: UIView!
    @IBOutlet weak var otpFieldView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        otpFieldView.becomeFirstResponder()
//        otpFieldView.style = .underline
//        otpFieldView.fieldBackgroundColor = UIColor.white
//        otpFieldView.fieldCornerRadius = 0
       // verifyPhoneNumber()
        otpView.applyGradient(colours: [UIColor(hexString: "#343434"), UIColor(hexString: "#000000") ], locations: [0.1,0.4])
    }
    
    //to set in to next line
    func verifyPhoneNumber() {
        let attributedString = NSMutableAttributedString(string: "We have sent you a code \n to verify your phone number")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.alignment = .center
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        verifyNumberLabel.attributedText = attributedString
    }

    @IBAction func backAction(_ sender: Any) {
        self.popVC()
    }
   
}
