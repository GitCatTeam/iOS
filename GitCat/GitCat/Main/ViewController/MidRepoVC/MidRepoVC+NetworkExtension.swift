//
//  MidRepoVC+NetworkExtension.swift
//  GitCat
//
//  Created by 조윤영 on 2020/06/20.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
import UIKit

extension MidRepoVC {
    func setCalendarCommitBackgroundColor(year:Int, month:Int, isFirst:Bool) {
        
        loadingBackgroundView.alpha = 1
        
        if (month<10) {
            selectedMonth = ("0" + String(month))
        }else{
            selectedMonth = String(month)
        }
        selectedYear = String(year)
        
        CommitCountService.sharedInstance.getCommit(month: "\(gsno(selectedYear))\(gsno(selectedMonth))") { (result) in
            switch result {
                
            case .networkSuccess(let data) :
                let detailData = data as? CommitCountModel
                self.commitCountDetailData = (data as? CommitCountModel)!
                
                if let resResult = detailData {
                    print("level1:\(self.gono(resResult.data?.commits?.level_1))")
                    self.commitLevel1 += resResult.data?.commits?.level_1 ?? []
                    self.commitLevel2 += resResult.data?.commits?.level_2 ?? []
                    self.commitLevel3 += resResult.data?.commits?.level_3 ?? []
                    
                    if(isFirst == true){
                        
                        if(self.commitCountDetailData.data?.detailCommits[self.formatter.string(from: Date())] != nil) {
                            self.noneCommitView.alpha = 0
                            self.tableView.alpha = 1

                            self.scoreLabel.text = "+\(self.gino(detailData?.data?.detailCommits[self.formatter.string(from: Date())]?.score))"
                            self.totalCommitLabel.text = "+\(self.gino(detailData?.data?.detailCommits[self.formatter.string(from: Date())]?.count))"
                            
                            let item = self.gsno(detailData?.data?.detailCommits[self.formatter.string(from: Date())]?.levelUp)
                            self.itemLabel.text = item
                            if(item == "") {
                                self.noneItem.alpha = 1
                                self.itemLabel.alpha = 0
                            }else {
                                self.noneItem.alpha = 0
                                self.itemLabel.alpha = 1
                            }
                    }else{
                        self.noneCommitView.alpha = 1
                        self.tableView.alpha = 0
                    }
                }
                self.setTodayColor(commitCount: self.gino(self.commitCountDetailData.data?.detailCommits[self.formatter.string(from: Date())]?.count))
                    
                self.calendar.reloadData()
                self.loadingBackgroundView.alpha = 0

            }
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
            case .maintainance:
               self.simpleAlert(title: "서버 점검", message: "더 나은 서비스를 위해                                          잠시 서버 점검 중입니다.")
                break
            case .networkFail :
                self.networkErrorAlert()
                self.loadingBackgroundView.alpha = 0
                
            default:
                self.simpleAlert(title: "오류 발생!", message: "다시 시도해주세요")
                self.loadingBackgroundView.alpha = 0
                break
            }
        }
    }
    
    
    //커밋내역 불러오기
    func setCommitData(date:String?) {
        debouncer.run {
            self.registerBackgroundTask()
            self.commits = []
            self.tableView.reloadData()
            
            self.loadingView2.alpha = 1
            CommitListService.sharedInstance.getCommitData(date: date!) { (result) in
                switch result {
                   
                case .networkSuccess(let data) :
                    
                    let detailData = data as? CommitListModel
                                    
                    if let resResult = detailData {
                        
                        self.commits = resResult.data?.commits ?? []
                        
                    }
                    self.tableView.reloadData()
                    self.loadingView2.alpha = 0
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
                    self.loadingView.alpha = 0
                    break
                default:
                    self.simpleAlert(title: "오류 발생!", message: "다시 시도해주세요")
                    self.loadingView.alpha = 0
                    break
                
                }
                
                if self.backgroundTask != .invalid {
                    self.endBackgroundTask()
                }
            }
        }
        
    }
    
    func loadData(year: Int, month: Int) {
        registerBackgroundTask()
        
        if (month<10) {
            selectedMonth = ("0" + String(month))
        }else{
            selectedMonth = String(month)
        }
        selectedYear = String(year)
    
        PostCalendarReloadService.shareInstance.postCalendarReload(date: "\(gsno(selectedYear))\(gsno(selectedMonth))") { (result) in
                switch result {
                    case .networkSuccess( _): //201
                        print("UserData POST SUCCESS")

                        self.setCalendarCommitBackgroundColor(year: year, month: month, isFirst:true)
                        let showCommitDate:String = self.formatter2.string(from: Date())
                        self.setCommitData(date: showCommitDate)
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

    func setTodayColor(commitCount:Int) {
        if(1 <= commitCount && commitCount <= 5) {
            calendar.appearance.todaySelectionColor = #colorLiteral(red: 0.8705882353, green: 0.9450980392, blue: 0.9882352941, alpha: 1)
        }else if(6 <= commitCount && commitCount <= 10){
            calendar.appearance.todaySelectionColor = #colorLiteral(red: 0.7294117647, green: 0.8784313725, blue: 0.968627451, alpha: 1)
        }else if(10 <= commitCount) {
            calendar.appearance.todaySelectionColor = #colorLiteral(red: 0.537254902, green: 0.8039215686, blue: 0.9647058824, alpha: 1)
        }else{
            calendar.appearance.todaySelectionColor = UIColor.white
        }
        
    }
    
    func setCurrentDayColor(commitCount:Int) {
        print(commitCount)
        
        if(1 <= commitCount && commitCount <= 5) {
            calendar.appearance.selectionColor = #colorLiteral(red: 0.8705882353, green: 0.9450980392, blue: 0.9882352941, alpha: 1)
        }else if(6 <= commitCount && commitCount <= 10){
            calendar.appearance.selectionColor = #colorLiteral(red: 0.7294117647, green: 0.8784313725, blue: 0.968627451, alpha: 1)
        }else if(10 <= commitCount) {
            calendar.appearance.selectionColor = #colorLiteral(red: 0.537254902, green: 0.8039215686, blue: 0.9647058824, alpha: 1)
        }else{
            calendar.appearance.selectionColor = UIColor.white
        }
        
    }
                
}
