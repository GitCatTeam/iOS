//
//  ReportVC.swift
//  GitCat
//
//  Created by 조윤영 on 09/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit

class ReportVC: UIViewController {
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
        self.loadingView.loadGif(name: "gif_loading2")
        
        self.noDataImageView.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.alpha = 1
        //MARK: 리포트 점검으로 인해 서버로 데이터 요청을 잠시 일시적으로 닫아둠.
//        setReportList()
        self.loadingView.alpha = 0
        self.noDataImageView.image = UIImage(named: "imgSorryreport01")
        self.noDataImageView.alpha = 1
    }
}
