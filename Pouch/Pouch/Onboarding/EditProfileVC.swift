//
//  EditProfileVC.swift
//  Pouch
//
//  Created by Piyush Kumar on 03/02/23.
//

import UIKit


class EditProfileVC: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var editProfileView: UIView!
    
    
    var Profile: EditProfilePresenter?
    var presenter: EditProfilePresenterProtocol?
    var editProfileData:editProfileData?
    var isSelected: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate = self
        nameField.delegate = self
        lastNameField.delegate = self
        editProfileView.applyGradient(colours: [UIColor(hexString: "#343434"), UIColor(hexString: "#000000") ], locations: [0.1,0.7])
    }
    @IBAction func saveAction(_ sender: Any) {
        if presenter?.validateFields() == true{
            print("success")
        }
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension EditProfileVC: EditProfileViewProtocol{
      func receiveData() {
        self.nameField.text = Profile?.firstName
        self.lastNameField.text = Profile?.lastName
        self.emailField.text = Profile?.email
    }
}

extension EditProfileVC: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if  emailField != nil {
            emailField.borderWidth = 2
            emailField.borderColor = UIColor.appColor(.themeYellow)
        }else if nameField == nil{
            nameField.borderWidth = 2
            nameField.borderColor = UIColor.appColor(.themeYellow)
        }else if lastNameField == nil{
            lastNameField.borderWidth = 2
            lastNameField.borderColor = UIColor.appColor(.themeYellow)
        }
    }
}
