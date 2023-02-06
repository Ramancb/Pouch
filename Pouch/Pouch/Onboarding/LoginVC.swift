//
//  LoginVC.swift
//  Pouch
//
//  Created by Piyush Kumar on 01/02/23.
//

import UIKit

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var countryCodeTextField: UITextField!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var phoneNoTextField: UITextField!
    @IBOutlet weak var continuebottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var enterDetailLabel: UILabel!
    
    
    @IBOutlet weak var viewOutlet: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboard()
        enterDetail()
        enterDetailLabel.addTextSpacing(spacing: 0.36)
        continueBtn.addTextSpacing(spacing: 1)
        continueBtn.applyGradient(colours: [UIColor(hexString: "#f8d777"), UIColor(hexString: "#bb962d") ], locations: [0.1,0.7])
        viewOutlet.applyGradient(colours: [UIColor(hexString: "#343434"), UIColor(hexString: "#000000") ], locations: [0.1,0.4])
        
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
        self.navigationController?.present(vc, true)
    }
    @IBAction func continueAction(_ sender: Any) {
//        let vc = SideMenuVC()
        let vc = OtpVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
