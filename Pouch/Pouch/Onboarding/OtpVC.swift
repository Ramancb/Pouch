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
    @IBOutlet weak var otpBGView: UIView!

    @IBOutlet weak var otpField1: MyOTPTF!
    
    @IBOutlet weak var otpField2: MyOTPTF!
    @IBOutlet weak var otpField3: MyOTPTF!
    @IBOutlet weak var otpField4: MyOTPTF!
    @IBOutlet weak var otpField5: MyOTPTF!
    @IBOutlet weak var otpField6: MyOTPTF!
    
    
    @IBOutlet weak var resendOtpButton: UIButton!
    
    var timer: Timer?
    var runCount = 120
    var mobileNumber = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verifyPhoneNumber()
        otpBGView.applyGradient(colours: [UIColor(hexString: "#343434"), UIColor(hexString: "#000000") ], locations: [0.1,0.4])
        setData()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        otpField1.setPlaceHolderColorWith(strPH: "0", color: UIColor.white.withAlphaComponent(0.3))
        otpField2.setPlaceHolderColorWith(strPH: "0", color: UIColor.white.withAlphaComponent(0.3))
        otpField3.setPlaceHolderColorWith(strPH: "0", color: UIColor.white.withAlphaComponent(0.3))
        otpField4.setPlaceHolderColorWith(strPH: "0", color: UIColor.white.withAlphaComponent(0.3))
        otpField5.setPlaceHolderColorWith(strPH: "0", color: UIColor.white.withAlphaComponent(0.3))
        otpField6.setPlaceHolderColorWith(strPH: "0", color: UIColor.white.withAlphaComponent(0.3))
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
    func setData(){
        otpField1.myDelegate = self
        otpField2.myDelegate = self
        otpField3.myDelegate = self
        otpField4.myDelegate = self
        otpField5.myDelegate = self
        otpField6.myDelegate = self
        otpField1.delegate = self
        otpField2.delegate = self
        otpField3.delegate = self
        otpField4.delegate = self
        otpField5.delegate = self
        otpField6.delegate = self
        otpField1.becomeFirstResponder()
    }
    

    @IBAction func backAction(_ sender: Any) {
        self.popVC()
    }
   
}

extension OtpVC : UITextFieldDelegate, MyOTPTFDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // On inputing value to textfield
        if ((textField.text?.count)! < 1  && string.count > 0){
            let nextTag = textField.tag + 1
            var nextResponder = textField.superview?.viewWithTag(nextTag);
            if (nextResponder == nil) {
               
                nextResponder = textField.superview?.viewWithTag(1);
            } else {
                textField.text = string
                nextResponder?.becomeFirstResponder()
                return false
            }
        } else if ((textField.text?.count)! >= 1  && string.count == 0) {
            // on deleteing value from Textfield
            var previousTag = textField.tag - 1
            if let checkForNextTF = textField.superview?.viewWithTag(textField.tag + 1) {
                
            }
            else {
                previousTag = textField.tag
              
            }
            var previousResponder = textField.superview?.viewWithTag(previousTag)
            if (previousResponder == nil){
                previousResponder = textField.superview?.viewWithTag(1)
            }
            textField.text = ""
            previousResponder?.becomeFirstResponder()
            return false
        } else if ((textField.text?.count)! >= 1  && string.count == 1) {
            let nextTag = textField.tag + 1
            // get next responder
            var nextResponder = textField.superview?.viewWithTag(nextTag)
            if (nextResponder == nil) {
                nextResponder = textField.superview?.viewWithTag(1)
            } else {
                textField.text = string
                nextResponder?.becomeFirstResponder()
                return false
            }
            return false
        } else if ((textField.text?.count)! == 0  && string.count == 0) {
            // on deleteing value from Textfield
            let previousTag = textField.tag - 1
            // get next responder
            var previousResponder = textField.superview?.viewWithTag(previousTag)
            if (previousResponder == nil) {
                previousResponder = textField.superview?.viewWithTag(1)
            }
            textField.text = ""
            previousResponder?.becomeFirstResponder()
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidDelete(_ textField: UITextField) {
        let string = textField.text ?? ""
        if (string.count == 0) {
            // on deleteing value from Textfield
            let previousTag = textField.tag - 1
            // get next responder
            if let previousResponder = textField.superview?.viewWithTag(previousTag), previousResponder is MyOTPTF {
                (previousResponder as! MyOTPTF).text = ""
                previousResponder.becomeFirstResponder()
            }
        }
    }
}
