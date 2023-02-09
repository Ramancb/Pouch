//
//  LoginVC.swift
//  Pouch
//
//  Created by Piyush Kumar on 01/02/23.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var countryCodeBtn: UIButton!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var phoneNoTextField: UITextField!
    @IBOutlet weak var continuebottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var enterDetailLabel: UILabel!
    @IBOutlet weak var continueBtnBgView: UIView!
    
    var presenter: LoginPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboard()
        self.phoneNoTextField.delegate = self
        enterDetail()
        enterDetailLabel.addTextSpacing(spacing: 0.36)
        continueBtn.addTextSpacing(spacing: 1)
        self.continueBtnBgView.applyGradient(colours: [UIColor(hexString: "#f8d777"), UIColor(hexString: "#bb962d") ], locations: [0,1])
        self.view.applyGradient(colours: [UIColor(hexString: "#343434"), UIColor(hexString: "#000000") ], locations: [0,1])
        
    }
    func setKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification , object:nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification , object:nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            continuebottomConstraint.constant = keyboardHeight+23
            view.layoutIfNeeded()
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        continuebottomConstraint.constant = 40
        view.layoutIfNeeded()
    }
    func enterDetail() {
        let attributedString = NSMutableAttributedString(string: "Enter your mobile number to enable 2-step verification.")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.alignment = .center
        paragraphStyle.paragraphSpacing = 20
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        enterDetailLabel.attributedText = attributedString
    }
    
    @IBAction func infoAction(_ sender: Any) {
        
    let vc = WhyMobileNoPopUpViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, false)
    }
    
    @IBAction func countryCodeAction(_ sender: UIButton) {
        
    }
    
    @IBAction func continueAction(_ sender: Any) {
        self.view.endEditing(true)
        let validateField = Validator.validatePhoneNumber(number: self.phoneNoTextField.text)
        guard validateField.0 == true else{
            Singleton.shared.showMessage(message: validateField.1, isError: .error)
            return
        }
        let apiName = API.Name.login_Init + (self.phoneNoTextField.text ?? "")
        ApiHandler.call(apiName: apiName, params: [:], httpMethod: .POST) { (data:MessageResponse?, error) in
            DispatchQueue.main.async {
                guard let _ = data else {
                    Singleton.shared.showMessage(message: error ?? "", isError: .error)
                    return
                }
                let controller = OtpVC()
                controller.mobileNumber = self.phoneNoTextField.text
                self.pushViewController(controller, true)
            }
        }
//        let controller = OtpVC()
//        controller.mobileNumber = self.phoneNoTextField.text
//        self.pushViewController(controller, true)

    }
}

extension LoginVC: LoginViewProtocol{
     
    
    
}

extension LoginVC:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = format(with: "XXXXXXXXXX", phone: newString)
//            self.checkEmptyFields()
        return false
    }
}


