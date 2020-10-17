//
//  HomeVC+Localization.swift
//  GitCat
//
//  Created by 조윤영 on 2020/10/16.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation

extension HomeVC {
    func setLocalization() {
        self.titleLabel.text = "Today's Commit".localized()
//        self.todayCommitCountLabel.dynamicFont(fontSize: 70, name: "SangSangYoungestDaughter")
//        self.catChatLabel.dynamicFont(fontSize: 18, name: "NanumBaReunHiPi")
//
//        self.currentLevelLabel.dynamicFont(fontSize: 14, name: "SeN-CB")
//        self.catNameLabel.dynamicFont(fontSize: 14, name:"SeN-CB")
//
//        self.firstBarLabel.dynamicFont(fontSize: 14, name: "SeN-CM")
//        self.scoreSumLabel.dynamicFont(fontSize: 14, name: "SeN-CM")
//        self.todayScoreLabel.dynamicFont(fontSize: 14, name: "SeN-CM")
//
//        self.secondBarLabel.dynamicFont(fontSize: 14, name: "SeN-CM")
//        self.nextItemLabel.dynamicFont(fontSize: 14, name: "SeN-CM")
//        self.nextLevelLeftPointLabel.dynamicFont(fontSize: 14, name: "SeN-CM")
//
//        self.thirdBarLabel.dynamicFont(fontSize: 14, name: "SeN-CM")
//        self.graduateLeftPointLabel.dynamicFont(fontSize: 14, name: "SeN-CM")
//
//        self.selectCatBtn.titleLabel?.dynamicFont(fontSize: 14, name: "BBTreeG_B")
//
        self.graduateTitleLabel.text = "HAPPY Graduation!".localized()
        self.graduateSubTitle2.text = "Congratulations!".localized()
        self.graduateSubTitle1.text = "Thank you for your hard work :)".localized()
        self.graduateCatName.text = "cat has successfully graduated.".localized()
        self.graduateBtn.setTitle(NSLocalizedString("Go check it out", comment: ""), for: .normal)
        
        self.itemTitleLabel.text = "Item Upgrade!".localized()
        
        self.itemTitleLabel3.text = "Your item has been upgraded.".localized()
        self.itemSubTitleLabel.text = "It's much better than before!".localized()
        self.itemSubTitleLabel2.text = "Keep up the good work :)".localized()

        self.leaveCardTitleLabel.text = "[Breaking News]".localized()
        self.leaveSubTitle1.text = "Unfortunately,".localized()
        self.leaveSubTitle3.text = " has left.".localized()
        self.leaveSubTitle4.text = "In order to stop your".localized()
        self.leaveSubTitle6.text = "buddies from leaving,".localized()
        self.leaveSubTitle5.text = "more consistent commit is required".localized()

        self.commitReportDescription.text = "Monthly Commit State & Monthly Commit Report".localized()
        self.catCollectionDescription.text = "Collection Button".localized()

        self.scoreAlertTitleLabel1.text = "Hang on!".localized()
        self.scoreAlertTitleLabel2.text = "how can we earn points".localized()
        self.scoreAlertSubLabel1.text = "- if you commit at least once after".localized()
        self.scoreAlertSubLabel2.text = "you've met the cat, you get 1 point.".localized()
        self.scoreAlertSubLabel3.text = "- if you commit in git more than".localized()
        self.scoreAlertSubLabel4.text = "5 times, you can get at most 1 point.".localized()
        self.scoreAlertSubLabel5.text = "* You are able to help your first cat".localized()
        self.scoreAlertSubLabel6.text = "graduate once you receive 1 point".localized()
        self.scoreAlertSubLabel7.text = "but it'll get harder and harder".localized()
        self.scoreAlertSubLabel8.text = "for your next cats. Good luck!".localized()
        
        self.selectCatBtn.setTitle("Select your coding buddy".localized(), for: .normal)
    }
}
