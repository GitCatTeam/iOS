//
//  CatCollcetionView+NetworkExtension.swift
//  GitCat
//
//  Created by 조윤영 on 2020/06/20.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
import UIKit

extension CatCollectionVC {
    func getCatCollection() {
        CatCollectionService.sharedInstance.getGraduateCats { (result) in
        switch result {
        case .networkSuccess(let data):
            let graduateCatData = data as? CatCollectionModel
            if let resResult = graduateCatData {
                self.catCollectionList = resResult.data ?? []
                self.collectionView.reloadData()
                self.loadingBackgroundView.alpha = 0
                
                if(self.catCollectionList.count == 0) {
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
            
        case .networkFail :
            self.networkErrorAlert()
            self.loadingBackgroundView.alpha = 0
            break
                                
        default:
            self.simpleAlert(title: "오류 발생!", message: "다시 시도해주세요")
            self.loadingBackgroundView.alpha = 0
            break
            }
        }
    }
}
