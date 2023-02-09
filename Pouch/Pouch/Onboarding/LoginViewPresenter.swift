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
    
}
