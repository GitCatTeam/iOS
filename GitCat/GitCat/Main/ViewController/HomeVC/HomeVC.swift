//
//  HomeVC.swift
//  GitCat
//
//  Created by 조윤영 on 30/12/2019.
//  Copyright © 2019 조윤영. All rights reserved.
//
//TODO - 프로그레스바 아이패드 상에서 회색 부분 안보임

import UIKit

class HomeVC: UIViewController, TutorialCellDelegate {
    @IBOutlet weak var titleLabel: CustomLabel! //오늘의 커밋

    @IBOutlet weak var catChatBox: UIImageView!
    @IBOutlet weak var catChatLabel: UILabel! //GGGGG
    @IBOutlet weak var catInfoBox: UIView!
    @IBOutlet weak var sliderView: GradientSlider!
    
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

    @IBOutlet weak var todayCommitCountLabel: CustomLabel! //오늘의 커밋 값
    
    @IBOutlet weak var catNameLabel: UILabel! //고양이 이름
    @IBOutlet weak var catImageView: UIImageView! //고양이 이미지
    
    
    @IBOutlet weak var firstBarLabel: UILabel!
    @IBOutlet weak var secondBarLabel: UILabel!
    @IBOutlet weak var thirdBarLabel: CustomLabel!
    
    
    @IBOutlet weak var currentLevelLabel: CustomLabel!
    @IBOutlet weak var levelSliderView: GradientSlider!
    @IBOutlet weak var scoreSumLabel: CustomLabel!
    @IBOutlet weak var todayScoreLabel: CustomLabel!
    @IBOutlet weak var nextItemLabel: UILabel!
    @IBOutlet weak var nextLevelLeftPointLabel: UILabel!
    @IBOutlet weak var graduateLeftPointLabel: CustomLabel!
    
    
    @IBOutlet weak var loadingView: UIImageView!
    @IBOutlet weak var loadingBackgroundView: UIView!
    
    @IBOutlet weak var selectCatBtn: UIButton!
    
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
    
    @IBOutlet weak var scoreAlertView: UIView!
    
    @IBOutlet weak var scoreAlertTitleLabel1: CustomLabel!
    @IBOutlet weak var scoreAlertTitleLabel2: CustomLabel!
    @IBOutlet weak var scoreAlertSubLabel1: CustomLabel!
    @IBOutlet weak var scoreAlertSubLabel2: CustomLabel!
    @IBOutlet weak var scoreAlertSubLabel3: CustomLabel!
    @IBOutlet weak var scoreAlertSubLabel4: CustomLabel!
    
    @IBOutlet weak var scoreAlertSubLabel5: CustomLabel!
    @IBOutlet weak var scoreAlertSubLabel6: CustomLabel!
    @IBOutlet weak var scoreAlertSubLabel7: CustomLabel!
    @IBOutlet weak var scoreAlertSubLabel8: UILabel!
    
    let cellIdentifier = "TutorialCVCell"
    
    let chapterData:[String] = ["01","02","03","04"]
    let imageData:[UIImage] = [ UIImage(named: "imgTutorial1")!, UIImage(named: "imgTutorial2")!, UIImage(named: "img_tutorial3")!, UIImage(named: "imgTutorial4")!]
    
    let title1: String = "Help your coding buddies grow".localized()
    let content11: String = "Commit everyday, consistently.".localized()
    let content12 = "Coding buddy's coding environment will improve.".localized()
    
    let title2: String = "Help your buddies graduate!".localized()
    let content21 = "Graduated buddies will graduate but don't worry!".localized()
    let content22 = "You can see their graduation picture once you click the collection button.".localized()
    let title3: String = "Look over your progression ".localized()
    let content31 = "Check out commit history through".localized()
    let content32 = "the commit calendar and commit stats by the report.".localized()
    let title4: String = "Complete tutorial and meet your coding buddy!".localized();
    
    var titleData = [String]()
    var content1Data = [String]()
    var content2Data = [String]()
    
    var mentsBox = [String]()
    var mentPos = 0
    var count = 0
    var isCatGraduate:Bool = false
    var isCatItemUpgrade:Bool = false
    var isCatLeave:Bool = false
    var timer = Timer()
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setAlpha()
        setHomeData()
        setItemCardBackgroundView()
        setLocalization()
        
        let isTutorialDone = UserDefaults.standard.bool(forKey: "tutorialDone")
        
        if(isTutorialDone == false){
            showTutorial()
        }
        
        titleData = [title1, title2, title3, title4]
        content1Data = [content11, content21, content31, ""]
        content2Data = [content12, content22, content32, ""]
        
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
    
    @IBAction func catCollectionAction(_ sender: Any) {
        let dvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "CatCollectionNavVC")
         dvc.modalPresentationStyle = .fullScreen
                       
        self.present(dvc, animated: true, completion: nil)
    }
    
    @IBAction func settingAction(_ sender: Any) {
        
        let dvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "SettingNavVC")
         dvc.modalPresentationStyle = .fullScreen
                       
        self.present(dvc, animated: true, completion: nil)
        
    }
    
    @IBAction func checkGraduateAction(_ sender: Any) {
        cardBackgroundView.alpha = 0
        graduateCardView.alpha = 0
        
        self.tabBarController?.tabBar.alpha = 1
        self.tabBarController?.tabBar.isUserInteractionEnabled = true
        
        self.catCollectionBarItem.isEnabled = true
        self.settingBarItem.isEnabled = true
        self.refreshBarItem.isEnabled = true
        
        self.catImageView.image = UIImage(named: "imgCatNull")
        
        let dvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "CatCollectionNavVC")
         dvc.modalPresentationStyle = .fullScreen
                       
        self.present(dvc, animated: true, completion: nil)
    }
    
    @IBAction func leaveCloseAction(_ sender: Any) {
        isCatLeave = false
        
        UIView.animate(withDuration: 0.3, animations: {
             self.itemUpgradeCardView.alpha = 0
            self.tabBarController?.tabBar.alpha = 1

            self.tabBarController?.tabBar.isUserInteractionEnabled = true
            self.catImageView.image = UIImage(named: "imgCatNull")
            self.catCollectionBarItem.isEnabled = true
            self.settingBarItem.isEnabled = true
            self.refreshBarItem.isEnabled = true
         })

         if(self.isCatGraduate == false && self.isCatItemUpgrade == false) {
             dismissCardBackground()
         }
    }
    
    @IBAction func itemUpgradeCloseAction(_ sender: Any) {
        isCatItemUpgrade = false
        
        UIView.animate(withDuration: 0.3, animations: {
            self.itemUpgradeCardView.alpha = 0
        })

        if(self.isCatGraduate == false && self.isCatLeave == false) {
            dismissCardBackground()
        }
    }
    
    @IBAction func graduateCloseAction(_ sender: Any) {
        
        isCatGraduate = false
        UIView.animate(withDuration: 0.3, animations: {
            self.cardBackgroundView.alpha = 0
            self.graduateCardView.alpha = 0
            
            self.tabBarController?.tabBar.alpha = 1

            self.tabBarController?.tabBar.isUserInteractionEnabled = true
            self.catImageView.image = UIImage(named: "imgCatNull")
            self.catCollectionBarItem.isEnabled = true
            self.settingBarItem.isEnabled = true
            self.refreshBarItem.isEnabled = true
        })
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
        UIView.animate(withDuration: 0.3, animations: {
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
        self.selectCatBtn.alpha = 0
        self.catCollectionArrow.alpha = 0
        self.catCollectionDescription.alpha = 0
        self.highlightView.alpha = 0
        
        self.reportArrow.alpha = 0
        self.commitCalendarArrow.alpha = 0
        self.commitReportDescription.alpha = 0
        
        self.cardBackgroundView.alpha = 0
        self.graduateCardView.alpha = 0
        self.itemUpgradeCardView.alpha = 0
        self.leaveCardView.alpha = 0
        self.scoreAlertView.alpha = 0
        
        self.OverlayView.alpha = 0
        
        self.loadingBackgroundView.alpha = 1
    }
    
    func setStyle() {
        setTutorialStyle()
        setAlertViewStyle()
        
        self.loadingView.loadGif(name: "gif_loading2")
        
        setCatInfoBoxStyle()
        self.selectCatBtn.layer.borderColor = UIColor.clear.cgColor
        self.selectCatBtn.circleRadius()
        self.selectCatBtn.customShadow(width: 1, height: 1, radius: 56.5, opacity: 0.1)
        self.catChatLabel.setLineHeight(lineHeight: 0.8)
        
        self.leaveCardView.roundRadius(radius: 10)
        leaveCardView.customShadow(width: 1, height: 1, radius: 56.5, opacity: 0.1)
        
        scoreAlertView.roundRadius(radius: 10)
        scoreAlertView.customShadow(width: 1, height: 2, radius: 11, opacity: 0.16)
    }
    
    func setTutorialStyle() {
        self.highlightView.layer.borderWidth = 0
        self.highlightView.circleRadius()
    }
    
    func setAlertViewStyle() {
        self.graduateCardView.roundRadius(radius: 10)
        self.graduateCardView.customShadow(width: 1, height: 2, radius: 11, opacity: 0.16)
        self.itemUpgradeCardView.roundRadius(radius: 10)
        self.itemUpgradeCardView.customShadow(width: 1, height: 2, radius: 11, opacity: 0.16)
    }
    
    func setCatInfoBoxStyle() {
        self.catInfoBox.roundRadius(radius: 14)
        self.catInfoBox.addShadow()

        self.sliderView.thickness = self.catInfoBox.frame.height / 10
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
        
        self.todayCommitCountLabel.text = "-"
        self.catChatBox.alpha = 0
        self.catChatLabel.alpha = 0
        self.catInfoBox.alpha = 0
    }
    
    @IBAction func showScoreDetailAction(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.setCardBackgorund()
            self.cardBackgroundView.alpha = 1
            self.scoreAlertView.alpha = 1
        })
    }
    
    @IBAction func closeScoreInfoAction(_ sender: Any) {
        dismissCardBackground()
        self.scoreAlertView.alpha = 0
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

        self.catCollectionBarItem.isEnabled = false
        self.settingBarItem.isEnabled = false
        self.refreshBarItem.isEnabled = false

    }
    
    func dismissCardBackground() {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.cardBackgroundView.alpha = 0
            self.tabBarController?.tabBar.alpha = 1

            self.tabBarController?.tabBar.isUserInteractionEnabled = true

            self.catCollectionBarItem.isEnabled = true
            self.settingBarItem.isEnabled = true
            self.refreshBarItem.isEnabled = true
        })
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
        UIView.animate(withDuration: 0.3, animations: {
            self.cardBackgroundView.alpha = 0

            self.tabBarController?.tabBar.alpha = 1
            self.navigationController?.navigationBar.alpha = 1
            
            self.tabBarController?.tabBar.isUserInteractionEnabled = true
                       
            self.catCollectionBarItem.isEnabled = true
            self.settingBarItem.isEnabled = true
            self.refreshBarItem.isEnabled = true
            
        })
    }
}
