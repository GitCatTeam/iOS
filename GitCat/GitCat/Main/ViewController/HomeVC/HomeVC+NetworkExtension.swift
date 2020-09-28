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
                    self.todayCommitCountLabel.text = "\(self.gino(resResult.data?.todayCommitCount))"
                    
                    let url = URL(string: self.gsno(resResult.data?.catImg))
                    self.catImageView.kf.setImage(with: url)
                    
                    self.currentLevelLabel.text = "Lv.\(self.gino(resResult.data?.currentLevel)) \(self.gsno(resResult.data?.currentItem)) | "
                    self.catNameLabel.text = self.gsno(resResult.data?.catName)
                    self.levelSliderView.value = Float(self.gino(resResult.data?.progressPer)) / 100

                    let currentLevel = self.gino(resResult.data?.currentLevel)
                    
                    if(currentLevel == 1) {
                        self.levelSliderView.sliderThumbImage = UIImage(named: "icPencil")
                    } else if(currentLevel == 2) {
                        self.levelSliderView.sliderThumbImage = UIImage(named: "icMac")
                    } else if(currentLevel == 3) {
                        self.levelSliderView.sliderThumbImage = UIImage(named: "icMacpro")
                    } else {
                        self.levelSliderView.sliderThumbImage = UIImage(named: "icGaugebarricon")
                    }
                    
                    self.scoreSumLabel.text = "총 \(self.gino(resResult.data?.totalScore))점을 획득했어요!"
                    self.todayScoreLabel.text = "(오늘 득점은 \(self.gino(resResult.data?.todayScore))점)"
                    self.nextItemLabel.text = "Lv.\(self.gino(resResult.data?.nextLevel)) \(self.gsno(resResult.data?.nextLevelItem))"
                    self.nextLevelLeftPointLabel.text = "이 되려면 \(self.gino(resResult.data?.nextLevelScore))점이 더 필요해요!"
                    self.graduateLeftPointLabel.text = "졸업까지 \(self.gino(resResult.data?.graduScore))점이 필요해요!"
                        
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
                    
//                    if(resResult.data?.ments?.count != 0 ) {
//                        self.timer.invalidate()
//                        self.timer = Timer.scheduledTimer(timeInterval: 8.0, target: self, selector: #selector(self.fireTimer), userInfo: nil, repeats: true)
//                    }
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
            case .maintainance:
               self.simpleAlert(title: "서버 점검", message: "더 나은 서비스를 위해                                          잠시 서버 점검 중입니다.")
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
