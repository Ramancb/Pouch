//
//  ApiHandler.swift
//  CullintonsCustomer
//
//  Created by Rakesh Kumar on 03/04/18.
//  Copyright © 2018 Rakesh Kumar. All rights reserved.
//

import UIKit

class ApiHandler {
    
    static public func callWithoutParse(timeoutInterval: TimeInterval = 20, apiName: String, params: [String : Any] = [:], httpMethod: API.HttpMethod  = .GET, receivedResponse: @escaping (JSON) -> ())  {
        if IJReachability.isConnectedToNetwork() == true {
            HttpManager.requestToServer(apiName, params: params, httpMethod: httpMethod, isZipped: false, receivedResponse: { (isSucceeded, response, data) in
                DispatchQueue.main.async {
                    print("response:\(response)")
                    if(isSucceeded) {
                        if let status = response["success"] as? Int {
                            switch(status) {
                            case API.statusCodes.SHOW_DATA:
                                guard let result_data = data else{return}
                                do{
                                    guard let response = try JSONSerialization.jsonObject(with: result_data) as? JSON else{return}
                                    receivedResponse(response)
                                } catch {
                                    print(error)
                                }
                            case API.statusCodes.INVALID_ACCESS_TOKEN:
                                Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
                                Singleton.shared.logoutFromDevice()
                                receivedResponse(response)
                             default:
                                
                                if let message = response["error"] as? String {
                                    Singleton.shared.showErrorMessage(error: message, isError: .error)
                                    receivedResponse(response)
                                } else if  let message = response["message"] as? String {
                                    Singleton.shared.showErrorMessage(error: message, isError: .error)
                                    receivedResponse(response)
                                } else {
                                    Singleton.shared.showErrorMessage(error: AlertMessage.SERVER_NOT_RESPONDING, isError: .error)
                                    receivedResponse(response)
                                }
                            }
                        } else {
                            Singleton.shared.showErrorMessage(error: AlertMessage.SERVER_NOT_RESPONDING, isError: .error)
                            
                        }
                    } else {
                        Singleton.shared.showErrorMessage(error: AlertMessage.SERVER_NOT_RESPONDING, isError: .error)
                        print("apiName in case server not responding:  \(apiName)")
                        return
                        
                    }
                }
            })
        } else {
            Singleton.shared.showErrorMessage(error: AlertMessage.NO_INTERNET_CONNECTION, isError: .error)
        }
    }
    
    static public func call<T>(timeoutInterval: TimeInterval = 20, apiName: String, params: [String : Any] = [:], httpMethod: API.HttpMethod  = .GET, receivedResponse: @escaping (T?,String?) -> ()) where T: Codable {
        if IJReachability.isConnectedToNetwork() == true {
            HttpManager.requestToServer(apiName, params: params, httpMethod: httpMethod, isZipped: false, receivedResponse: { (isSucceeded, response, data) in
                DispatchQueue.main.async {
                    print("response:\(response)")
                    if(isSucceeded) {
                        if let status = response["success"] as? Int {
                            switch(status) {
                            case API.statusCodes.SHOW_DATA:
                                guard let result_data = data else{return}
                                do{
                                    let jsonResponse = try JSONDecoder().decode(T.self, from: result_data)
                                    receivedResponse(jsonResponse, nil)
                                } catch {
                                    print("error:\(error)")
                                    receivedResponse(nil, error.localizedDescription)
                                }
                            case API.statusCodes.INVALID_ACCESS_TOKEN:
                                Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
                                Singleton.shared.logoutFromDevice()
                                receivedResponse(nil, nil)
                             default:
                                
                                if let message = response["error"] as? String {
                                    receivedResponse(nil,message)
                                    Singleton.shared.showErrorMessage(error: message, isError: .error)
                                } else if  let message = response["message"] as? String {
                                    receivedResponse(nil,message)
                                } else {
                                    Singleton.shared.showErrorMessage(error: AlertMessage.SERVER_NOT_RESPONDING, isError: .error)
                                    receivedResponse(nil,AlertMessage.SERVER_NOT_RESPONDING)
                                }
                            }
                        } else {
                            Singleton.shared.showErrorMessage(error: AlertMessage.SERVER_NOT_RESPONDING, isError: .error)
                            receivedResponse(nil,AlertMessage.SERVER_NOT_RESPONDING)
                        }
                    } else {
                        Singleton.shared.showErrorMessage(error: AlertMessage.SERVER_NOT_RESPONDING, isError: .error)
                        print("apiName in case server not responding:  \(apiName)")
                        receivedResponse(nil,AlertMessage.SERVER_NOT_RESPONDING)
                    }
                }
            })
        } else {
            Singleton.shared.showErrorMessage(error: AlertMessage.NO_INTERNET_CONNECTION, isError: .error)
            receivedResponse(nil,AlertMessage.NO_INTERNET_CONNECTION)
        }
    }
    
//    class func call(apiName: String, params: [String : Any] = [:], httpMethod: API.HttpMethod  = .GET, receivedResponse: @escaping (SERVER_RESPONSE) -> ()) {
//        if IJReachability.isConnectedToNetwork() == true {
//            HttpManager.requestToServer(apiName, params: params, httpMethod: httpMethod, isZipped: false, receivedResponse: { (isSucceeded, response, data) in
//                DispatchQueue.main.async {
//                    print(response)
//                    if(isSucceeded) {
//                        if let status = response["statusCode"] as? Int {
//                            switch(status) {
//                            case API.statusCodes.SHOW_DATA:
//                                receivedResponse((true, response, data))
//                            case API.statusCodes.INVALID_ACCESS_TOKEN:
//                                Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
//                                Singleton.shared.logoutFromDevice()
//                                receivedResponse((success:false, response:[:], data:nil))
//                            default:
//                                if let message = response["message"] as? String {
//                                    receivedResponse((success:false, response:["statusCode":status, "message":message], data:nil))
//                                } else {
//                                    receivedResponse((success:false, response:["statusCode":status, "message":AlertMessage.SERVER_NOT_RESPONDING], data:nil))
//                                }
//                            }
//                        } else {
//                            receivedResponse((success:false, response: ["statusCode":0,"message":AlertMessage.SERVER_NOT_RESPONDING], data:nil))
//                        }
//                    } else {
//                        receivedResponse((success:false, response: ["statusCode":0, "message":AlertMessage.SERVER_NOT_RESPONDING], data: nil))
//                    }
//                }
//            })
//        } else {
//            receivedResponse((success:false, response: ["statusCode":0, "message":AlertMessage.NO_INTERNET_CONNECTION], data:nil))
//        }
//    }
    
    static public func uploadImage(apiName:String, imageArray:[UIImage]?, imageKey:String, params: [String : Any]?, isImage:Bool = true, receivedResponse: @escaping (_ succeeded:Bool, _ response:[String:Any], _ data:Data?) -> ()) {
        if IJReachability.isConnectedToNetwork() == true {
            HttpManager.uploadingMultipleTask(apiName, params: params, isImage: isImage, imageData: imageArray, imageKey: imageKey) { (isSucceeded, response, data) in
               
                DispatchQueue.main.async {
                    print(response)
                    if(isSucceeded){
                        if let status = response["success"] as? Int {
                            switch(status) {
                            case API.statusCodes.SHOW_DATA:
                                receivedResponse(true, response, data)
                            case API.statusCodes.INVALID_ACCESS_TOKEN:
                                
                                Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
                                Singleton.shared.gotoSplash()
                                receivedResponse(false, [:], nil)
                            default:
                                if let message = response["message"] as? String {
                                    receivedResponse(false, ["success":status, "message":message], nil)
                                } else {
                                    receivedResponse(false, ["success":status, "message":AlertMessage.SERVER_NOT_RESPONDING], nil)
                                }
                            }
                        } else {
                            receivedResponse(false, ["success":0,"message":AlertMessage.SERVER_NOT_RESPONDING], nil)
                        }
                    } else {
                        receivedResponse(false, ["success":0, "message":AlertMessage.SERVER_NOT_RESPONDING],nil)
                    }
                }
            }
        } else {
            receivedResponse(false, ["success":0, "message":AlertMessage.NO_INTERNET_CONNECTION], nil)
        }
        
    }
    
}
