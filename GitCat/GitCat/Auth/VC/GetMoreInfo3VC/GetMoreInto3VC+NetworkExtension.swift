//
//  GetMoreInto3VC+NetworkExtension.swift
//  GitCat
//
//  Created by 조윤영 on 2020/06/20.
//  Copyright © 2020 조윤영. All rights reserved.
//
import UIKit

extension GetMoreInfo3VC {
    func putInfo(name: String, gender: String, birth:String, devCareer:String) {
        let params : [String : Any] = ["name" : name ,
                                       "gender" : gender ,
                                       "birth": birth ,
                                       "devCareer":devCareer ]

        PutAdditionalInfoService.shareInstance.putAdditionalInfo(params: params) { (result) in
            switch result {
            case .networkSuccess( _): //200
                let dvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "UserDataInitVC")
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