//
//  Protocol.swift
//  Pouch
//
//  Created by Piyush Kumar on 07/02/23.
//

import Foundation

protocol EditProfilePresenterProtocol{
    func editProfileApiCall(firstName:String, lastName:String, email:String, city:String)
    func validateFields(firstName: String, email : String, lastName : String, city : String) -> Bool
    var view: EditProfileViewProtocol? {get set}
}

protocol EditProfileViewProtocol{
    var presenter:EditProfilePresenterProtocol? { get set }
    func receiveData()
}
