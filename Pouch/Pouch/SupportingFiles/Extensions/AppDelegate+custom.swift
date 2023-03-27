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
    }
    
    func setBgNotification(_ application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
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
//    MARK: - Background Fetch Result
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) async -> UIBackgroundFetchResult {
        UIApplication.shared.applicationIconBadgeNumber = 100
        if let value = userInfo["some-key"] as? String {
              print("=======::",value) // output: "some-value"
            Singleton.shared.showErrorMessage(error: value, isError: .success)
           }
        return .newData
    }
    
    //MARK: - Forground push notification
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print(userInfo)
        /* ====Add action on notification =====
         let actionButton = UNNotificationAction(identifier: "TapToReadAction", title: "Tap to read", options: .foreground)
         let notificationCategory = UNNotificationCategory(identifier: "alarm", actions: [actionButton,deleteButton], intentIdentifiers: [])
         UNUserNotificationCenter.current().setNotificationCategories([notificationCategory])
         */
        completionHandler( [.alert, .badge, .sound])
    }
    
    //MARK: Background push notification Receive
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

}

//MARK: FCM TOKEN
extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(fcmToken)")
    }
}
