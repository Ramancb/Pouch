//
//  EditProfileVC.swift
//  Pouch
//
//  Created by Piyush Kumar on 03/02/23.
//

import UIKit

protocol EditProfileVCDelegate{
    func editProfileSuccess()
}


class EditProfileVC: UIViewController{
    
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var emailField: FloatingPlaceHolderTextFiled!
    @IBOutlet weak var lastNameField: FloatingPlaceHolderTextFiled!
    @IBOutlet weak var firstNameField: FloatingPlaceHolderTextFiled!
    @IBOutlet weak var contentView: SwipeableView!
    @IBOutlet weak var cityField: FloatingPlaceHolderTextFiled!
    
    var profile: EditProfilePresenter?
    var presenter: EditProfilePresenterProtocol?
    var isSelected: Bool = false
    var updatedText: String?
    var delegate:EditProfileVCDelegate?
    var updatedData = UserDefaultsCustom.getUserData()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.applyGradient(colours: [UIColor(hexString: "#161a1a"), UIColor(hexString: "#000000") ], locations: [0,0.7])
        initialSetup()
        self.setTextFieldsDelegate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.contentView.setInitialAnimation(delegate: self)
    }
    
    func setTextFieldsDelegate(){
        self.firstNameField.delegate = self
        self.lastNameField.delegate = self
        self.emailField.delegate = self
        self.cityField.delegate = self
    }
    
    @objc func dismissController(){
        UIView.animate(withDuration: 0.3) {
            self.contentView.transform = CGAffineTransform(translationX: 0, y: self.contentView.frame.height)
        } completion: { isSucceed in
            self.dismiss(animated: false)
            
        }
    }
    func initialSetup(){
        saveButton.setTitle(AppStrings.save, for: .normal)
        contentView.backgroundColor = UIColor.black
        self.firstNameField.text = UserDefaultsCustom.getUserData()?.firstName
        self.firstNameField.textFieldDidChange()
        self.lastNameField.text = UserDefaultsCustom.getUserData()?.lastName
        self.lastNameField.textFieldDidChange()
        self.emailField.text = UserDefaultsCustom.getUserData()?.email
        self.emailField.textFieldDidChange()
        self.cityField.text = UserDefaultsCustom.getUserData()?.city
        self.cityField.textFieldDidChange()
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        self.presenter?.editProfileApiCall(updatedData: self.updatedData)
    }
}

extension EditProfileVC: SwipeableViewDelegate{
    func dismissView() {
        self.dismiss(animated: false)
    }
}

extension EditProfileVC: EditProfileViewProtocol{
    func successFullyUpdateProfile() {
        self.delegate?.editProfileSuccess()
        self.dismissController()
    }
    
    func receiveData() {
        
    }
}

extension EditProfileVC: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let rawString = string
        let range = rawString.rangeOfCharacter(from: .whitespaces)
        if ((textField.text?.count ?? 0) == 0 && range  != nil)
            || ((textField.text?.count ?? 0) > 0 && textField.text?.last  == " " && range != nil)  {
            return false
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case firstNameField:
            self.updatedData?.firstName = textField.text
        case lastNameField:
            self.updatedData?.lastName = textField.text
        case emailField:
            self.updatedData?.email = textField.text
        case cityField:
            self.updatedData?.city = textField.text
        default:
            break
        }
    }
    
}

