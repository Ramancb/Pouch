//
//  LoginViewProtocols.swift
//  Pouch
//
//  Created by Raman choudhary on 08/02/23.
//

import Foundation

protocol LoginPresenterProtocol{
  var view: LoginViewProtocol? {get set}
    func apiCallToLogin(phone_number:String?)
    func presentInformationScreen()
}

protocol LoginViewProtocol{
    var presenter:LoginPresenterProtocol? { get set }
    
}
