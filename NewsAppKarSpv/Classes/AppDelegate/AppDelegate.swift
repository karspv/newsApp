//
//  AppDelegate.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-03-01.
//

import UIKit
import Firebase
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        updateApplicationLaunchCount()
        setupAppAppearance()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        //self.window?.rootViewController = ApplicationTabBarViewController()
        self.window?.rootViewController = UIHostingController(rootView: HomeTabView())

        self.window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        initialisePushNotifications(application: application)
        
        return true
    }
}

extension AppDelegate: MessagingDelegate {
    
    /// Comment: This method registers our token to our project's back-end
    /// It's also important to invalidate the token when it's no longer needed
    /// We can put these methods to pushNotificatiions dataModel because it's part of API
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func initialisePushNotifications(application: UIApplication) {
        Messaging.messaging().delegate = self
        
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in })
        
        application.registerForRemoteNotifications()
    }
    
    /// Foreground notifications
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let _ = notification.request.content.userInfo
        completionHandler([[.alert, .sound]])
    }
    
    /// Background notifications
    /// Receiving a background notifications wakes up the application to update any data (it doesn't open the application)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let _ = response.notification.request.content.userInfo
        completionHandler()
        /// This is where you handle what happends when user tapps on notification
    }
}
