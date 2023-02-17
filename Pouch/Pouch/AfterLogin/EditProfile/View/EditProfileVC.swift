//
//  EditProfileVC.swift
//  Pouch
//
//  Created by Piyush Kumar on 03/02/23.
//

import UIKit


class EditProfileVC: UIViewController{
    
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var editProfileView: UIView!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet var editProfileSuperview: UIView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var profile: EditProfilePresenter?
    var presenter: EditProfilePresenterProtocol?
    var isSelected: Bool = false
    var updatedText: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.editProfileView.transform = CGAffineTransform(translationX: 0, y: self.editProfileView.frame.height)
        setAppStr()
        initialSetup()
        tapToDismiss()
        self.nameField.delegate = self
        self.lastNameField.delegate = self
        self.emailField.delegate = self
        self.cityField.delegate = self
    }
    func setAppStr(){
        saveButton.setTitle(AppStrings.save, for: .normal)
        emailField.placeholder = AppStrings.enterEmail
        nameField.placeholder = AppStrings.enterFirstName
        lastNameField.placeholder = AppStrings.enterLastName
        cityField.placeholder = AppStrings.city
    }
    func tapToDismiss(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissController))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tap)
        tap.delegate = self
        
    }
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.editProfileView.transform = CGAffineTransform.identity
        }
    }
    @objc func dismissController(){
        UIView.animate(withDuration: 0.3) {
            self.editProfileView.transform = CGAffineTransform(translationX: 0, y: self.editProfileView.frame.height)
        } completion: { isSucceed in
            self.dismiss(animated: false)
        }
    }
    func initialSetup(){
        emailField.placeHolderTextColor = UIColor.appColor(.lightGray)
        lastNameField.placeHolderTextColor = UIColor.appColor(.lightGray)
        nameField.placeHolderTextColor = UIColor.appColor(.lightGray)
        cityField.placeHolderTextColor = UIColor.appColor(.lightGray)
        editProfileSuperview.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        //        emailField.delegate = self
        //        nameField.delegate = self
        //        lastNameField.delegate = self
        editProfileView.backgroundColor = UIColor.black
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        self.presenter?.editProfileApiCall(firstName:   nameField.text ?? "", lastName: lastNameField.text ?? "", email: emailField.text ?? "", city: cityField.text ?? "")
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension EditProfileVC: EditProfileViewProtocol{
    func receiveData() {
        //        self.nameField.text = profile?.firstName
        //        self.lastNameField.text = profile?.lastName
        //        self.emailField.text = profile?.email
    }
}

extension EditProfileVC: UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: self.editProfileView) == true{
            return false
        }
        return true
    }
}


extension EditProfileVC: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        let update = (newString as String).trimmingCharacters(in: .whitespaces)
        textField.text = update
        if(textField == nameField)
        {
            if range.location == 0 && string == " "
            {
                return false
            }
            else if range.length + range.location > (self.nameField.text?.count)!
            {
                return false
            }
        } else  if(textField == lastNameField)
        {
            if range.location == 0 && string == " "
            {
                return false
            }
            else if range.length + range.location > (self.nameField.text?.count)!
            {
                return false
            }
        }else  if(textField == emailField)
        {
            if range.location == 0 && string == " "
            {
                return false
            }
            else if range.length + range.location > (self.nameField.text?.count)!
            {
                return false
            }
        } else  if(textField == cityField)
        {
            if range.location == 0 && string == " "
            {
                return false
            }
            else if range.length + range.location > (self.nameField.text?.count)!
            {
                return false
            }
        }
        return true
    }
    
   

    
    
    
    
        
        //
        //    func textFieldDidBeginEditing(_ textField: UITextField) {
        //        if textField == nameField {
        //            textView.borderWidth = 1
        //            textView.borderColor = UIColor.appColor(.themeYellow)
        //            textView.backgroundColor = UIColor.appColor(.backgroundWhite)
        //        }else if textField == lastNameField{
        //            lastNameTextView.borderWidth = 1
        //            lastNameTextView.borderColor = UIColor.appColor(.themeYellow)
        //            lastNameTextView.backgroundColor = UIColor.appColor(.backgroundWhite)
        //        }else if textField == emailField{
        //
        //              emailTextView.borderWidth = 1
        //              emailTextView.borderColor = UIColor.appColor(.themeYellow)
        //              emailTextView.backgroundColor = UIColor.appColor(.backgroundWhite)
        //        } else {
        //        }
        //}
        //
        //    func textFieldDidEndEditing(_ textField: UITextField)
        //
        //        if textField == nameField {
        //            textView.borderWidth = 1
        //            textView.borderColor = UIColor.clear
        //            textView.backgroundColor = UIColor(hexString: "#272727", alpha: 1)
        //        }else if textField == lastNameField{
        //            lastNameTextView.borderWidth = 1
        //            lastNameTextView.borderColor = UIColor.clear
        //            lastNameTextView.backgroundColor = UIColor(hexString: "#272727", alpha: 1)
        //        }else if textField == emailField{
        //            emailTextView.borderWidth = 1
        //            emailTextView.borderColor = UIColor.clear
        //            emailTextView.backgroundColor = UIColor(hexString: "#272727", alpha: 1)
        //        }
        //    }
        
    }

