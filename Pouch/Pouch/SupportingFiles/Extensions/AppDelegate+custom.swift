//
//  AppDelegate+custom.swift
//  EGame
//
//  Created by apple on 13/05/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import FirebaseMessaging
import Firebase




//MARK: SET NOTIFICATION
extension AppDelegate {
    func setNotification(_ application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        onLaunchPushNotification(launchOptions: launchOptions)
    }
    
   
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        let token = deviceToken.reduce("") { $0 + String(format: "%02.2hhx", $1) }
        print("registered for notifications", token)
        print(Messaging.messaging().fcmToken)
        print("\(UserDefaultsCustom.getDeviceToken())")
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate{
    
    //    MARK: - Terminate app push notification receive
    func onLaunchPushNotification(launchOptions:[UIApplication.LaunchOptionsKey: Any]?){
        guard let dic = launchOptions?[.remoteNotification] as? [AnyHashable: Any] else{
            return
        }
//        UIApplication.shared.applicationIconBadgeNumber = 40
        print(dic)
        processNotificationData(json: dic)
    }
    
    func processNotificationData(json: [AnyHashable: Any]){
        if let json = json as? JSON{
            print("payLoadData:\(json)")
        }
    }
    
    //MARK: - Forground push notification receive
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        let dic = notification.request.content.userInfo
//        UIApplication.shared.applicationIconBadgeNumber = 10
        print(dic)
        processNotificationData(json: dic)
        if #available(iOS 14.0, *) {
            return [.badge,.sound,.banner]
        } else {
            return [.badge,.sound]
        }
    }
    
    //MARK: Background push notification Receive
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
//        UIApplication.shared.applicationIconBadgeNumber = 20
        let dic = response.notification.request.content.userInfo
        print(dic)
        processNotificationData(json: dic)
    }
    
    

}

extension AppDelegate: MessagingDelegate {
    //MARK: FCM TOKEN
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(fcmToken)")
    }
    
    //MARK: All common state payload access with firebase
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        UIApplication.shared.applicationIconBadgeNumber = 11
        print(userInfo)
        processNotificationData(json: userInfo)
        completionHandler(.newData)
    }
}
