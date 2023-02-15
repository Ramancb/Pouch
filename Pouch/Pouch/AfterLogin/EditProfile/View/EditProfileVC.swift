//
//  EditProfileVC.swift
//  Pouch
//
//  Created by Piyush Kumar on 03/02/23.
//

import UIKit


class EditProfileVC: UIViewController {
    
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var lastNameTextView: UIView!
    @IBOutlet weak var emailTextView: UIView!
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var editProfileView: UIView!
    
    
    var profile: EditProfilePresenter?
    var presenter: EditProfilePresenterProtocol?
    var editProfileData:EditProfileData?
    var isSelected: Bool = false
    var firstName: String?
    var lastName: String?
    var email: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAppStr()
        initialSetup()
        
    }
    func setAppStr(){
        emailAddressLabel.text = AppStrings.emailAddress
        settingsLabel.text = AppStrings.settings
        lastNameLabel.text = AppStrings.lastName
        firstNameLabel.text = AppStrings.firstName
        saveButton.setTitle(AppStrings.save, for: .normal)
        emailField.placeholder = AppStrings.enterEmail
        nameField.placeholder = AppStrings.enterFirstName
        lastNameField.placeholder = AppStrings.enterLastName
        
    }
    
    func initialSetup(){
        emailField.placeHolderTextColor = UIColor.appColor(.lightGray)
        lastNameField.placeHolderTextColor = UIColor.appColor(.lightGray)
        nameField.placeHolderTextColor = UIColor.appColor(.lightGray)
        emailField.delegate = self
        nameField.delegate = self
        lastNameField.delegate = self
        editProfileView.applyGradient(colours: [UIColor(hexString: "#343434"), UIColor(hexString: "#000000") ], locations: [0.0,0.5])
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        var json = ["email": editProfileData?.email,
                    "firstname": editProfileData?.firstname,
                    "lastname" :  editProfileData?.lastname]
        
    if presenter?.validateFields(firstName: nameField.text ?? "", email : emailField.text ?? "", lastName : lastNameField.text ?? "") == true{
            print("success")
        }
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

extension EditProfileVC: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == nameField {
            textView.borderWidth = 1
            textView.borderColor = UIColor.appColor(.themeYellow)
            textView.backgroundColor = UIColor.appColor(.backgroundWhite)
        }else if textField == lastNameField{
            lastNameTextView.borderWidth = 1
            lastNameTextView.borderColor = UIColor.appColor(.themeYellow)
            lastNameTextView.backgroundColor = UIColor.appColor(.backgroundWhite)
        }else if textField == emailField{
            
              emailTextView.borderWidth = 1
              emailTextView.borderColor = UIColor.appColor(.themeYellow)
              emailTextView.backgroundColor = UIColor.appColor(.backgroundWhite)
        } else {
        }
}
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == nameField {
            textView.borderWidth = 1
            textView.borderColor = UIColor.clear
            textView.backgroundColor = UIColor(hexString: "#272727", alpha: 1)
        }else if textField == lastNameField{
            lastNameTextView.borderWidth = 1
            lastNameTextView.borderColor = UIColor.clear
            lastNameTextView.backgroundColor = UIColor(hexString: "#272727", alpha: 1)
        }else if textField == emailField{
            emailTextView.borderWidth = 1
            emailTextView.borderColor = UIColor.clear
            emailTextView.backgroundColor = UIColor(hexString: "#272727", alpha: 1)
        }
    }
    
}
