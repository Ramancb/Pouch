//
//  OtpVC.swift
//  Pouch
//
//  Created by Piyush Kumar on 01/02/23.
//

import UIKit
import ObjectMapper

class OtpVC: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var otpStackView: UIStackView!
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
    var mobileNumber:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verifyPhoneNumber()
        otpBGView.applyGradient(colours: [UIColor(hexString: "#343434"), UIColor(hexString: "#000000") ], locations: [0,1])
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
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    @objc func fireTimer() {
        runCount -= 1
        self.timerLabel.text = "Resend code in \(runCount) secs"
        self.resendOtpButton.isEnabled = false
        if runCount == 0 {
            self.resendOtpButton.isEnabled = true
            timer?.invalidate()
            runCount = 120
            self.timerLabel.text = ""
        }
    }
    

    @IBAction func backAction(_ sender: Any) {
        self.popVC()
    }
   
    @IBAction func resendOtpAction(_ sender: UIButton) {
        let apiName = API.Name.login_Init + (self.mobileNumber ?? "")
        ApiHandler.call(apiName: apiName, params: [:], httpMethod: .POST) { (data:MessageResponse?, error) in
            DispatchQueue.main.async {
                guard let _ = data else {
                    Singleton.shared.showMessage(message: error ?? "", isError: .error)
                    return
                }
                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.fireTimer), userInfo: nil, repeats: true)
            }
        }
    }
    
    func jsonToVarifyOtp()-> JSON{
        var json = JSON()
        json["username"] = self.mobileNumber
        json["otp"] = self.getOtpString()
        json["appVersion"] = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        json["fcmToken"] = UserDefaultsCustom.getDeviceToken()
        json["deviceId"] = ""
        return json
    }
    
    func getOtpString()->String?{
        var otpString = ""
        guard let field1 = self.otpField1.text, field1.count > 0 else{
            return nil
        }
        otpString = field1
        guard let field2 = self.otpField2.text, field2.count > 0 else{
            return nil
        }
        otpString.append(contentsOf: field2)//appending(field2)
        guard let field3 = self.otpField3.text, field3.count > 0 else{
            return nil
        }
        otpString.append(contentsOf: field3)
        guard let field4 = self.otpField4.text, field4.count > 0 else{
            return nil
        }
        otpString.append(contentsOf: field4)
        guard let field5 = self.otpField5.text, field5.count > 0 else{
            return nil
        }
        otpString.append(contentsOf: field5)
        guard let field6 = self.otpField6.text, field6.count > 0 else{
            return nil
        }
        otpString.append(contentsOf: field6)
        return otpString
    }
    
    func verifyOtP(){
        self.view.endEditing(true)
        ApiHandler.call( apiName: API.Name.login_attempt, params: self.jsonToVarifyOtp(), httpMethod:.POST) { (data:MessageResponse?, error) in
            DispatchQueue.main.async {
                guard let _ = data else {
                    Singleton.shared.showMessage(message: error ?? "", isError: .error)
                    return
                }
                UserDefaultsCustom.setValue(value: data?.response ?? "", for: UserDefaultsCustom.accessToken)
                Singleton.shared.gotoHome()
            }
        }

    }
}

extension OtpVC : UITextFieldDelegate, MyOTPTFDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // On inputing value to textfield
        if ((textField.text?.count)! < 1  && string.count > 0){
            let nextTag = textField.tag + 1
            var nextResponder = self.otpStackView.viewWithTag(nextTag)//textField.superview?.viewWithTag(nextTag);
            if (nextResponder == nil) {
                if textField.tag == 6{
                    textField.text = string
                    self.verifyOtP()
                }
                nextResponder = self.otpStackView.viewWithTag(1)//textField.superview?.viewWithTag(1);
            } else {
                textField.text = string
                nextResponder?.becomeFirstResponder()
                return false
            }
        } else if ((textField.text?.count)! >= 1  && string.count == 0) {
            // on deleteing value from Textfield
            var previousTag = textField.tag - 1
            if let checkForNextTF = self.otpStackView.viewWithTag(textField.tag + 1){//textField.superview?.viewWithTag(textField.tag + 1) {
                
            }
            else {
                previousTag = textField.tag
              
            }
            var previousResponder = self.otpStackView.viewWithTag(previousTag)//textField.superview?.viewWithTag(previousTag)
            if (previousResponder == nil){
                previousResponder = self.otpStackView.viewWithTag(1)//textField.superview?.viewWithTag(1)
            }
            textField.text = ""
            previousResponder?.becomeFirstResponder()
            return false
        } else if ((textField.text?.count)! >= 1  && string.count == 1) {
            let nextTag = textField.tag + 1
            // get next responder
            var nextResponder = self.otpStackView.viewWithTag(nextTag)//textField.superview?.viewWithTag(nextTag)
            if (nextResponder == nil) {
                nextResponder = self.otpStackView.viewWithTag(1)//textField.superview?.viewWithTag(1)
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
            var previousResponder = self.otpStackView.viewWithTag(previousTag)//textField.superview?.viewWithTag(previousTag)
            if (previousResponder == nil) {
                previousResponder = self.otpStackView.viewWithTag(1)//textField.superview?.viewWithTag(1)
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
            if textField.tag == 1{
                return
            }
            let previousTag = textField.tag - 1
            // get next responder
            if let previousResponder = self.otpStackView.viewWithTag(previousTag){//textField.superview?.viewWithTag(previousTag), previousResponder is MyOTPTF {
                (previousResponder as! MyOTPTF).text = ""
                previousResponder.becomeFirstResponder()
            }
        }
    }
}
