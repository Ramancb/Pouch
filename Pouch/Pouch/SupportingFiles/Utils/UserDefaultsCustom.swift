//
//  UserDefaultsCustom.swift
//  CullintonsCustomer
//
//  Created by Rakesh Kumar on 04/04/18.
//  Copyright © 2018 Rakesh Kumar. All rights reserved.
//

import UIKit
import FirebaseMessaging
import ObjectMapper


struct UserDefaultsCustom {
    static let deviceToken = "deviceToken"
    static let accessToken = "accessToken"
    static let userData = "userData"
    
    static func getDeviceToken() -> String {
        let token = Messaging.messaging().fcmToken
        print("FCM token: \(token ?? "")")
        return token ?? deviceToken
    }
    
    static var firstTimeOpen: Bool {
        return UserDefaults.standard.value(forKey: "firstTimeOpen") == nil
    }
    
    static func setValue(value:Any?, for key:String) {
        UserDefaults.standard.setValue(value, forKey: key)
    }

    static func getAccessToken() -> String? {
        if let value = UserDefaults.standard.value(forKey: UserDefaultsCustom.accessToken) {
            return value as? String
        } else {
            return ""
        }
    }
    
    static func getValue(forKey: String) -> String? {
        if let value = UserDefaults.standard.value(forKey: forKey) {
            return value as? String
        }
        return nil
    }
    
    static func setValue(value: Any?, forKey:String) {
        UserDefaults.standard.setValue(value, forKey: forKey)
    }
    
    
    static func saveUserData(userData:UserData){

        if let jsonString = userData.toJSONString(prettyPrint: true) {
        //Store in UserDefaults
            UserDefaults.standard.set(jsonString, forKey: UserDefaultsCustom.userData)

        }
    }
    
    static func getUserData()->UserData?{
        if let dataInStr = UserDefaults.standard.value(forKey: UserDefaultsCustom.userData) as? String{
            if let dataObject = Mapper<UserData>().map(JSONString: dataInStr)  {
                return dataObject
            }else{
                return nil
            }
        }else{
            return nil
        }
    }
  
}
   
extension UserDefaults {
    class func setValue(value:Any?, for key:String) {
        UserDefaults.standard.setValue(value, forKey: key)
    }
    class func valueFor(key: String) -> Any? {
        return UserDefaults.standard.value(forKey: key)
    }
    
}
