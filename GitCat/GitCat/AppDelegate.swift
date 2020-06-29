//
//  AppDelegate.swift
//  GitCat
//
//  Created by 조윤영 on 23/12/2019.
//  Copyright © 2019 조윤영. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //MARK - push alarm 허용 부분 - Notification
        // Override point for customization after application launch.
        let notificationCenter = UNUserNotificationCenter.current()

        notificationCenter.getNotificationSettings { (settings) in
            //User NotifyCation 센터를 가져온다
            let center = UNUserNotificationCenter.current()

            //사용 여부를 묻는다.
            center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                guard granted else {
                    UserDefaults.standard.set(false, forKey: "pushAlarm")
                    print("사용자가 push alarm을 허락하지 않았습니다.")
                    return
                }

                UserDefaults.standard.set(true, forKey: "pushAlarm")
                print("사용자가 push alarm을 허락했습니다.")

                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
        
        //MARK - 화면 이동.
        
        //로그인을 했다면,
        if(UserDefaults.standard.bool(forKey: "login")) {
            print("token:\(String(describing: UserDefaults.standard.string(forKey: "token")))")
            print("refreshToken:\(String(describing: UserDefaults.standard.string(forKey:"refreshToken")))")
             //window가 없으니 만들어준다.
            self.window = UIWindow(frame: UIScreen.main.bounds)

            // 스토리보드 인스턴스
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            // 뷰 컨트롤러 인스턴스
            let viewController = storyboard.instantiateViewController(withIdentifier: "UserDataInitVC")

            // 윈도우의 루트 뷰 컨트롤러 설정
            self.window?.rootViewController = viewController

            // 이제 화면에 보여주자.
            self.window?.makeKeyAndVisible()

        }else{
            //회원가입을 해야하거나 로그아웃했을 경우

            // window가 없으니 만들어준다.
            self.window = UIWindow(frame: UIScreen.main.bounds)

            // 스토리보드 인스턴스
            let storyboard = UIStoryboard(name: "Auth", bundle: nil)
            // 뷰 컨트롤러 인스턴스
            let viewController = storyboard.instantiateViewController(withIdentifier: "AuthInitiVC")

            // 윈도우의 루트 뷰 컨트롤러 설정
            self.window?.rootViewController = viewController

            // 이제 화면에 보여주자.
            self.window?.makeKeyAndVisible()

        }

        return true
        
    }
    
    //APNs 서버에 등록한 경우
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
         //token 값을 가지고 온다.
        let deviceTokenString = deviceToken.map { String(format: "%02x", $0) }.joined()

        //console에 token 값을 표시해 준다.
        print("APNs device token: \(deviceTokenString)")
        UserDefaults.standard.set(deviceTokenString, forKey: "deviceToken")
        print("device token:\(deviceTokenString)")
    }
    
    //APNs 서버에 등록하지 못한 경우, 오류를 표시.
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {

    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?)
    -> UIInterfaceOrientationMask {
            return [.portrait, .portraitUpsideDown]
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        //Background 상태로 전환될 경우 호출되는 함수.
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        //전원 절약을 위한 디바이스 화면 꺼짐 현상 제거
        if !UIApplication.shared.isIdleTimerDisabled {
            UIApplication.shared.isIdleTimerDisabled = true
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

