//
//  OAuthVC+NetworkExtension.swift
//  GitCat
//
//  Created by 조윤영 on 2020/06/20.
//  Copyright © 2020 조윤영. All rights reserved.
//
import Foundation

extension OAuthVC {
    func postDeviceToken() {
        
        let deviceToken = UserDefaults.standard.string(forKey: "deviceToken") ?? ""
        UserDefaults.standard.set(UUID().uuidString, forKey: "UUID")
        let uuid = UserDefaults.standard.string(forKey: "UUID")
        
        let params : [String : Any] = [
            "deviceToken" : deviceToken ,
            "os" : "iOS",
            "deviceId": uuid!
        ]
        
        PostDeviceTokenService.shareInstance.postDeviceToken(params: params) {(result) in
                switch result {
                case .networkSuccess( _): //201
                    print("Device Token POST SUCCESS")
                    break
                    
                //FIXME: 수정
                case .badRequest: //400
                    self.simpleAlert(title: "", message: "다시 시도해주세요")
                    break
                    
                case .accessDenied: //401
                    
                    self.simpleAlert(title: "", message: "권한이 없습니다.")
                    break
                    
                case .networkFail:
                    self.networkErrorAlert()
                    break
                    
                default:
                    self.simpleAlert(title: "오류", message: "다시 시도해주세요")
                    break
            }
        }
    }
}
