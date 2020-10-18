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
        self.navigationItem.title = "Report".localized()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.alpha = 1
        setReportList()
    }
}
