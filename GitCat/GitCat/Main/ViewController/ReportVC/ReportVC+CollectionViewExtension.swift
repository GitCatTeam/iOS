//
//  ReportVC+CollectionViewExtension.swift
//  GitCat
//
//  Created by 조윤영 on 2020/06/20.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
import UIKit

extension ReportVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reportDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ReportCVCell
           
        cell?.mainTitle.text = reportDataList[indexPath.row].title
        cell?.languageLabel.text = reportDataList[indexPath.row].mainLanguage
        cell?.commitCountLabel.text = (reportDataList[indexPath.row].totalCount ?? "") + "회"
           
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let cellWidth: CGFloat = collectionView.frame.width / 1.08
           let cellHeight: CGFloat = collectionView.frame.height / 5.17
           
           return CGSize(width: cellWidth, height: cellHeight)
       }

       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let dvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "ReportDetailNavVC")
           
           dvc.modalPresentationStyle = .fullScreen
           
           let report = reportDataList[indexPath.row]
           UserDefaults.standard.set(report.title, forKey:"reportTitle")
           UserDefaults.standard.set(report.id, forKey:"reportId")
           UserDefaults.standard.set(report.totalCount, forKey: "reportTotalCount")

           self.present(dvc, animated: true, completion: nil)
       }
}
