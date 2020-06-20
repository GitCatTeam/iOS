//
//  CatCollectionVC.swift
//  GitCat
//
//  Created by 조윤영 on 20/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit

class CatCollectionVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingBackgroundView: UIView!
    @IBOutlet weak var loadingView: UIImageView!
    @IBOutlet weak var noDataImageView: UIImageView!
    
    let cellIdentifier:String = "catCollectionViewcell"
    var catCollectionList = [CatCollectionDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCatCollection()
        setStyle()
        
    }
    
    func setStyle() {
        loadingBackgroundView.alpha = 1
        self.noDataImageView.alpha = 0
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 137/255, green: 204/255, blue: 246/255, alpha: 1)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let bar: UINavigationBar! = self.navigationController?.navigationBar
        bar.backgroundColor = UIColor.white
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        
    }
    
    @IBAction func goBackAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
