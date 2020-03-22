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
    
    
    @IBOutlet weak var titleLabel: CustomLabel!
    
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
    @IBOutlet weak var leaveCardView: UIView!
    
    
    @IBOutlet weak var todayCommitCountLabel: CustomLabel!
    @IBOutlet weak var todayCommitShowLabel: CustomLabel!
    
    @IBOutlet weak var catNameLabel: UILabel!
    @IBOutlet weak var todayScoreLabel: UILabel!
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var leftScoreLabel: UILabel!
    
    @IBOutlet weak var loadingView: UIImageView!
    @IBOutlet weak var loadingBackgroundView: UIView!
    
    @IBOutlet weak var todayScoreDescLabel: CustomLabel!
    @IBOutlet weak var leftScoreDescLabel: CustomLabel!
    @IBOutlet weak var itemLabel: CustomLabel!
    
    @IBOutlet weak var selectCatBtn: UIButton!
    
    @IBOutlet weak var bottomBoxBorder: UIImageView!
    @IBOutlet weak var bottomBox: UIView!
    
    @IBOutlet weak var catChatBox: UIImageView!
    
    @IBOutlet weak var graduateTitleLabel: CustomLabel!
    @IBOutlet weak var graduateSubTitle1: CustomLabel!
    @IBOutlet weak var graduateSubTitle2: CustomLabel!
    @IBOutlet weak var graduateCatLabel: CustomLabel!
    @IBOutlet weak var grduateSubTitle3: CustomLabel!
    @IBOutlet weak var graduateBtn: RoundBtn!
    
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemSubTitleLabel: CustomLabel!
    @IBOutlet weak var itemSubTitleLabel2: CustomLabel!
    @IBOutlet weak var itemTitleLabel3: CustomLabel!
    @IBOutlet weak var itemTitleLabel4: CustomLabel!
    
    
    @IBOutlet weak var leaveCardTitleLabel: CustomLabel!
    @IBOutlet weak var leaveSubTitle1: CustomLabel!
    @IBOutlet weak var leaveSubTitle2: CustomLabel!
    @IBOutlet weak var leaveSubTitle3: CustomLabel!
    @IBOutlet weak var leaveSubTitle4: CustomLabel!
    @IBOutlet weak var leaveSubTitle5: CustomLabel!
    @IBOutlet weak var leaveSubTitle6: CustomLabel!
    
    
    @IBOutlet weak var chatBoxLeadingConstraint: NSLayoutConstraint!
    
    let cellIdentifier = "TutorialCVCell"
    
    let chapterData:[String] = ["01","02","03","04"]
    
    let imageData:[UIImage] = [ UIImage(named: "imgTutorial1")!, UIImage(named: "imgTutorial2")!, UIImage(named: "imgTutorial3")!, UIImage(named: "imgTutorial4")!]

    let titleData:[String] = ["커밋으로 고양씨 성장시키기", "고양씨 졸업시키기", "달력과 리포트로 나의 개발 돌아보기", "튜토리얼 완료하고 고양이 받자!"]
    let content1Data:[String] = ["매일 꾸준히 커밋해보세요.", "4단계 고양씨는 졸업하게 되지만, 걱정 마세요!", "하단의 커밋달력을 통해 일일 커밋 현황을,", "어플 사용에 익숙해 지는 겸, 간단한 미션을 완료하면"]
    let content2Data:[String] = ["고양씨의 개발환경이 4단계에 걸쳐 개선됩니다.", "우측 상단의 수집 버튼을 통해 졸업앨범을 볼 수 있어요.", " 리포트를 통해 매달 개발 통계를 확인할 수 있어요.", "고양이 한 마리를 데려갈 수 있어요."]
    
    var mentsBox:[String] = []
    var mentPos = 0
    var timer = Timer()

    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBar()
        setAlpha()
        setHomeData()
        
        setItemCardBackgroundView()
        
        let isTutorialDone = UserDefaults.standard.bool(forKey: "tutorialDone")
        
        if(isTutorialDone == false){
            showTutorial()
        }
        
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
               
        if(height == 1366.0) {
            catChatLabel.alpha = 0
            catChatBox.alpha = 0
        }
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setStyle()
        setLabelFontSize()
    }

    
    @IBAction func checkGraduateAction(_ sender: Any) {
        cardBackgroundView.alpha = 0
        graduateCardView.alpha = 0
        
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
        
        
        let dvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "CatCollectionVC")
         dvc.modalPresentationStyle = .fullScreen

        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    
    @IBAction func leaveCloseAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.cardBackgroundView.alpha = 0
            self.leaveCardView.alpha = 0
        });
    }
    
    @IBAction func itemUpgradeCloseAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.cardBackgroundView.alpha = 0
            self.itemUpgradeCardView.alpha = 0
        });
    }
    
    @IBAction func graduateCloseAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.cardBackgroundView.alpha = 0
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
    
    @objc func fireTimer() {
        mentPos += 1
        self.catChatLabel.text = mentsBox[mentPos]

        if mentPos >= 7 {
            mentPos = -1
        }
    }
    
    func startTutorialAction() {
        UIView.animate(withDuration: 0.5, animations: {
            
            UserDefaults.standard.set(true, forKey: "tutorialDone")
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
    
    func setAlpha() {
        
        selectCatBtn.alpha = 0
        catCollectionArrow.alpha = 0
        catCollectionDescription.alpha = 0
        highlightView.alpha = 0
        
        reportArrow.alpha = 0
        commitCalendarArrow.alpha = 0
        commitReportDescription.alpha = 0
        
        cardBackgroundView.alpha = 0
        graduateCardView.alpha = 0
        itemUpgradeCardView.alpha = 0
        leaveCardView.alpha = 0
        
        OverlayView.alpha = 0
        
        loadingBackgroundView.alpha = 1
    }
    
    func setStyle() {
        highlightView.layer.borderWidth = 0
        
        graduateCardView.roundRadius(radius: 10)
        graduateCardView.customShadow(width: 1, height: 2, radius: 11, opacity: 0.16)
        itemUpgradeCardView.roundRadius(radius: 10)
        itemUpgradeCardView.customShadow(width: 1, height: 2, radius: 11, opacity: 0.16)
        
        loadingView.loadGif(name: "gif_loading2")
        
        selectCatBtn.layer.borderColor = UIColor.clear.cgColor
        selectCatBtn.circleRadius()
        selectCatBtn.customShadow(width: 1, height: 1, radius: 56.5, opacity: 0.1)
        catChatLabel.setLineHeight(lineHeight: 0.8)
        
        leaveCardView.roundRadius(radius: 10)
        leaveCardView.customShadow(width: 1, height: 1, radius: 56.5, opacity: 0.1)
        
    }
    
    func showTutorial(){
        
        OverlayView.alpha = 1
        setCardBackgorund()
    }
    
    func showGraduateCard() {
        cardBackgroundView.alpha = 1
        graduateCardView.alpha = 1
        setCardBackgorund()
    }
    
    func showItemUpgradeCard() {
        cardBackgroundView.alpha = 1
        itemUpgradeCardView.alpha = 1
        setCardBackgorund()
    }
    
    func showLeaveCard() {
        cardBackgroundView.alpha = 1
        leaveCardView.alpha = 1
        setCardBackgorund()
    }
    
    func setCardBackgorund() {
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
    }
    
    func setLabelFontSize() {
        titleLabel.dynamicFont(fontSize: 28, name: "BBTreeG_L")
        
        todayCommitCountLabel.dynamicFont(fontSize: 130, name: "NanumBaeEunHyeCe")
        todayCommitShowLabel.dynamicFont(fontSize: 35, name:"BBTreeG_L")
        catChatLabel.dynamicFont(fontSize: 20, name: "NanumBaeEunHyeCe")
        todayScoreDescLabel.dynamicFont(fontSize: 16, name:"BBTreeGo_R")
        todayScoreLabel.dynamicFont(fontSize: 28, name: "NanumBaeEunHyeCe")
        
        
        leftScoreDescLabel.dynamicFont(fontSize: 16, name:"BBTreeGo_R")
        leftScoreLabel.dynamicFont(fontSize: 28, name:"NanumBaeEunHyeCe")
        catNameLabel.dynamicFont(fontSize: 28, name:"NanumBaeEunHyeCe")
        itemLabel.dynamicFont(fontSize: 18, name:"NanumBaeEunHyeCe")
        selectCatBtn.titleLabel?.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        
        graduateTitleLabel.dynamicFont(fontSize: 20, name: "BBTreeG_B")
        graduateSubTitle1.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        graduateSubTitle2.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        grduateSubTitle3.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        graduateCatLabel.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        graduateBtn.titleLabel?.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        
        itemTitleLabel.dynamicFont(fontSize: 20, name: "BBTreeG_B")
        itemSubTitleLabel.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        itemSubTitleLabel2.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        itemTitleLabel3.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        itemTitleLabel4.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        
        
        leaveCardTitleLabel.dynamicFont(fontSize: 20, name: "BBTreeG_B")
        leaveSubTitle1.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        leaveSubTitle2.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        leaveSubTitle3.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        leaveSubTitle4.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        leaveSubTitle5.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        leaveSubTitle6.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        
        
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
        
        HomeService.sharedInstance.getHomeData { (result) in
            switch result {
                case .networkSuccess(let data) :
                    
                    let detailData = data as? HomeModel
                    
                    if let resResult = detailData {
                        self.todayCommitCountLabel.text = "\(resResult.data?.todayCommitCount ?? 0)"
                        self.todayScoreLabel.text = "\(resResult.data?.todayScore ?? 0)"
                        self.catNameLabel.text = resResult.data?.catName
                    if((resResult.data?.catImg?.contains("first"))!) {
                        self.chatBoxLeadingConstraint.constant = -20
                    }else if((resResult.data?.catImg?.contains("second"))! || (resResult.data?.catImg?.contains("third"))!) {
                        self.chatBoxLeadingConstraint.constant = -10
                        }


                        let url = URL(string: resResult.data?.catImg ?? "")

                        self.catImageView.kf.setImage(with: url)
                        self.itemLabel.text = "("+(resResult.data?.nextLevelStr ?? "")+")"
                        self.leftScoreLabel.text = "\(self.gino(resResult.data?.nextLevelScore))"
                        self.catChatLabel.text = resResult.data?.ments?[0]
                        self.mentsBox = resResult.data?.ments ?? []
                        
                        if(resResult.data!.isLevelUp!) {
                            self.showItemUpgradeCard()
                        }
                        if(resResult.data!.isGraduate!) {
                            self.showGraduateCard()
                        }
                        
                        if(resResult.data!.isLeave!) {
                            self.showLeaveCard()
                            self.catImageView.image = UIImage(named: "imgCatNull")
                            self.selectCatBtn.alpha = 1
                            
                            self.todayScoreLabel.text = "-"
                            self.bottomBox.alpha = 0
                            self.bottomBoxBorder.alpha = 0
                            self.catChatBox.alpha = 0
                            self.catChatLabel.alpha = 0
                            
                        }
                    }
                    
                    //let timer
                    
                    _ = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.fireTimer), userInfo: nil, repeats: true)
                    
                    
                    self.loadingView.alpha = 0
                    self.loadingBackgroundView.alpha = 0
                    break
                    
                case .networkFail :
                    self.networkErrorAlert()
                    self.loadingView.alpha = 0
                    self.loadingBackgroundView.alpha = 0
                    
                default:
                    self.simpleAlert(title: "오류 발생!", message: "다시 시도해주세요")
                    self.loadingView.alpha = 0
                    self.loadingBackgroundView.alpha = 0
                    break
                }
            }
        }
    
}


