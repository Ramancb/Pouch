//
//  VerifyOTPPresenter.swift
//  Pouch
//
//  Created by Raman choudhary on 15/02/23.
//

import UIKit

class VerifyOtpPresenter: VerifyOtpPresenterProtocol{
    
    var view: VerifyOtpViewProtocol?
    
    /// Initialize view and presenter for verify otp module
    static func createVerifyOtpModule(phoneNo:String?) -> UIViewController{
        let vc =  VerifyOtpVC()
        var presenter: VerifyOtpPresenterProtocol = VerifyOtpPresenter()
        presenter.view = vc
        vc.presenter = presenter
        vc.mobileNumber = phoneNo
        return vc
    }
    
    /// create json for verify otp
    func jsonToVarifyOtp(phoneNo:String?,otpStr:String)-> JSON{
        var json = JSON()
        json["username"] = phoneNo
        json["otp"] = otpStr
        json["appVersion"] = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        json["fcmToken"] = UserDefaultsCustom.getDeviceToken()
        json["deviceId"] = Device_ID.getIDFA()
        return json
    }
    
    /// Verify otp api call
    func verifyOtpApiCall(phoneNo:String?,otpStr:String?) {
        guard let otpStr = otpStr else {
            Singleton.shared.showMessage(message: "Enter valid otp!", isError: .error)
            return
        }

        ApiHandler.call( apiName: API.Name.login_attempt, params: self.jsonToVarifyOtp(phoneNo: phoneNo, otpStr: otpStr), httpMethod:.POST) { (data:MessageResponse?, error) in
            DispatchQueue.main.async {
                guard let _ = data else {
                    Singleton.shared.showMessage(message: error ?? "", isError: .error)
                    return
                }
                UserDefaultsCustom.setValue(value: data?.response ?? "", for: UserDefaultsCustom.accessToken)
                Singleton.shared.gotoHome()
                self.updateFcmTocken()
            }
        }
    }
    
    func updateFcmTocken(){
        let json = [API.keys.fcmToken : UserDefaultsCustom.getDeviceToken()]
        ApiHandler.call(isShowIndicator:false, apiName: API.Name.profile_updatefcm, params: json, httpMethod: .PUT) { (data:MessageResponse?, error) in
            
        }
    }
    
    /// Resend otp api call
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

