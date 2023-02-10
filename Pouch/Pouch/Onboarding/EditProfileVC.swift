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
        emailField.placeHolderTextColor = UIColor.appColor(.lightGray)
        lastNameField.placeHolderTextColor = UIColor.appColor(.lightGray)
        nameField.placeHolderTextColor = UIColor.appColor(.lightGray)
        emailField.delegate = self
        nameField.delegate = self
        lastNameField.delegate = self
        editProfileView.applyGradient(colours: [UIColor(hexString: "#343434"), UIColor(hexString: "#000000") ], locations: [0.0,0.5])
    }
        
    
    @IBAction func saveAction(_ sender: UIButton) {
//        self.view.endEditing(true)
        if presenter?.validateFields() == true{
            print("success")
        }
    }
    @IBAction func backAction(_ sender: UIButton) {
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
        
        textField.borderWidth = 2
        textField.borderColor = UIColor.appColor(.themeYellow)
        textField.backgroundColor = UIColor.appColor(.backgroundWhite)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.borderWidth = 0
        textField.borderColor = UIColor.clear
        textField.backgroundColor = UIColor.clear
    }
    
}
