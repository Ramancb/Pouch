//
//  LoginViewPresenter.swift
//  Pouch
//
//  Created by Raman choudhary on 08/02/23.
//

import Foundation
import UIKit

class LoginPresenter: LoginPresenterProtocol{
    
    
    
    
    var view: LoginViewProtocol?
    
    static func createLoginModule() -> UIViewController{
        if let vc = UIStoryboard.rootController(identifier: "LoginVC") as? LoginVC{
            var presenter: LoginPresenterProtocol = LoginPresenter()
            presenter.view = vc
            vc.presenter = presenter
            return vc
        }
        return UIViewController()
    }
    
    func apiCallToLogin(phone_number: String?) {
        let validateField = Validator.validatePhoneNumber(number: phone_number)
        guard validateField.0 == true else{
            Singleton.shared.showMessage(message: validateField.1, isError: .error)
            return
        }
        let apiName = API.Name.login_Init + (phone_number ?? "")
        ApiHandler.call(apiName: apiName, params: [:], httpMethod: .POST) { (data:MessageResponse?, error) in
            DispatchQueue.main.async {
                guard let _ = data else {
                    Singleton.shared.showMessage(message: error ?? "", isError: .error)
                    return
                }
                self.redirectToVerifyOTP(number: phone_number)
            }
        }
        self.redirectToVerifyOTP(number: phone_number)
    }
    
    func presentInformationScreen() {
        let vc = InformationPresenter.createInformationModule()
            vc.modalPresentationStyle = .overFullScreen
        if let view = self.view as? LoginVC{
            view.present(vc, false)
        }
    }
    
    func redirectToVerifyOTP(number: String?){
        let controller = VerifyOtpPresenter.createVerifyOtpModule(phoneNo: number)
        if let view = self.view as? LoginVC{
            view.pushViewController(controller, true)
        }
    }
    
}
