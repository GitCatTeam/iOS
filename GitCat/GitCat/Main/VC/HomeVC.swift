//
//  HomeVC.swift
//  GitCat
//
//  Created by 조윤영 on 30/12/2019.
//  Copyright © 2019 조윤영. All rights reserved.
//

import UIKit


class HomeVC: UIViewController, TutorialCellDelegate {
    
    
    @IBOutlet weak var titleLabel: CustomLabel!
    
    @IBOutlet weak var catChatLabel: UILabel!

    @IBOutlet weak var OverlayView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var catCollectionBarItem: UIBarButtonItem!
    
    @IBOutlet weak var settingBarItem: UIBarButtonItem!
    @IBOutlet weak var refreshBarItem: UIBarButtonItem!
    
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
    @IBOutlet weak var graduateBtn: RoundBtn!
    @IBOutlet weak var graduateCatName: UILabel!
    
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemSubTitleLabel: CustomLabel!
    @IBOutlet weak var itemSubTitleLabel2: CustomLabel!
    @IBOutlet weak var itemTitleLabel3: CustomLabel!
    
    
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
    
    let imageData:[UIImage] = [ UIImage(named: "imgTutorial1")!, UIImage(named: "imgTutorial2")!, UIImage(named: "img_tutorial3")!, UIImage(named: "imgTutorial4")!]

    let titleData:[String] = ["커밋으로 고양씨 성장시키기", "고양씨 졸업시키기", "달력과 리포트로 나의 개발 돌아보기", "튜토리얼 완료하고 고양이 받자!"]
    let content1Data:[String] = ["매일 꾸준히 커밋해보세요.", "4단계 고양씨는 졸업하게 되지만, 걱정 마세요!", "하단의 커밋달력을 통해 일일 커밋 현황을,", "어플 사용에 익숙해 지는 겸, 간단한 미션을 완료하면"]
    let content2Data:[String] = ["고양씨의 개발환경이 4단계에 걸쳐 개선됩니다.", "우측 상단의 수집 버튼을 통해 졸업앨범을 볼 수 있어요.", " 리포트를 통해 매달 개발 통계를 확인할 수 있어요.", "고양이 한 마리를 데려갈 수 있어요."]
    
    var mentsBox:[String] = ["안냥"]
    var mentPos = 0
    var timer = Timer()

    var count = 0
    var isCatGraduate:Bool = false
    var isCatItemUpgrade:Bool = false
    var isCatLeave:Bool = false

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
        

        
        if UIDevice.current.model.hasPrefix("iPad") {
            catChatLabel.alpha = 0
            catChatBox.alpha = 0
        }

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.tabBar.alpha = 1
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
        self.refreshBarItem.isEnabled = true
        
        
        let dvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "CatCollectionVC")
         dvc.modalPresentationStyle = .fullScreen

        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    
    @IBAction func leaveCloseAction(_ sender: Any) {
        isCatLeave = false
        
        UIView.animate(withDuration: 0.5, animations: {
             self.itemUpgradeCardView.alpha = 0
         })

         if(self.isCatGraduate == false && self.isCatItemUpgrade == false) {
             dismissCardBackground()
         }
        
    }
    
    @IBAction func itemUpgradeCloseAction(_ sender: Any) {
        isCatItemUpgrade = false
        
        UIView.animate(withDuration: 0.5, animations: {
            self.itemUpgradeCardView.alpha = 0
        })

        if(self.isCatGraduate == false && self.isCatLeave == false) {
            dismissCardBackground()
        }
       
    }
    
    @IBAction func graduateCloseAction(_ sender: Any) {
        isCatGraduate = false
        
        UIView.animate(withDuration: 0.5, animations: {
            self.itemUpgradeCardView.alpha = 0
        })

        if(self.isCatItemUpgrade == false && self.isCatLeave == false) {
            dismissCardBackground()
        }
    }

    @IBAction func refreshDataAction(_ sender: Any) {
        print("refresh")
        self.loadingView.alpha = 1
        self.loadingBackgroundView.alpha = 1
        loadData()
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

            self.tabBarController?.tabBar.isUserInteractionEnabled = true
            
            self.catCollectionBarItem.isEnabled = true
            self.settingBarItem.isEnabled = true
            self.refreshBarItem.isEnabled = true

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
        highlightView.circleRadius()
        
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
    func showSelectNewCat() {
        self.catImageView.image = UIImage(named: "imgCatNull")
        self.selectCatBtn.alpha = 1
        
        self.todayScoreLabel.text = "-"
        self.bottomBox.alpha = 0
        self.bottomBoxBorder.alpha = 0
        self.catChatBox.alpha = 0
        self.catChatLabel.alpha = 0
        
    }
    @IBAction func gotoSelectCatViewAction(_ sender: Any) {
        //present
        let dvc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "GetMoreInfo4VC")
        dvc.modalPresentationStyle = .fullScreen
        self.present(dvc, animated: true, completion: nil)
        
    }
    
    
    func setCardBackgorund() {
        self.tabBarController?.tabBar.alpha = 0.5

        tabBarController?.tabBar.isUserInteractionEnabled = false

        catCollectionBarItem.isEnabled = false
        settingBarItem.isEnabled = false
        refreshBarItem.isEnabled = false

    }
    
    func dismissCardBackground() {
        self.tabBarController?.tabBar.alpha = 0

        tabBarController?.tabBar.isUserInteractionEnabled = true

        catCollectionBarItem.isEnabled = true
        settingBarItem.isEnabled = true
        refreshBarItem.isEnabled = true
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
        graduateCatName.dynamicFont(fontSize: 14, name: "BBTreeGo_R")

        itemTitleLabel.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        itemSubTitleLabel.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        itemSubTitleLabel2.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        itemTitleLabel3.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
    
        
        
        leaveCardTitleLabel.dynamicFont(fontSize: 20, name: "BBTreeG_B")
        leaveSubTitle1.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        leaveSubTitle2.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        leaveSubTitle3.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        leaveSubTitle4.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        leaveSubTitle5.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        leaveSubTitle6.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        
        commitReportDescription.dynamicFont(fontSize: 32, name: "NanumBaeEunHyeCe")
        catCollectionDescription.dynamicFont(fontSize: 32, name: "NanumBaeEunHyeCe")
        
        
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
            
            self.tabBarController?.tabBar.isUserInteractionEnabled = true
                       
            self.catCollectionBarItem.isEnabled = true
            self.settingBarItem.isEnabled = true
            self.refreshBarItem.isEnabled = true
            
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

extension HomeVC {
    
    
    func setHomeData() {
        HomeService.sharedInstance.getHomeData { (result) in
            switch result {
                case .networkSuccess(let data) :
                    let detailData = data as? HomeModel
                    
                    if let resResult = detailData {
                        
//                        self.catChatBox.alpha = 1
                        
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
                        
                        if(resResult.data?.ments?.count != 0) {
                            self.catChatLabel.text = resResult.data?.ments?[0]
                        }
                        
                        if(resResult.data?.ments?.count != 0) {
                            self.mentsBox = resResult.data?.ments ?? []
                        }
                        
                        
                        if(resResult.data!.isLevelUp!) {
                            
                            self.isCatItemUpgrade = true
                            
                            self.itemTitleLabel.text = "\(self.gsno(resResult.data?.catName))씨의 아이템이"
                            self.showItemUpgradeCard()
                        }
                        
                        if(resResult.data!.isGraduate!) {
                            self.isCatGraduate = true
                            
                            self.graduateCatName.text = "\(self.gsno(resResult.data?.catName))씨가 졸업하게 되었어요."
                            self.showGraduateCard()
                        }
                        
                        if(resResult.data!.isLeave!) {
                            
                            self.isCatLeave = true
                            
                            self.showLeaveCard()
                            self.showSelectNewCat()
                            
                        }
                    }
                    
                    //let timer
                    
                    _ = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.fireTimer), userInfo: nil, repeats: true)
                    
                    
                    self.loadingView.alpha = 0
                    self.loadingBackgroundView.alpha = 0
                    
                    break
                case .dataNeeded:
                    self.showSelectNewCat()
                    self.loadingView.alpha = 0
                    self.loadingBackgroundView.alpha = 0
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
    
    func loadData() {
        PostUserDataService.shareInstance.postUserData { (result) in
                switch result {
                    case .networkSuccess( _): //201
                        print("UserData POST SUCCESS")
                        
                        self.setHomeData()
                        break
                        
                    case .badRequest: //400
                        self.simpleAlert(title: "", message: "다시 시도해주세요")
                        break
                        
                    case .duplicated: //401
                        
//                        self.simpleAlert(title: "", message: "권한이 없으므로 다시 시도합니다.")
                        print("권한이 없으므로 다시 시도")
                        //TODO - Refresh API 호출
                        self.loadData()
                        
                        break
                        
                    case .networkFail:
                        self.networkErrorAlert()
                        break
                        
                    default:
                        self.simpleAlert(title: "오류", message: "다시 시도해주세요")
                        break
            }
        }
    }
}



