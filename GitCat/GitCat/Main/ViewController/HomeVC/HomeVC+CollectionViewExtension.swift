//
//  HomeVC+CollectionViewExtension.swift
//  GitCat
//
//  Created by 조윤영 on 2020/06/20.
//  Copyright © 2020 조윤영. All rights reserved.
//
import UIKit

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? TutorialCVCell
        
        cell?.delegate = self
        
        cell?.tutorialImageView.image = self.imageData[indexPath.row]
        cell?.chapterNumberLabel.text = self.chapterData[indexPath.row]
        cell?.title.text = self.titleData[indexPath.row]
        cell?.content1.text = self.content1Data[indexPath.row]
        cell?.content2.text = self.content2Data[indexPath.row]
        
        if(indexPath.row == 3) {
            cell?.tutorialStartBtn.alpha = 1
            cell?.content1.alpha = 0
            cell?.content2.alpha = 0
        } else {
            cell?.content1.alpha = 1
            cell?.content2.alpha = 1
            cell?.tutorialStartBtn.alpha = 0
        }
        
        return cell!
    }
}

extension HomeVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 10
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left:0, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let page = Int(targetContentOffset.pointee.x / collectionView.frame.width)
        self.pageControl.currentPage = page
        
        let currentPosition = targetContentOffset.pointee.x
        if(currentPosition == 0.0) {
            catCollectionArrow.alpha = 0
            catCollectionDescription.alpha = 0
            highlightView.alpha = 0
            
            reportArrow.alpha = 0
            commitCalendarArrow.alpha = 0
            commitReportDescription.alpha = 0
            
            self.tabBarController?.tabBar.alpha = 0.5

        }
        else if(currentPosition == collectionView.frame.width) {


            if UIDevice.current.model.hasPrefix("iPad") {
                       
            }else{
                catCollectionArrow.alpha = 1
                catCollectionDescription.alpha = 1
                highlightView.alpha = 1
            }
            
            reportArrow.alpha = 0
            commitCalendarArrow.alpha = 0
            commitReportDescription.alpha = 0
            
            self.tabBarController?.tabBar.alpha = 0.5
        }
        else if(currentPosition == collectionView.frame.width*2) {
            catCollectionArrow.alpha = 0
            catCollectionDescription.alpha = 0
            highlightView.alpha = 0
            
            reportArrow.alpha = 1
            commitCalendarArrow.alpha = 1
            commitReportDescription.alpha = 1
            
            self.tabBarController?.tabBar.alpha = 1
            
        }
        else if(currentPosition == collectionView.frame.width*3) {
            catCollectionArrow.alpha = 0
            catCollectionDescription.alpha = 0
            highlightView.alpha = 0
            
            reportArrow.alpha = 0
            commitCalendarArrow.alpha = 0
            commitReportDescription.alpha = 0
            
            self.tabBarController?.tabBar.alpha = 0.5

        }
    }
}
