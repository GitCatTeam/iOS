//
//  GetMoreInfo4VC+CollectionViewExtension.swift
//  GitCat
//
//  Created by 조윤영 on 2020/06/20.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit
import Foundation

extension GetMoreInfo4VC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == self.collectionView) {
            return currentCatList.count
        }
        
        if(collectionView == self.newCatCollectionView) {
            return newCatList.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == self.newCatCollectionView ) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier2, for: indexPath) as? NewCatCVCell
            let imageURL = gsno(self.newCatList[indexPath.row].profileImg)
            
            cell?.newCatImageView.setImage(imageURL, defaultImgPath: "imgDefault")
            cell?.newCatDescriptionLabel.text = gsno(newCatList[indexPath.row].description)
            
            if(indexPath.row == newCatList.count-1) {
                cell?.closedBtnImageView.alpha = 1
                cell?.closedBtn.alpha = 1
                
            } else {
                cell?.closedBtnImageView.alpha = 0
                cell?.closedBtn.alpha = 0
            }
            return cell!
        }
        
        //선택 고양이 리스트 셀 구현
        if(collectionView == self.collectionView) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? SelectCatCVCell
            
            //새로 지급된 고양이인지 판별
            if(currentCatList[indexPath.row].isNew == true) {
                cell?.NewBadgeView.alpha = 1
            } else {
                cell?.NewBadgeView.alpha = 0
            }
            
            let imageURL = gsno(currentCatList[indexPath.row].profileImg)
            cell?.catImageView.setImage(imageURL, defaultImgPath: "imgDefault")

            return cell!
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == self.newCatCollectionView) {
            let cellWidth: CGFloat = newCatCollectionView.frame.width - 20
            let cellHeight: CGFloat = newCatCollectionView.frame.height - 10
    
            return CGSize(width: cellWidth, height: cellHeight)
        }
        
        if(collectionView == self.collectionView) {
            let cellWidth: CGFloat = collectionView.frame.width / 3.4 - 1
            let cellHeight: CGFloat = collectionView.frame.height / 3.15 - 1
        
            return CGSize(width: cellWidth, height: cellHeight)
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if(collectionView == self.newCatCollectionView) {
            return UIEdgeInsets(top: 0, left:0, bottom: 0, right:0)
        }
        
        return UIEdgeInsets(top: 14.2, left:12, bottom: 14.2, right: 13)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == self.collectionView ) {
            
            
            if(currentCatList[indexPath.row].isAvailable! != false) {
                let selectedCell:SelectCatCVCell = collectionView.cellForItem(at: indexPath)! as! SelectCatCVCell
                selectedCell.roundView.layer.borderColor = #colorLiteral(red: 0.4652857184, green: 0.8005116582, blue: 0.9823767543, alpha: 1)
                catId = gino(currentCatList[indexPath.row].id)
                
                showCatNameTextField()
                
                if(!isClicked) {
                    isClicked = true
                    UIView.animate(withDuration: 0.5, animations: ({
                        self.topConstraint.constant -= 50
                    }))
                }
 
            } else {
            
                alertSubTitleLabel.text = gsno(currentCatList[indexPath.row].description)
               
                let imageURL = gsno(self.currentCatList[indexPath.row].profileImg)
                hiddenCatImageView.setImage(imageURL, defaultImgPath: "imgDefault")
                
                showAlertView()
                
                let cell:SelectCatCVCell = collectionView.cellForItem(at: indexPath)! as! SelectCatCVCell
                cell.isSelected = false
                
                dismissCatNameTextField()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if(collectionView == self.collectionView ) {
            
            let cellToDeselect:SelectCatCVCell = collectionView.cellForItem(at: indexPath)! as! SelectCatCVCell
            cellToDeselect.roundView.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let page = Int(targetContentOffset.pointee.x / (newCatCollectionView.frame.width-12))
        self.pageControl.currentPage = page
    }
}
