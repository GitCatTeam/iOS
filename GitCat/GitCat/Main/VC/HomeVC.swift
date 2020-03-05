//
//  HomeVC.swift
//  GitCat
//
//  Created by 조윤영 on 30/12/2019.
//  Copyright © 2019 조윤영. All rights reserved.
//

import UIKit
import SwiftGifOrigin

class HomeVC: UIViewController, TutorialCellDelegate {
    
    func startTutorialAction() {
        UIView.animate(withDuration: 0.5, animations: {
            self.OverlayView.alpha = 0
            
            self.tabBarController?.tabBar.alpha = 1

            let tabBarControllerItems = self.tabBarController?.tabBar.items

            if let tabArray = tabBarControllerItems {
                let tabBarItem1 = tabArray[0]
                let tabBarItem3 = tabArray[2]

                tabBarItem1.isEnabled = true
                tabBarItem3.isEnabled = true
            
            }
            
            self.catCollectionBarItem.isEnabled = true
            self.settingBarItem.isEnabled = true
        });
        
    }
    
    @IBOutlet weak var catChatLabel: UILabel!

    @IBOutlet weak var OverlayView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var catCollectionBarItem: UIBarButtonItem!
    
    @IBOutlet weak var settingBarItem: UIBarButtonItem!
    
    @IBOutlet weak var catCollectionArrow: UIImageView!
    @IBOutlet weak var catCollectionDescription: CustomLabel!
    
    @IBOutlet weak var commitReportDescription: CustomLabel!
    @IBOutlet weak var commitCalendarArrow: UIImageView!
    @IBOutlet weak var reportArrow: UIImageView!
    
    @IBOutlet weak var highlightView: RoundView!
    
    @IBOutlet weak var cardBackgroundView: UIView!
    
    @IBOutlet weak var graduateCardView: UIView!
    @IBOutlet weak var itemUpgradeCardView: UIView!
    
    @IBOutlet weak var todayCommitCountLabel: CustomLabel!
    @IBOutlet weak var catNameLabel: UILabel!
    @IBOutlet weak var todayScoreLabel: UILabel!
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var leftScoreLabel: UILabel!
    

    let cellIdentifier = "TutorialCVCell"
    
    let chapterData:[String] = ["01","02","03","04"]
    let imageData:[UIImage] = [ UIImage(named: "imgTutorial1")!, UIImage(named: "imgTutorial2")!, UIImage(named: "imgTutorial3")!, UIImage(named: "imgTutorial4")!]

    let titleData:[String] = ["커밋으로 고양씨 성장시키기", "고양씨 졸업시키기", "달력과 레포트로 나의 개발 돌아보기", "튜토리얼 완료하고 고양이 받자!"]
    let content1Data:[String] = ["매일 꾸준히 커밋해보세요.", "4단계 고양씨는 졸업하게 되지만, 걱정 마세요!", "하단의 커밋달력을 통해 일일 커밋 현황을,", "어플 사용에 익숙해 지는 겸, 간단한 미션을 완료하면"]
    let content2Data:[String] = ["고양씨의 개발환경이 4단계에 걸쳐 개선됩니다.", "우측 상단의 수집 버튼을 통해 졸업앨범을 볼 수 있어요.", " 레포트를 통해 매달 개발 통계를 확인할 수 있어요.", "고양이 한 마리를 데려갈 수 있어요."]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBar()
        setHomeData()
        catChatLabel.setLineHeight(lineHeight: 0.8)
        setItemCardBackgroundView()
        setStyle()
    }
    
    func setStyle() {
        self.tabBarController?.tabBar.alpha = 0.5

        let tabBarControllerItems = self.tabBarController?.tabBar.items

        if let tabArray = tabBarControllerItems {
            let tabBarItem1 = tabArray[0]
            let tabBarItem3 = tabArray[2]

            tabBarItem1.isEnabled = false
            tabBarItem3.isEnabled = false
        }
               
        catCollectionBarItem.isEnabled = false
        settingBarItem.isEnabled = false
               
        catCollectionArrow.alpha = 0
        catCollectionDescription.alpha = 0
        highlightView.alpha = 0
        
        reportArrow.alpha = 0
        commitCalendarArrow.alpha = 0
        commitReportDescription.alpha = 0

        highlightView.layer.borderWidth = 0
        
        graduateCardView.alpha = 0
        graduateCardView.roundRadius()
        graduateCardView.customShadow(width: 1, height: 2, radius: 11, opacity: 0.16)
//        itemUpgradeCardView.alpha = 0
        itemUpgradeCardView.roundRadius()
        itemUpgradeCardView.customShadow(width: 1, height: 2, radius: 11, opacity: 0.16)
        
    }
    
    @IBAction func checkGraduateAction(_ sender: Any) {
        cardBackgroundView.alpha = 0
        graduateCardView.alpha = 0
        let dvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "CatCollectionVC")
         dvc.modalPresentationStyle = .fullScreen

        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    @IBAction func itemUpgradeCloseAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.itemUpgradeCardView.alpha = 0
        });
    }
    
    @IBAction func graduateCloseAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
        self.graduateCardView.alpha = 0
        });
    }
    
    @IBAction func closeCardViewAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.cardBackgroundView.alpha = 0
            
            self.tabBarController?.tabBar.alpha = 1

            let tabBarControllerItems = self.tabBarController?.tabBar.items

            if let tabArray = tabBarControllerItems {
                let tabBarItem1 = tabArray[0]
                let tabBarItem3 = tabArray[2]

                tabBarItem1.isEnabled = true
                tabBarItem3.isEnabled = true
            
            }
            
            self.catCollectionBarItem.isEnabled = true
            self.settingBarItem.isEnabled = true
        });
    }
    func setItemCardBackgroundView() {
        let tapGestRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(cardBackScreenTapAction(sender:)))
        cardBackgroundView.addGestureRecognizer(tapGestRecognizer1)
        let tapGestRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(itemBackScreenTapAction(sender:)))
        cardBackgroundView.addGestureRecognizer(tapGestRecognizer2)
        
    }
    
    @objc func cardBackScreenTapAction(sender: UITapGestureRecognizer) {
        hideBackgroundView()
        self.cardBackgroundView.alpha = 0
        
        
    }
    
    @objc func itemBackScreenTapAction(sender: UITapGestureRecognizer) {
        hideBackgroundView()
    }
    
    
    func hideBackgroundView() {

        UIView.animate(withDuration: 0.5, animations: {
            
            self.cardBackgroundView.alpha = 0
            self.navigationController?.navigationBar.layer.zPosition = 1
    
            self.tabBarController?.tabBar.alpha = 1
            self.navigationController?.navigationBar.alpha = 1
            
            let tabBarControllerItems = self.tabBarController?.tabBar.items
            
            if let tabArray = tabBarControllerItems {
                           let tabBarItem1 = tabArray[0]
                           let tabBarItem3 = tabArray[2]

                           tabBarItem1.isEnabled = true
                           tabBarItem3.isEnabled = true
                       
            }
                       
            self.catCollectionBarItem.isEnabled = true
            self.settingBarItem.isEnabled = true
            
        })
    }
    
}



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
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left:0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
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
        else if(currentPosition == 345.0) {
            
            catCollectionArrow.alpha = 1
            catCollectionDescription.alpha = 1
            highlightView.alpha = 1
            
            reportArrow.alpha = 0
            commitCalendarArrow.alpha = 0
            commitReportDescription.alpha = 0
            
            self.tabBarController?.tabBar.alpha = 0.5
        }
        else if(currentPosition == 690.0) {
            
            catCollectionArrow.alpha = 0
            catCollectionDescription.alpha = 0
            highlightView.alpha = 0
            
            reportArrow.alpha = 1
            commitCalendarArrow.alpha = 1
            commitReportDescription.alpha = 1
            
            self.tabBarController?.tabBar.alpha = 1
            
        }
        else if(currentPosition == 1035.0) {
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

extension HomeVC {
    func setHomeData() {
        
        HomeService.sharedInstance.getReportList { (result) in
            switch result {
                    
                    
                case .networkSuccess(let data) :
                    
                    let detailData = data as? HomeModel
                    
                    if let resResult = detailData {
                        self.todayCommitCountLabel.text = "\(resResult.data?.todayCommitCount ?? 0)"
                        self.todayScoreLabel.text = "\(resResult.data?.todayScore ?? 0)"
                        self.catNameLabel.text = resResult.data?.catName
                        let url = URL(string: resResult.data?.catImg ?? "")
                        self.catImageView.kf.setImage(with: url)
                    }
                    break
                    
                case .networkFail :
                    self.networkErrorAlert()
//                    self.loadingView.alpha = 0
//                    self.loadingBackgroundView.alpha = 0
                    
                default:
                    self.simpleAlert(title: "오류 발생!", message: "다시 시도해주세요")
//                    self.loadingView.alpha = 0
//                    self.loadingBackgroundView.alpha = 0
                    break
                }
            }
        }
    
}


