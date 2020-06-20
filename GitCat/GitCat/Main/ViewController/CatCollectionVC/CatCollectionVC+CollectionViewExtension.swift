//
//  CatCollectionVC+CollectionViewExtension.swift
//  GitCat
//
//  Created by 조윤영 on 2020/06/20.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
import UIKit

extension CatCollectionVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catCollectionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CatCollectionCVCell
        
        cell?.catNameLabel.text = catCollectionList[indexPath.row].name
        cell?.resultLabel.text = catCollectionList[indexPath.row].endingMent
        
        let imageURL = catCollectionList[indexPath.row].img
        cell?.catImageView.setImage(imageURL, defaultImgPath: "imgDefault")
        
        if(catCollectionList[indexPath.row].isMedal == true) {
            cell?.medalImageView.alpha = 1
        }else {
            cell?.medalImageView.alpha = 0
        }
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (view.frame.width - 42) / 2
        let height: CGFloat = ((view.frame.width - 42) / 2) * 0.8 + 53
        
        if UIDevice.current.model.hasPrefix("iPad") {
            let width: CGFloat = (view.frame.width - 42) / 3 - 10
            let height: CGFloat = ((view.frame.width - 42) / 3) + 53
            return CGSize(width: width, height: height)
        }
        return CGSize(width: width, height: height)
    }
}
