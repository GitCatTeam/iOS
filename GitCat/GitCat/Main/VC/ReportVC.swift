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
    
    let cellIdentifier = "ReportCVCell"
    var reportDataList = [ResultListDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.CustomColor.brownishGrey]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        loadingView.loadGif(name: "gif_loading2")
    }
    
    override func viewWillAppear(_ animated: Bool) {
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

        if let dvc = storyboard?.instantiateViewController(withIdentifier: "ReportDetailVC") as?ReportDetailVC {
            let report = reportDataList[indexPath.item]
            //네비게이션 컨트롤러를 이용하여 push를 해줍니다.
            dvc.reportTitle = report.title
            dvc.id = report.id
            dvc.totalCommit = report.totalCount
            navigationController?.pushViewController(dvc, animated: true)
            
        }
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
                }
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
