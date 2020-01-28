//
//  ReportVC.swift
//  GitCat
//
//  Created by 조윤영 on 09/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit

class ReportVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{

    @IBOutlet weak var collectionView: UICollectionView!
    let cellIdentifier = "ReportCVCell"

    
    let reportInfo: [String] = ["1월 레포트", "2월 레포트","3월 레포트","4월 레포트","5월 레포트","6월 레포트","7월 레포트","8월 레포트"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return reportInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ReportCVCell
        cell.mainTitle.text = reportInfo[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if let dvc = storyboard?.instantiateViewController(withIdentifier: "ReportDetailVC") as? ReportDetailVC {


            //네비게이션 컨트롤러를 이용하여 push를 해줍니다.
            navigationController?.pushViewController(dvc, animated: true)
        }
            
    }


}
