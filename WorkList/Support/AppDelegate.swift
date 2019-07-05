//
//  AppDelegate.swift
//  WorkList
//
//  Created by CuongVX-D1 on 6/26/19.
//  Copyright © 2019 CuongVX-D1. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
<<<<<<< HEAD
        
        FirebaseApp.configure()
        //  Bước 2: Cài Notification cho app
        //request Authorization:   yêu cầu ủy quyền
=======
        UNUserNotificationCenter.current().delegate = self
        FirebaseApp.configure()
>>>>>>> Complete Push Pull FireBase
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .badge, .alert]) { (success, error) in
            if error == nil {
                print("0 lỗi")
            } else {
                print("có lỗi")
            }
        }
        return true
    }
}

<<<<<<< HEAD





=======
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .alert, .badge])
    }
}
>>>>>>> Complete Push Pull FireBase
