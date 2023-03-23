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
    
    static func CreateEditProfileModule(delegate:EditProfileVCDelegate?)->UIViewController{
        let view =  EditProfileVC()
        var presenter:EditProfilePresenterProtocol = EditProfilePresenter()
        view.presenter = presenter
        presenter.view = view
        view.delegate = delegate
        return view
    }
    
    func jsonToVerifyProfile(data:UserData?)-> JSON{
        var json = JSON()
        json["firstName"] = data?.firstName
        json["lastName"] = data?.lastName
        json["email"] = data?.email
        json["city"] = data?.city
        return json
    }
    
    func editProfileApiCall(updatedData:UserData?) {
        if validateFields(data: updatedData) == true{
            ApiHandler.call( apiName: API.Name.profile_update, params: self.jsonToVerifyProfile(data: updatedData), httpMethod:.PUT) { (data:MessageResponse?, error) in
                
                DispatchQueue.main.async {
                    guard let _ = data else {
                        Singleton.shared.showMessage(message: error ?? "", isError: .error)
                        return
                    }
                    DatabaseManager.shared.createOrUpdateDocumentForDb(_id: updatedData?.mobile ?? "", dbName: DatabaseManager.kProfileDBName, json: updatedData?.toJSON() ?? [:])
                    self.view?.successFullyUpdateProfile()
                }
            }
        }
    }
    
    func validateFields(data:UserData?) -> Bool {
        
        guard (data?.firstName?.count ?? 0) > 0 else {
            Singleton.shared.showErrorMessage(error: "Please enter first name.", isError: .error)
            return false
        }
        guard (data?.lastName?.count ?? 0) > 0 else {
            Singleton.shared.showErrorMessage(error: "Please enter last name.", isError: .error)
            return false
        }
        guard (data?.city?.count ?? 0) > 0 else {
            Singleton.shared.showErrorMessage(error: "Please enter city", isError: .error)
            return false
            
        }
        guard let email = data?.email, email.count > 0 else {
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
