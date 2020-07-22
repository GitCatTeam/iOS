//
//  UserDataInitVC+NetworkExtension.swift
//  GitCat
//
//  Created by 조윤영 on 2020/06/20.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

extension UserDataInitVC {
    
    func postUserData() {
        registerBackgroundTask()

        PostUserDataService.shareInstance.postUserData { (result) in
            switch result {
            case .networkSuccess( _): //201
                print("UserData POST SUCCESS")
                let dvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "MainTabC")
                
                dvc.modalPresentationStyle = .fullScreen
                self.present(dvc, animated: true, completion: nil)
                    
                if self.backgroundTask != .invalid {
                    self.endBackgroundTask()
                }
                break
            case .maintainance:
                self.simpleAlert(title: "서버 점검", message: "더 나은 서비스를 위해                                          잠시 서버 점검 중입니다.")
                break
            case .badRequest: //400
                self.simpleAlert(title: "", message: "다시 시도해주세요")
                break
            
            case .accessDenied: //401
                self.refresh()
                break
                    
            case .networkFail:
                self.networkErrorAlert()
                break
                    
            default:
                self.simpleAlert(title: "오류", message: "다시 시도해주세요")
                break
            }
            if self.backgroundTask != .invalid {
                self.endBackgroundTask()
            }
        }
    }
    
    func refresh() {
        let getRefreshHeaders: HTTPHeaders = [
            "Authorization":UserDefaults.standard.string(forKey: "refreshToken")!
        ]
        registerBackgroundTask()
    
        RefreshJWTService.sharedInstance.getRefreshToken(headers: getRefreshHeaders) { (result) in
            switch result {
                case .networkSuccess(let data) :
                    let refreshData = data as? RefreshTokenModel
                    
                    if let resResult = refreshData {
                        UserDefaults.standard.set(resResult.data?.accessToken, forKey: "token")
                        UserDefaults.standard.set(resResult.data?.refreshToken, forKey: "refreshToken")
                    }
                    
                    defer {
                        self.cnt += 1
                        
                        if self.cnt == 3 {
                            let confirmModeAction = UIAlertAction(title: "확인", style: .default) { (action) in
                                UserDefaults.standard.set(false, forKey: "login")
                                let dvc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "AuthInitiVC")
                                dvc.modalPresentationStyle = .fullScreen
                                               
                                self.present(dvc, animated: true, completion: nil)
                             }
                                           
                            let alert = UIAlertController(title: "로그인 필요", message: "재로그인이 필요합니다", preferredStyle: UIAlertController.Style.alert)
                                           
                            alert.addAction(confirmModeAction)
                            self.present(alert, animated:true)
                        }else {
                            self.postUserData()
                        }
                    }
                break
            
            case .accessDenied:
                print("hi")
                let confirmModeAction = UIAlertAction(title: "확인", style: .default) { (action) in
                    UserDefaults.standard.set(false, forKey: "login")
                    let dvc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "AuthInitiVC")
                    dvc.modalPresentationStyle = .fullScreen
                    self.present(dvc, animated: true, completion: nil)
                }
                                   
                let alert = UIAlertController(title: "로그인 필요", message: "재로그인이 필요합니다", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(confirmModeAction)
                self.present(alert, animated:true)
                break
            
            case .dataNeeded:
                break
                
            case .networkFail :
                break
                                    
            default:
                break
            }
            
            if self.backgroundTask != .invalid {
                self.endBackgroundTask()
            }
        }
    }
    
    func registerBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask {
            [weak self] in self?.endBackgroundTask()
        }
        assert(backgroundTask != .invalid)
    }
    
    func endBackgroundTask() {
        print("Background task ended.")
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = .invalid
        
    }
}
