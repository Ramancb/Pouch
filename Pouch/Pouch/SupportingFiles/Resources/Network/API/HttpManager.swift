//
//  HttpManager.swift
//  CullintonsCustomer
//
//  Created by Rakesh Kumar on 03/04/18.
//  Copyright © 2018 Rakesh Kumar. All rights reserved.
//

import UIKit


typealias SERVER_RESPONSE = (success:Bool, response:JSON, data:Data?)



class HttpManager: NSObject {
    
    static public func requestToServer(timeoutInterval: TimeInterval = 20,  _ url: String, params: [String:Any], httpMethod: API.HttpMethod, isZipped: Bool, receivedResponse:@escaping (_ succeeded: Bool, _ response: [String:Any], _ data: Data?) -> ()){
        var urlString = url
        if httpMethod == .GET, params.count > 0{
            urlString = urlString.query_params(params: params) ?? ""
        }else{
            urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        }
        guard let requestUrl = URL(string: API.host + urlString) else{return}
        var request = URLRequest(url: requestUrl )
        print(request.url?.absoluteString ?? "")
        print("param:\(params)")
        request.httpMethod = httpMethod.rawValue
        request.timeoutInterval = timeoutInterval
        let accessToken = UserDefaultsCustom.getAccessToken()
        if accessToken.count > 0 {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            print(accessToken)
        }
        if(httpMethod == API.HttpMethod.POST
            || httpMethod == API.HttpMethod.PUT
            || httpMethod == API.HttpMethod.DELETE) {
            request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
            if isZipped == false {
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            } else {
                request.addValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
                request.addValue("application/octet-stream", forHTTPHeaderField: "Content-Encoding: gzip")
            }
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        }
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            print("url resquest===\(request)")
            if(response != nil && data != nil) {
                do {
                    guard let urlResponse = response as? HTTPURLResponse else {
                        receivedResponse(false, [:], nil)
                        return
                    }
                            
                    guard urlResponse.statusCode != API.statusCodes.INVALID_ACCESS_TOKEN else {
                        Singleton.shared.showErrorMessage(error: AlertMessage.INVALID_ACCESS_TOKEN, isError: .error)
                        Singleton.shared.logoutFromDevice()
                        return
                    }
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any] {
                        receivedResponse(true, json, data)
                    } else {
                        let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                        // No error thrown, but not NSDictionary
                        print("Error could not parse JSON: \(jsonStr ?? "")")
                        receivedResponse(false, [:], nil)
                    }
                } catch let parseError {
                    print(parseError)
                    // Log the error thrown by `JSONObjectWithData`
                    let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print("Error could not parse JSON: '\(jsonStr ?? "")'")
                    receivedResponse(false, [:], nil)
                }
            } else {
                receivedResponse(false, [:], nil)
            }
        }
        task.resume()
    }
    
    static public func requestToServer(_ url: String, receivedResponse: @escaping (_ succeeded: Bool, _ data: Data?) -> ()) {
        guard let url = URL(string: url) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = API.HttpMethod.GET.rawValue
        request.timeoutInterval = 20
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            if(response != nil && data != nil) {
                receivedResponse(true, data)
            } else {
                receivedResponse(false, nil)
            }
        }
        task.resume()
    }

    static public func serverCall(_ url: String, params: [String:Any], httpMethod: API.HttpMethod, isZipped:Bool, receivedResponse:@escaping (_ succeeded:Bool, _ response:[String:Any],_ statusCode:Int) -> ()) {
        
        if IJReachability.isConnectedToNetwork() == true {
            HttpManager.requestToServer(url, params: params, httpMethod: httpMethod, isZipped: isZipped) { (success, response, data) in
                if success == true {
                    if let status = response["statusCode"] as? Int {
                        switch(status) {
                        case API.statusCodes.SHOW_DATA:
                            receivedResponse(true, response, status)
                        case API.statusCodes.INVALID_ACCESS_TOKEN:
                            if let message = response["customMessage"] as? String {
                                receivedResponse(true, ["statusCode":status, "customMessage": message], status)
                            } else {
                                receivedResponse(true, ["statusCode":status, "customMessage":ERROR_MESSAGE.INVALID_ACCESS_TOKEN], status)
                            }
//                        case STATUS_CODES.SHOW_MESSAGE:
//                            if let message = response["message"] as? String {
//                                receivedResponse(false, ["statusCode":status, "message":message], status)
//                            } else {
//                                receivedResponse(false, ["statusCode":status, "message":ERROR_MESSAGE.SERVER_NOT_RESPONDING], status)
//                            }
                        default:
                            if let message = response["message"] as? String {
                                receivedResponse(false, ["statusCode":status, "message":message], status)
                            } else {
                                receivedResponse(false, ["statusCode":status, "message":ERROR_MESSAGE.SOMETHING_WRONG], status)
                            }
                        }
                    } else {
                         receivedResponse(false, ["statusCode":0, "message":ERROR_MESSAGE.SOMETHING_WRONG], 0)
                    }
                } else {
                    receivedResponse(false, ["statusCode":0, "message":ERROR_MESSAGE.SOMETHING_WRONG], 0)
                }
            }
        } else {
            receivedResponse(false, ["statusCode":0, "message":ERROR_MESSAGE.NO_INTERNET_CONNECTION], 0)
        }
    }
    
    static public func uploadingMultipleTask(_ url:String, params: [String:Any]?, isImage:Bool, imageData:[UIImage]?, imageKey:String, receivedResponse: @escaping(_ succeeded:Bool, _ response:[String:Any], _ data:Data?) -> ()) {
        let boundary:NSString = "----WebKitFormBoundarycC4YiaUFwM44F6rT"
        let body:NSMutableData = NSMutableData()
        if let paramsArray = params?.keys{
            for item in paramsArray {
                body.append(("--\(boundary)\r\n" as String).data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                body.append("Content-Disposition: form-data; name=\"\(item)\"\r\n\r\n" .data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                body.append("\(params?[item]! ?? [:])\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            }
        }
        if(isImage) {
            for i in (0..<imageData!.count) {
                body.append(("--\(boundary)\r\n" as String).data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                
//                body.append("Content-Disposition: form-data; name=\"\(imageKey)\"; filename=\"photoName.png\"\r\n" .data(using: String.Encoding.utf8, allowLossyConversion: true)!)
//                body.append("Content-Type: image/png\r\n\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                if let image = imageData?[i] {
                    if let dataValue = image.jpegData(compressionQuality: 0.5) {
                        let fileExtension = Swime.mimeType(data: dataValue)!
                        
                        body.append("Content-Disposition: form-data; name=\"\(imageKey)\"; filename=\"fileName.\(fileExtension.ext)\"\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                        
                        body.append("Content-Type:\(fileExtension.mime)\r\n\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                        body.append(dataValue)
                    }
                }
                body.append("\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            }
        }
        
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
        let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        var request = URLRequest(url: URL(string: API.imageHost + urlString!)!)
        print(request.url?.absoluteString ?? "")
        request.httpMethod = "POST"
        request.httpBody = body as Data
        request.timeoutInterval = 60
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let accessToken = UserDefaultsCustom.getAccessToken()
        if accessToken.count > 0 {
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error -> Void in
            if(response != nil) {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? [String:Any] {
                        receivedResponse(true, json, data)
                    } else {
                        let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                        // No error thrown, but not NSDictionary
                        print("Error could not parse JSON: \(jsonStr ?? "")")
                        receivedResponse(false, [:], nil)
                    }
                } catch let parseError {
                    print(parseError)
                    // Log the error thrown by `JSONObjectWithData`
                    let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print("Error could not parse JSON: \(jsonStr ?? "")")
                    receivedResponse(false, [:], nil)
                }
            } else {
                receivedResponse(false, [:], nil)
            }
        })
        print("task.progress.fractionCompleted \(task.progress.fractionCompleted)")
        task.resume()
    }
    
    static public func uploadingDocuments(_ url: String, params: [String:Any], dataArray:[Data]?, dataKey: String, receivedResponse:@escaping (_ succeeded: Bool, _ response: [String:Any],_ data:Data?) -> ()) {
        let boundary: NSString = "----WebKitFormBoundarycC4YiaUFwM44F6rT"
        let body: NSMutableData = NSMutableData()
        let paramsArray = params.keys
        
        for item in paramsArray {
            body.append(("--\(boundary)\r\n" as String).data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            body.append("Content-Disposition: form-data; name=\"\(item)\"\r\n\r\n" .data(using: String.Encoding.utf8, allowLossyConversion: true)!)
            body.append("\(params[item]!)\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
        }
        
        if let dataArr = dataArray, !dataArr.isEmpty {
            dataArr.enumerated().forEach { (data) in
                body.append(("--\(boundary)\r\n" as String).data(using: String.Encoding.utf8, allowLossyConversion: true)!)
//                let fileExtension = data.element.fileType
                
                let fileExtension = Swime.mimeType(data: data.element)!
                
                body.append("Content-Disposition: form-data; name=\"\(dataKey)\"; filename=\"fileName.\(fileExtension.ext)\"\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                
                body.append("Content-Type:\(fileExtension.mime)\r\n\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                
                body.append(data.element)
                
                body.append("\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
                
                print("file extension \(fileExtension.mime) \(fileExtension.ext) \(fileExtension.type == .gif)")
            }
        }
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8, allowLossyConversion: true)!)
        let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        var request = URLRequest(url: URL(string: API.imageHost + urlString!)!)
        request.httpMethod = API.HttpMethod.POST.rawValue
        request.httpBody = body as Data
        request.timeoutInterval = 60
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let accessToken = UserDefaultsCustom.getAccessToken()
        if accessToken.count > 0 {
            request.setValue("Bearer \("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvd3d3LjIxYnk5MC5jb21cL2FwaVwvb3RwX3ZlcmlmaWNhdGlvbiIsImlhdCI6MTY1MDYxMzU3MCwiZXhwIjoxNzEwNjEzNTcwLCJuYmYiOjE2NTA2MTM1NzAsImp0aSI6ImJiVHNXb0tDYm9PaTMzcWEiLCJzdWIiOjEyLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.bXovsqeYyYKe9_VO4cJFgbdlmN4W_KTSzuWPrmKlz2A")", forHTTPHeaderField: "Authorization")
        }
        
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error -> Void in
            if(response != nil) {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? [String:Any] {
                        receivedResponse(true, json, data)
                    } else {
                        let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)    // No error thrown, but not NSDictionary
                        print("Error could not parse JSON: \(jsonStr ?? "")")
                        receivedResponse(false, [:], nil)
                    }
                } catch let parseError {
                    print(parseError)
                    // Log the error thrown by `JSONObjectWithData`
                    let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print("Error could not parse JSON: \(jsonStr ?? "")")
                    receivedResponse(false, [:], nil)
                }
            } else {
                receivedResponse(false, [:], nil)
            }
        })
        print("task progress **** \(task.progress.fractionCompleted)")
        task.resume()
    }
}


struct FileHeaderData {
    static var PNG: [UInt8] = [0x89]
    static var JPEG: [UInt8] = [0xFF]
    static var GIF: [UInt8] = [0x47]
    static var TIFF_01: [UInt8] = [0x49]
    static var TIFF_02: [UInt8] = [0x4D]
}
enum FileFormat {
    case Unknown, PNG, JPEG, GIF, TIFF
    
    var type: String {
        switch self {
        case .PNG: return "image/png"
        case .JPEG: return "image/jpeg"
        case .GIF: return "image/gif"
        case .TIFF: return "image/tiff"
        case .Unknown: return "image/unknown"
        }
    }
    
}
extension Data {
    var fileType: FileFormat {
        var buffer = [UInt8](repeating: 0, count: 1)
        copyBytes(to: &buffer, from: 0..<1)
        if buffer == FileHeaderData.PNG { return .PNG }
        if buffer == FileHeaderData.JPEG { return .JPEG }
        if buffer == FileHeaderData.GIF { return .GIF }
        if buffer == FileHeaderData.TIFF_01 ||
           buffer == FileHeaderData.TIFF_02 {
            return .TIFF
        }
        return .Unknown
    }
}



class DataDecoder: NSObject {
    
    public class func decode<T>(response: SERVER_RESPONSE, type: T.Type) -> T? where T : Decodable {
        if response.success == true {
            print(response)
            guard let data = response.data else { return nil }
            do {
                let decoder = JSONDecoder()
                let jsonResponse = try decoder.decode(type.self, from: data)
                return jsonResponse
            } catch let err {
                print("\n******* error to \(err)  *********\n")
                return nil
            }
        } else {
            if let message = response.response["message"] as? String {
                print("response.response[message] **** \(response.response)")
                Singleton.shared.showErrorMessage(error: message, isError: .error)
                
            } else if let message = response.response["msg"] as? String {
                print("response.response[msg] **** \(response.response)")
                Singleton.shared.showErrorMessage(error: message, isError: .error)
            }
            print("res **** \(response.response)")
            return nil
        }
    }
    
    
    public class func decode<T>(data: Data?, type: T.Type) -> T? where T : Decodable {
        guard let data = data else { return nil }
        do {
            let decoder = JSONDecoder()
            let jsonResponse = try decoder.decode(type.self, from: data)
            print("\n\n*********************    response decoded   *********************\n\n")
            return jsonResponse
        } catch let err {
            print("\n\n*********************    error to decode data \n\(err) \n\n")
            return nil
        }
    }
}
