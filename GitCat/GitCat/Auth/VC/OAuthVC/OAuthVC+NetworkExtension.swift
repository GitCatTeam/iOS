//
//  OAuthVC+NetworkExtension.swift
//  GitCat
//
//  Created by 조윤영 on 2020/06/20.
//  Copyright © 2020 조윤영. All rights reserved.
//
import Foundation
import UIKit

extension OAuthVC {
    func postDeviceToken() {
        
        let deviceToken = UserDefaults.standard.string(forKey: "deviceToken") ?? ""
        UserDefaults.standard.set(UUID().uuidString, forKey: "UUID")
        let uuid = UserDefaults.standard.string(forKey: "UUID")
        
        let params : [String : Any] = [
            "deviceToken" : deviceToken ,
            "deviceId": uuid!
        ]
        
        PostDeviceTokenService.shareInstance.postDeviceToken(params: params) {(result) in
                switch result {
                case .networkSuccess( _): //201
                    print("Device Token POST SUCCESS")
                    break
                case .badRequest: //400
                    self.simpleAlert(title: "", message: "다시 시도해주세요")
                    break
                case .accessDenied: //401
                    self.simpleAlert(title: "", message: "권한이 없습니다.")
                    break
                case .maintainance: //419
                    //FIXME: 서버 점검 관련 Alert창 띄우기
                    self.simpleAlert(title: <#T##String#>, message: <#T##String#>)
                case .networkFail:
                    self.networkErrorAlert()
                    break
                default:
                    self.simpleAlert(title: "오류", message: "다시 시도해주세요")
                    break
            }
        }
    }
    
    func putAccess() {
        let params : [String : Any] = [:]

        PutAccessibilityService.shareInstance.putAccessibility(params: params) { (result) in
            switch result {
            case .networkSuccess( _): //200
                let dvc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "AuthInitiVC")
                
                dvc.modalPresentationStyle = .fullScreen
                self.present(dvc, animated: true, completion: nil)
                break

            case .accessDenied, .badRequest: //401(없는 사용자), 400(비번 불일치)
                self.simpleAlert(title: "회원가입 실패", message: "다시 시도해주세요.")
                break

            case .networkFail :
                self.networkErrorAlert()
                break

            default :
                self.simpleAlert(title: "오류", message: "다시 시도해주세요.")
                break
            }
        }
    }
}
