//
//  SettingVC+NetworkExtension.swift
//  GitCat
//
//  Created by 조윤영 on 2020/06/20.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
import UIKit

extension SettingVC {
    func postLogout() {
        PostLogoutService.shareInstance.postLogout(completion: { (result) in
            switch result {
                case .networkSuccess( _): //201
                    print("UserData POST SUCCESS")
                    
                    UserDefaults.standard.set(false, forKey: "login")
                    let dvc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "AuthInitiVC")
                    dvc.modalPresentationStyle = .fullScreen
                    
                    self.present(dvc, animated: true, completion: nil)
                    break
                    
                case .badRequest: //400
                    self.simpleAlert(title: "", message: "다시 시도해주세요")
                    break
                    
                case .accessDenied: //401
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
                    
                case .networkFail:
                    self.networkErrorAlert()
                    break
                    
                default:
                    self.simpleAlert(title: "오류", message: "다시 시도해주세요")
                    break
            }
        })
    }
    
    public func deleteDeviceToken() {
        DeleteTokenService.shareInstance.deleteToken { (result) in
            switch result {
            case .networkSuccess(_):
                 self.postLogout()
                break
            case .dataNeeded:
                break
            case .accessDenied:
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
            case .maintainance:
               self.simpleAlert(title: "서버 점검", message: "더 나은 서비스를 위해                                          잠시 서버 점검 중입니다.")
                break
            case .networkFail :
                self.networkErrorAlert()
                break
            default :
                self.simpleAlert(title: "오류", message: "다시 시도해주세요")
                break
            }
        }
    }
    func setCatInitialized() {
        DeleteCatService.shareInstance.deleteCat { (result) in
            switch result {
            case .networkSuccess(_):
                break
            case .dataNeeded:
                let dvc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "GetMoreInfo4VC")
                dvc.modalPresentationStyle = .fullScreen
                self.present(dvc, animated: true, completion: nil)
                break
            case .accessDenied:
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
           case .maintainance:
                self.simpleAlert(title: "서버 점검", message: "더 나은 서비스를 위해                                          잠시 서버 점검 중입니다.")
                break
            case .networkFail :
                self.networkErrorAlert()
                break
            default :
                self.simpleAlert(title: "오류", message: "다시 시도해주세요")
                break
            }
        }
    }
}
