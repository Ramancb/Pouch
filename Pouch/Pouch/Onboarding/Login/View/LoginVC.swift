//
//  LoginVC.swift
//  Pouch
//
//  Created by Piyush Kumar on 01/02/23.
//

import UIKit

class LoginVC: UIViewController, LoginViewProtocol {
    
    /// ViewController IBoutlets
    @IBOutlet weak var countryCodeBtn: UIButton!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var phoneNoTextField: UITextField!
    @IBOutlet weak var continuebottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var enterDetailLabel: UILabel!
    @IBOutlet weak var continueBtnBgView: UIView!
    
    /// ViewController global variables
    var presenter: LoginPresenterProtocol?
    
    /// ViewController lyfecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setKeyboard()
        self.phoneNoTextField.delegate = self
        self.setInitalViews()
        let _ = Device_ID.getIDFA()
    }
    
    /// Method to set gradiant color and sapacing to views
    func setInitalViews(){
        self.enterDetailLabel.setLineSpacing(lineSpacing: 5.0, textAlignment: .center)
        self.continueBtnBgView.applyGradient(colours: [UIColor(hexString: "#f8d777"), UIColor(hexString: "#bb962d") ], locations: [0,1])
        self.view.applyGradient(colours: [UIColor(hexString: "#161a1a"), UIColor(hexString: "#000000") ], locations: [0,0.7])
    }
    
    ///  Set keyboard layout
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
    
    /// ViewController IBActions
    @IBAction func infoAction(_ sender: Any) {
        self.presenter?.presentInformationScreen()
    }
    
    @IBAction func countryCodeAction(_ sender: UIButton) {
        
    }
    
    @IBAction func continueAction(_ sender: Any) {
        self.view.endEditing(true)
        self.presenter?.apiCallToLogin(phone_number: self.phoneNoTextField.text)
    }
}

extension LoginVC:UITextFieldDelegate{
    // UITextFieldDelegate method
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        //Set Phone number 10 digit only format
        textField.text = format(with: "XXXXXXXXXX", phone: newString)
        return false
    }
}


