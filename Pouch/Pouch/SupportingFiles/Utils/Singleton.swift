//
//  Singleton.swift
//  CullintonsCustomer
//
//  Created by Rakesh Kumar on 07/04/18.
//  Copyright © 2018 Rakesh Kumar. All rights reserved.
//

import UIKit

class Singleton: NSObject {
    
    static let shared = Singleton()
    var window  : UIWindow?
    //var address: [AddressListData] = []
    static var fromMenuNeedHelp:Bool = false
    static var coins:Int? = 0
    //static var userProfileData: UserProfileData?
    
    var keyboardSize: CGSize = CGSize(width: 0.0, height: 0.0)
    var errorMessageView: ErrorView!
    var callBackFromError: ((Bool?) -> Void)?
    static var storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

    
    override init() {
        super.init()
       // getAddressListing()
    }
    
//    public func getAddressListing() {
//        AddressApiModel.apiGetAddressList(userId: UserDefaultsCustom.getUserData()?._id, isBusinessAddress: false) { (listData) in
//            DispatchQueue.main.async {
//                self.address = listData.filter({$0.address_category != nil})
//            }
//        }
//    }
    
    func logoutFromDevice() {
//        DispatchQueue.main.async {
            OperationQueue.main.cancelAllOperations()
            UserDefaults.standard.removeObject(forKey: UserDefaultsCustom.accessToken)
            UserDefaults.standard.removeObject(forKey: UserDefaultsCustom.userData)
            NotificationCenter.default.removeObserver(self)
           // UserDefaults.setValue(value: true, for: "HaveSomeChatData")
           
//        }
    }
    
    
    
   
    
    //MARK: ERROR MESSAGE
    func showErrorMessage(error:String, isError: ERROR_TYPE) {
        DispatchQueue.main.async {
            guard let window = UIWindow.key else {return}
            if self.errorMessageView == nil {
                self.errorMessageView = UINib(nibName: NIB_NAME.errorView, bundle: nil).instantiate(withOwner: self, options: nil)[0] as? ErrorView
                self.errorMessageView.delegate = self
                self.errorMessageView.statusIconBgView.isHidden = true
                self.errorMessageView.frame = CGRect(x: 10, y: 43 , width: SCREEN_SIZE.width-20, height: HEIGHT.errorMessageHeight)
//    visibleController?.view.addSubview(errorMessageView)
                window.addSubview(self.errorMessageView)
            }
            self.errorMessageView.setErrorMessage(message: error, isError: isError)
        }
    }
    
//    func showErrorMessage(pushData: PushModel, isError: ERROR_TYPE, completionHandler:@escaping (_ pushData: PushModel?) -> ()) {
//        DispatchQueue.main.async {
//            guard let title = pushData.title else { return }
//
//            var message: String = ""
//            if pushData.pushType == .newChatMessage,
//               let name = pushData.name, name.count > 0 {
//                message = "\(name.capitalized)\n"
//            }
//            message += title
//
//            let window = Singleton.window
////            self.errorMessageView.errorMessage.numberOfLines = 3
//            if self.errorMessageView == nil {
//                self.errorMessageView = UINib(nibName: NIB_NAME.errorView, bundle: nil).instantiate(withOwner: self, options: nil)[0] as? ErrorView
//                self.errorMessageView.statusIcon.isHidden = false
//                self.errorMessageView.statusIcon.image = #imageLiteral(resourceName: "ic_close_popup")
//                self.errorMessageView.statusIcon.cornerRadius = 3
//                self.errorMessageView.statusIcon.clipsToBounds = true
//                self.errorMessageView.delegate = self
//                self.errorMessageView.pushData = pushData
//                self.errorMessageView.callBackFromError = { data in
//                    completionHandler(pushData)
//                }
//                self.errorMessageView.frame = CGRect(x: 10, y: HEIGHT.errorMessageHeight , width: SCREEN_SIZE.width-20, height: HEIGHT.errorMessageHeight)
//                window?.addSubview(self.errorMessageView)
//            }
//            self.errorMessageView.setErrorMessage(message: message, isError: isError)
//        }
//    }
    
    func translateErrorMessage(toBottom:Bool) {
        if errorMessageView != nil {
            if toBottom == true {
                self.errorMessageView.translateToBottom()
            } else {
                self.errorMessageView.translateToTop()
            }
        }
    }
    
    func gotoSplash() {
//        let vc = InitialWindowPresenter.createInitialWindowModule()
//        let navController = UINavigationController(rootViewController: vc)
//        navController.navigationBar.isHidden = true
//        window?.rootViewController = navController
//        window?.makeKeyAndVisible()
//        Singleton.shared.window = window
    }
    
//    func gotoLogin() {
//
//    }
    
    func gotoLogin() {
//        DispatchQueue.main.async {
//            var window: UIWindow?
//            let view = SetMobilePresenter.createSetMobileModule()
//            let navController = UINavigationController(rootViewController: view)
//            navController.navigationBar.isHidden = true
//            if #available(iOS 13, *) {
//                window = SceneDelegate.shared.window
//            } else {
//                window = AppDelegate.shared.window
//            }
//            window?.rootViewController = navController
//            Singleton.shared.window = window
//            window?.makeKeyAndVisible()
//        }
        
    }
    
    
}
    
    //static func getViewController() -> UIViewController? {
//        guard MenuVC.sideMenu != nil else {return nil}
//        if MenuVC.sideMenu.frontViewController is CustomTabController {
//            if let tabCon = MenuVC.homeTabController,
//               let navCon = tabCon.selectedViewController as? UINavigationController,
//               let currentCon = navCon.visibleViewController {
//                return currentCon
//            }
//        } else {
//            if let navVC = MenuVC.sideMenu.frontViewController as? AppNavigation {
//                return navVC.visibleViewController
//            }
//        }
        //return nil
    //}
    
//    static func pushToSearchController(_ controller: UIViewController, post:POST_TYPE) {
//        DispatchQueue.main.async {
//            let searchController = SearchController(filter: post)
//            controller.pushViewController(searchController, true)
//        }
//    }
    
//    class func presentShareController(_ controller: UIViewController, data: Data?, steps:Int = 0) {
//        DispatchQueue.main.async {
//            guard let data = data else {return}
//            let decoder = JSONDecoder()
//            do {
//                let responseData = try decoder.decode(CreateResponseModel.self, from: data)
//                guard let response = responseData.data else {return}
//                //let shareController = ShareQrCodeController()
//               // shareController.shareData = response
//                //shareController.modalPresentationStyle = .overFullScreen
//                controller.present(shareController, true)
//                shareController.didDismissController = {
//                    DispatchQueue.main.async {
//                        if steps == 0 {
//                            controller.popVC()
//                        } else {
//                            controller.popToBackSteps(steps: steps)
////                            controller.popVC()
//                        }
//                    }
//                }
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//    }
    
//    class func getMeetingData(userData: UserProfileData?) -> MeetingData {
//        let data = MeetingData()
//        data._id = userData?._id
//        data.invite_code = userData?.invite_code
//        data.title = userData?.name
//        data.post_type = .profile
//        return data
//    }
    
//    class func getMeetingData() -> MeetingData {
//        let userData = UserDefaultsCustom.getUserData()
//        let data = MeetingData()
//        data._id = userData?._id
//        data.invite_code = userData?.invite_code
//        data.title = userData?.name
//        data.post_type = .profile
//        return data
//    }
    
//    class func getMeetingData(_ homeData: HomeListData?) -> MeetingData {
//        let data = MeetingData()
//        data._id = homeData?._id
//        data.invite_code = homeData?.invite_code
//        data.title = homeData?.title
//        data.created_by = homeData?.created_by
//        data.post_type = .poll
//        return data
//    }
    
//}

extension Singleton: ErrorDelegate {
    //MARK: ERROR DELEGATE METHOD
    func removeErrorView() {
        if self.errorMessageView != nil {
            self.errorMessageView.removeFromSuperview()
            self.errorMessageView = nil
        }
    }
}

extension Singleton {
    
    static var is24Hours:Bool {
        get {
            return UserDefaults.valueFor(key: "is24Hours") as? Bool ?? false
        } set {
            return UserDefaults.setValue(value: newValue, for: "is24Hours")
        }
    }
    
}


// MARK: - Create Response Model
//class CreateResponseModel: Codable {
//    var statusCode: Int?
//    var message: String?
//    var data: CreateModelData?
//}

// MARK: - Create Model Data
//class CreateModelData: Codable {
//    var created_by, invite_code, post_id: String?
//    var post_type: POST_TYPE?
//    var title, user_name: String?
//}
