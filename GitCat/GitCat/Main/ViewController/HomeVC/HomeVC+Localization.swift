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
        self.titleLabel.text = NSLocalizedString("Today's Commit", comment: "")
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
        self.graduateTitleLabel.text = NSLocalizedString("HAPPY Graduation!", comment: "")
        self.graduateSubTitle1.text = NSLocalizedString("Congratulations!", comment: "")
        self.graduateSubTitle2.text = NSLocalizedString("Thank you for your hard work :)", comment: "")
        self.graduateCatName.text = NSLocalizedString("your cat has syccessfully graduated.", comment: "")
        self.graduateBtn.titleLabel?.text = NSLocalizedString("Go check it out", comment: "")
        
        self.itemTitleLabel.text = NSLocalizedString("Item Upgrade!", comment: "")
        
        self.itemTitleLabel3.text = NSLocalizedString("Your item has been upgraded.", comment: "")
        self.itemSubTitleLabel.text = NSLocalizedString("It's much better than before!", comment: "")
        self.itemSubTitleLabel2.text = NSLocalizedString("Keep up the good work :)", comment: "")

        self.leaveCardTitleLabel.text = NSLocalizedString("[Breaking News]", comment: "")
        self.leaveSubTitle1.text = NSLocalizedString("Unfortunately,", comment: "")
        self.leaveSubTitle3.text = NSLocalizedString(" has left.", comment: "")
        self.leaveSubTitle4.text = NSLocalizedString("In order to stop your", comment: "")
        self.leaveSubTitle6.text = NSLocalizedString("buddies from leaving,", comment: "")
        self.leaveSubTitle5.text = NSLocalizedString("more consistent commit is required", comment: "")


//        self.commitReportDescription.dynamicFont(fontSize: 32, name: "NanumBaeEunHyeCe")
//        self.catCollectionDescription.dynamicFont(fontSize: 32, name: "NanumBaeEunHyeCe")
//
        self.scoreAlertTitleLabel1.text = NSLocalizedString("Hang on!", comment: "")
        self.scoreAlertTitleLabel2.text = NSLocalizedString("how can we earn points", comment: "")
        self.scoreAlertSubLabel1.text = NSLocalizedString("- if you commit at least once after", comment: "")
        self.scoreAlertSubLabel2.text = NSLocalizedString("you've met the cat, you get 1 point.", comment: "")
        self.scoreAlertSubLabel3.text = NSLocalizedString("- if you commit in git more than", comment: "")
        self.scoreAlertSubLabel4.text = NSLocalizedString("5 times, you can get at most 1 point.", comment: "")
        self.scoreAlertSubLabel5.text = NSLocalizedString("* You are able to help your first cat", comment: "")
        self.scoreAlertSubLabel6.text = NSLocalizedString("graduate once you receive 1 point", comment: "")
        self.scoreAlertSubLabel7.text = NSLocalizedString("but it'll get harder and harder", comment: "")
        self.scoreAlertSubLabel8.text = NSLocalizedString("for your next cats. Good luck!", comment: "")
        
    }
}
