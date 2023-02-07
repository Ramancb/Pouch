//
//  Protocol.swift
//  Pouch
//
//  Created by Piyush Kumar on 07/02/23.
//

import Foundation

protocol EditProfilePresenterProtocol{
  func validateFields() -> Bool
  var view: EditProfileViewProtocol? {get set}
}

protocol EditProfileViewProtocol{
    var presenter:EditProfilePresenterProtocol? { get set }
    func receiveData()
}
