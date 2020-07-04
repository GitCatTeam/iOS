//
//  ReportDetailVC+NetworkExtension.swift
//  GitCat
//
//  Created by 조윤영 on 2020/06/20.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
import UIKit
import Charts

extension ReportDetailVC {
    func setReportDetailData(id:Int) {
        registerBackgroundTask()
        ReportDetailService.sharedInstance.getReportDetail(id: id) { (result) in
            switch result {
            case .networkSuccess(let data):
                let reportDetailData = data as? ReportDetailModel
                
                if let resResult = reportDetailData {
                    print("[\(String(describing: resResult.message))]")
                    
                    //comment
                    self.description1.text = resResult.data?.comment?[0]
                    self.description2.text = resResult.data?.comment?[1]
                    self.description3.text = resResult.data?.comment?[2]
      
                    //상위 수치 3개
                    self.averageCount.text = resResult.data?.avgCount
                    self.compareCount.text = "\(self.gsno(resResult.data?.comparedLastMonth))"
                    
                    //커밋수 통계 - Line Chart
                    self.days = resResult.data?.dailyCount?.dayArray  as! [String]
                    self.commitNumbers = resResult.data?.dailyCount?.countArray as! [Int]
                    
                    //사용 언어 비율 - Pie Chart
                    //PieChartDataEntry(value: 10)
                    let ratios:[Double] = resResult.data?.languageRatio?.percentArray as! [Double]
                    for ratio in ratios {
                        self.percentOfLanguageEntries += [PieChartDataEntry(value: ratio)]
                    }
                    
                    let resultLanguageList:[ResultLanguagesModel] = resResult.data?.languageRatio?.resultLanguages as! [ResultLanguagesModel]
                    
                    
                    if (resultLanguageList.count == 1) {
                        self.statusView1.alpha = 1
                        
                        self.statusLabel1.text = resultLanguageList[0].language
                        self.statusPercentLabel1.text = "\(self.gdno(resResult.data?.languageRatio?.percentArray[0]))%"
                        
                    }else if (resultLanguageList.count == 2) {
                        self.statusView1.alpha = 1
                        self.statusView2.alpha = 1
                        
                        self.statusLabel1.text = resultLanguageList[0].language
                        self.statusLabel2.text = resultLanguageList[1].language
                        
                        self.statusPercentLabel1.text = "\(self.gdno(resResult.data?.languageRatio?.percentArray[0]))%"
                        self.statusPercentLabel2.text = "\(self.gdno(resResult.data?.languageRatio?.percentArray[1]))%"
                        
                    }else if (resultLanguageList.count == 3) {
                        self.statusView1.alpha = 1
                        self.statusView2.alpha = 1
                        self.statusView3.alpha = 1
                        
                        self.statusLabel1.text = resultLanguageList[0].language
                        self.statusLabel2.text = resultLanguageList[1].language
                        self.statusLabel3.text = resultLanguageList[2].language
                        
                        self.statusPercentLabel1.text = "\(self.gdno(resResult.data?.languageRatio?.percentArray[0]))%"
                        self.statusPercentLabel2.text = "\(self.gdno(resResult.data?.languageRatio?.percentArray[1]))%"
                        self.statusPercentLabel3.text = "\(self.gdno(resResult.data?.languageRatio?.percentArray[2]))%"
                        
                    }else if (resultLanguageList.count == 4) {
                        self.statusView1.alpha = 1
                        self.statusView2.alpha = 1
                        self.statusView3.alpha = 1
                        self.statusView4.alpha = 1
                        
                        self.statusLabel1.text = resultLanguageList[0].language
                        self.statusLabel2.text = resultLanguageList[1].language
                        self.statusLabel3.text = resultLanguageList[2].language
                        self.statusLabel4.text = resultLanguageList[3].language
                        
                        self.statusPercentLabel1.text = "\(self.gdno(resResult.data?.languageRatio?.percentArray[0]))%"
                        self.statusPercentLabel2.text = "\(self.gdno(resResult.data?.languageRatio?.percentArray[1]))%"
                        self.statusPercentLabel3.text = "\(self.gdno(resResult.data?.languageRatio?.percentArray[2]))%"
                        self.statusPercentLabel4.text = "\(self.gdno(resResult.data?.languageRatio?.percentArray[3]))%"
                    }
                    
                    self.repositories = resResult.data?.contributedRepository?.repoNames as! [String]
                    self.repoCommits = resResult.data?.contributedRepository?.count as! [Double]

                    for i in 0..<self.repositories.count {
                        if(self.repositories[i].count > 10) {

                            let index = self.repositories[i].index(self.repositories[i].startIndex, offsetBy: 10)
                            self.repositories[i] = "\(self.repositories[i].substring(to: index)).."
                            print(self.repositories[i])
                        }
                    }
                    self.updateLineChartData()
                    self.updatePieChartData()
                    self.updateBarChartData()
                    
                    self.loadingView.alpha = 0
                    self.loadingBackgroundView.alpha = 0
                }
                break
            case .maintainance:
                self.simpleAlert(title: "서버 점검", message: "더 나은 서비스를 위해                                          잠시 서버 점검 중입니다.")
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
                
            case .networkFail:
                self.networkErrorAlert()
                self.loadingView.alpha = 0
                self.loadingBackgroundView.alpha = 0
                break
                
            default:
                self.simpleAlert(title: "오류 발생!", message: "다시 시도해주세요.")
                self.loadingView.alpha = 0
                self.loadingBackgroundView.alpha = 0
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

