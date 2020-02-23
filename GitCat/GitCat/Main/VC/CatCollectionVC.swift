//
//  CatCollectionVC.swift
//  GitCat
//
//  Created by 조윤영 on 20/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit

class CatCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellIdentifier:String = "catCollectionViewcell"
    var catDummyName:[String] = ["깜냥이","구냥이","윤냥이","안냥이","첫냥이","테디","코코"]
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setBackBtn(color: #colorLiteral(red: 0.5307495594, green: 0.8041878939, blue: 0.9690385461, alpha: 1))
        
        //TODO: navigation bar title 색 바꾸기
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 137/255, green: 204/255, blue: 246/255, alpha: 1)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let bar: UINavigationBar! = self.navigationController?.navigationBar
        bar.backgroundColor = UIColor.white
        
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catDummyName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CatCollectionCVCell
        
        cell.catNameLabel.text = catDummyName[indexPath.row]
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (view.frame.width - 42) / 2
        let height: CGFloat = ((view.frame.width - 42) / 2) * 0.8 + 53
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        }


}
