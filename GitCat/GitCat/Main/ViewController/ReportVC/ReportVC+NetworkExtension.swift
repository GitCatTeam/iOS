//
//  ReportVC+NetworkExtension.swift
//  GitCat
//
//  Created by 조윤영 on 2020/06/20.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
import UIKit

extension ReportVC {
    func setReportList() {
        ReportListService.sharedInstance.getReportList { (result) in
            switch result {
            case .networkSuccess(let data):
                let reportData = data as? ReportListModel
                if let resResult = reportData {
                    self.reportDataList = resResult.data?.resultList ?? []
                    self.collectionView.reloadData()
                    self.loadingView.alpha = 0
                    
                    if(self.reportDataList.count == 0) {
                        print("뭐지?")
                        self.noDataImageView.alpha = 1
                    }else{
                        self.noDataImageView.alpha = 0
                    }
                }
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
            case .maintainance://503
                self.simpleAlert(title: "서버 점검", message: "더 나은 서비스를 위해                                          잠시 서버 점검 중입니다.")
                break
            case .networkFail :
                self.networkErrorAlert()
                self.loadingView.alpha = 0
            break
                    
            default:
                self.simpleAlert(title: "오류 발생!", message: "다시 시도해주세요")
                self.loadingView.alpha = 0
                break
             }
        }
    }
}
