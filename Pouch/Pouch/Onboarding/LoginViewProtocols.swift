//
//  LoginViewProtocols.swift
//  Pouch
//
//  Created by Raman choudhary on 08/02/23.
//

import Foundation

protocol LoginPresenterProtocol{
  var view: LoginViewProtocol? {get set}
}

protocol LoginViewProtocol{
    var presenter:LoginPresenterProtocol? { get set }
}
