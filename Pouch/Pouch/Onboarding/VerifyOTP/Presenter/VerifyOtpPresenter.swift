//
//  VerifyOTPPresenter.swift
//  Pouch
//
//  Created by Raman choudhary on 15/02/23.
//

import UIKit

class VerifyOtpPresenter: VerifyOtpPresenterProtocol{
    
    
   
    
    
    var view: VerifyOtpViewProtocol?
    
    static func createVerifyOtpModule(phoneNo:String?) -> UIViewController{
        let vc =  VerifyOtpVC()
        var presenter: VerifyOtpPresenterProtocol = VerifyOtpPresenter()
        presenter.view = vc
        vc.presenter = presenter
        vc.mobileNumber = phoneNo
        return vc
    }
    
    func jsonToVarifyOtp(phoneNo:String?,otpStr:String?)-> JSON{
        var json = JSON()
        json["username"] = phoneNo
        json["otp"] = otpStr
        json["appVersion"] = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        json["fcmToken"] = UserDefaultsCustom.getDeviceToken()
        json["deviceId"] = ""
        return json
    }
    
    func verifyOtpApiCall(phoneNo:String?,otpStr:String?) {
        ApiHandler.call( apiName: API.Name.login_attempt, params: self.jsonToVarifyOtp(phoneNo: phoneNo, otpStr: otpStr), httpMethod:.POST) { (data:MessageResponse?, error) in
            DispatchQueue.main.async {
                guard let _ = data else {
                    Singleton.shared.showMessage(message: error ?? "", isError: .error)
                    return
                }
                UserDefaultsCustom.setValue(value: data?.response ?? "", for: UserDefaultsCustom.accessToken)
                Singleton.shared.gotoHome()
            }
        }
    }
    
    func resendOtpAction(phoneNo: String?) {
        let apiName = API.Name.login_Init + (phoneNo ?? "")
        ApiHandler.call(apiName: apiName, params: [:], httpMethod: .POST) { (data:MessageResponse?, error) in
            DispatchQueue.main.async {
                guard let _ = data else {
                    Singleton.shared.showMessage(message: error ?? "", isError: .error)
                    return
                }
                self.view?.resendOtpSucceed()
            }
        }
    }
    
    
}

