//
//  AppDelegate.swift
//  GitCat
//
//  Created by 조윤영 on 23/12/2019.
//  Copyright © 2019 조윤영. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.getNotificationSettings { (settings) in
            //User NotifyCation 센터를 가져온다
            let center = UNUserNotificationCenter.current()
            
            //사용 여부를 묻는다.
            center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                guard granted else {
                    print("사용자가 push alarm을 허락하지 않았습니다.")
                    return
                }
                
                print("사용자가 push alarm을 허락했습니다.")
                
                DispatchQueue.main.async {
                    
                    //APNs에 스마트폰을 등록하는 메소드. (네트워크)
                    UIApplication.shared.registerForRemoteNotifications()
                }
                
                
            }
        }
    
        return true
        
    }
    
    //APNs 서버에 등록한 경우
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
         //token 값을 가지고 온다.
        let deviceTokenString = deviceToken.map { String(format: "%02x", $0) }.joined()
        
        //console에 token 값을 표시해 준다.
        print("APNs device token: \(deviceTokenString)")
    }
    //APNs 서버에 등록하지 못한 경우, 오류를 표시.
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

