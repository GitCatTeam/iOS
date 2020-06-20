//
//  HomeVC+NetworkExtension.swift
//  GitCat
//
//  Created by 조윤영 on 2020/06/20.
//  Copyright © 2020 조윤영. All rights reserved.
//
import Foundation
import UIKit

extension HomeVC {
    func setHomeData() {
        registerBackgroundTask()
        HomeService.sharedInstance.getHomeData { (result) in
            switch result {
            case .networkSuccess(let data) :
                let detailData = data as? HomeModel
                    
                if let resResult = detailData {
                        
                    self.todayCommitCountLabel.text = "\(resResult.data?.todayCommitCount ?? 0)"
                    self.todayScoreLabel.text = "\(resResult.data?.todayScore ?? 0)"
                    self.catNameLabel.text = resResult.data?.catName
                    

                    let url = URL(string: resResult.data?.catImg ?? "")


                    self.catImageView.kf.setImage(with: url)
                    
                    if((resResult.data?.catImg?.contains("first"))!) {
                        self.chatBoxLeadingConstraint.constant = 20
                    }else{
                        self.chatBoxLeadingConstraint.constant = 0
                    }

                    self.itemLabel.text = "("+(resResult.data?.nextLevelStr ?? "")+")"
                    self.leftScoreLabel.text = "\(self.gino(resResult.data?.nextLevelScore))"
                        
                    if(resResult.data?.ments?.count != 0) {
                        self.catChatLabel.text = resResult.data?.ments?[0]
                    }
                        
                    if(resResult.data?.ments?.count != 0) {
                        self.mentsBox = resResult.data?.ments ?? []
                    }

                    if(resResult.data!.isLevelUp!) {
                            
                        self.isCatItemUpgrade = true
  
                        self.itemTitleLabel3.text = "\(self.gsno(resResult.data?.catName))씨의 아이템이"
                        self.showItemUpgradeCard()
                    }
                    if(resResult.data!.isGraduate!) {
                        self.isCatGraduate = true
                            
                        self.graduateCatName.text = "\(self.gsno(resResult.data?.catName))씨가 졸업하게 되었어요."
                        self.showGraduateCard()
                        self.showSelectNewCat()
                    }
                        
                    if(resResult.data!.isLeave!) {
                            
                        self.isCatLeave = true
                            
                        self.showLeaveCard()
                        self.showSelectNewCat()
                    }
                    
                    if(resResult.data?.ments?.count != 0 ) {
                        self.timer.invalidate()
                        self.timer = Timer.scheduledTimer(timeInterval: 8.0, target: self, selector: #selector(self.fireTimer), userInfo: nil, repeats: true)
                    }
                }

                self.loadingView.alpha = 0
                self.loadingBackgroundView.alpha = 0
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
            case .dataNeeded:
                self.showSelectNewCat()
                self.loadingView.alpha = 0
                self.loadingBackgroundView.alpha = 0
                break
            case .networkFail :
                self.networkErrorAlert()
                self.loadingView.alpha = 0
                self.loadingBackgroundView.alpha = 0
                break
                    
            default:
                self.simpleAlert(title: "오류 발생!", message: "다시 시도해주세요")
                self.loadingView.alpha = 0
                self.loadingBackgroundView.alpha = 0
                break
            }
        }
        if self.backgroundTask != .invalid {
            self.endBackgroundTask()
        }
    }
    
    func loadData() {
        registerBackgroundTask()
        PostUserDataService.shareInstance.postUserData { (result) in
                switch result {
                    case .networkSuccess( _): //201
                        print("UserData POST SUCCESS")
                        
                        self.setHomeData()
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
        }
        
        if self.backgroundTask != .invalid {
            self.endBackgroundTask()
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
