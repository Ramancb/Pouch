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
    
    static func CreateEditProfileModule()->UIViewController{
        let view =  EditProfileVC()
        var presenter:EditProfilePresenterProtocol = EditProfilePresenter()
        view.presenter = presenter
        presenter.view = view
        return view
    }
    
    func jsonToVerifyProfile(firstName:String, lastName:String, email:String, city:String)-> JSON{
        var json = JSON()
        json["firstName"] = firstName
        json["lastName"] = lastName
        json["email"] = email
        json["city"] = city
        return json
    }
    
    func editProfileApiCall(firstName:String, lastName:String, email:String, city:String) {
        if validateFields(firstName: firstName , email : email , lastName : lastName , city: city ) == true{
            ApiHandler.call( apiName: API.Name.logout, params: self.jsonToVerifyProfile(firstName: firstName, lastName: lastName, email: email, city: city), httpMethod:.PUT) { (data:MessageResponse?, error) in
                DispatchQueue.main.async {
                    guard let _ = data else {
                        Singleton.shared.showMessage(message: error ?? "", isError: .error)
                        return
                    }
                }
            }
        }
    }
    
    func validateFields(firstName: String, email : String, lastName : String, city : String) -> Bool {
        
        guard firstName != "" else {
            Singleton.shared.showErrorMessage(error: "Please enter first name.", isError: .error)
            return false
        }
        guard lastName != "" else {
            Singleton.shared.showErrorMessage(error: "Please enter last name.", isError: .error)
            return false
        }
        guard city != "" else {
            Singleton.shared.showErrorMessage(error: "Please enter city", isError: .error)
            return false
            
        }
        guard email != "" else {
            Singleton.shared.showErrorMessage(error: "Please enter your email.", isError: .error)
            return false
        }
        let isValidEmail = Validator.validateEmail(candidate: email )
        if isValidEmail == true {
            return isValidEmail
        }else {
            Singleton.shared.showErrorMessage(error: "Please enter valid email.", isError: .error)
            return false
        }
       
    }
}
