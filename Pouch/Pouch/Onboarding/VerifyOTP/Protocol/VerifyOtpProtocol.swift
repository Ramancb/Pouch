//
//  VerifyOtpProtocol.swift
//  Pouch
//
//  Created by Raman choudhary on 15/02/23.
//

import Foundation


protocol VerifyOtpPresenterProtocol{
  var view: VerifyOtpViewProtocol? {get set}
    
    func verifyOtpApiCall(phoneNo:String?,otpStr:String?)
    func resendOtpAction(phoneNo:String?)
}

protocol VerifyOtpViewProtocol{
    var presenter:VerifyOtpPresenterProtocol? { get set }
    func resendOtpSucceed()
    
}
