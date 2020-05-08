//
//  ReportVC.swift
//  GitCat
//
//  Created by 조윤영 on 09/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit

class ReportVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingView: UIImageView!
    
    @IBOutlet weak var noDataImageView: UIImageView!
    
    let cellIdentifier = "ReportCVCell"
    var reportDataList = [ResultListDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.CustomColor.skyBlue]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.deleteNavigationUnderbar()
        loadingView.loadGif(name: "gif_loading2")
        noDataImageView.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.alpha = 1
        setReportList()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("count:\(reportDataList.count)")
         return reportDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ReportCVCell
        
        cell.mainTitle.text = reportDataList[indexPath.row].title
        cell.languageLabel.text = reportDataList[indexPath.row].mainLanguage
        cell.commitCountLabel.text = (reportDataList[indexPath.row].totalCount ?? "") + "회"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //375 641
        //345 124
        let cellWidth: CGFloat = collectionView.frame.width / 1.08
        let cellHeight: CGFloat = collectionView.frame.height / 5.17
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        print("hi")
        let dvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "ReportDetailNavVC")
        
        dvc.modalPresentationStyle = .fullScreen
        
        let report = reportDataList[indexPath.row]
        UserDefaults.standard.set(report.title, forKey:"reportTitle")
        UserDefaults.standard.set(report.id, forKey:"reportId")
        UserDefaults.standard.set(report.totalCount, forKey: "reportTotalCount")

        self.present(dvc, animated: true, completion: nil)

    }
}

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
