//
//  editProfilePresenter.swift
//  Pouch
//
//  Created by Piyush Kumar on 07/02/23.
//

import Foundation
import UIKit

class EditProfilePresenter: EditProfilePresenterProtocol {
    
    var view: EditProfileViewProtocol?
    var email:String?
    var firstName:String?
    var lastName:String?
    
    static func CreateEditProfileModule()->UIViewController{
             let view =  EditProfileVC()
                var presenter:EditProfilePresenterProtocol = EditProfilePresenter()
                view.presenter = presenter
                presenter.view = view
                return view
        }
    
    func validateFields() -> Bool {
        guard email != "" else {
            Singleton.shared.showErrorMessage(error: "Please enter your email.", isError: .error)
            return false
        }
        guard firstName != "" else {
            Singleton.shared.showErrorMessage(error: "Please enter first name.", isError: .error)
            return false
        }
        guard lastName != "" else {
            Singleton.shared.showErrorMessage(error: "Please enter last name.", isError: .error)
            return false
        }
        let isValidEmail = Validator.validateEmail(candidate: email ?? "")
        if isValidEmail == true {
            return isValidEmail
        }else {
            Singleton.shared.showErrorMessage(error: "Please enter valid email.", isError: .error)
            return isValidEmail
        }
        self.view?.receiveData()
    }
}
