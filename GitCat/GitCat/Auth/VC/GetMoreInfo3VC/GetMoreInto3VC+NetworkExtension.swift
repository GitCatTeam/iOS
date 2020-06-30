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
            case .maintainance(let data)://419
                let maintainDateData = data as? MaintainanceModel
                if let resResult = maintainDateData {
                    let startTime = resResult.startTime
                    let endTime = resResult.endTime
                    self.simpleAlert(title: "서버 점검", message: "더 나은 서비스를 위해    잠시 서버 점검 중입니다.   \(String(describing: startTime))시 ~ \(String(describing: endTime))시까지 서버")
                }
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
