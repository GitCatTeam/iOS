//
//  HomeVC+DynamicFont.swift
//  GitCat
//
//  Created by 조윤영 on 2020/06/20.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
extension HomeVC {
    func setLabelFontSize() {
        self.titleLabel.dynamicFont(fontSize: 28, name: "BBTreeG_L")
        
        self.todayCommitCountLabel.dynamicFont(fontSize: 70, name: "SangSangYoungestDaughter")
        self.catChatLabel.dynamicFont(fontSize: 20, name: "NanumBaReunHiPi")
//        self.todayScoreDescLabel.dynamicFont(fontSize: 16, name:"BBTreeGo_R")
//        self.todayScoreLabel.dynamicFont(fontSize: 28, name: "NanumBaeEunHyeCe")
//
//        self.leftScoreDescLabel.dynamicFont(fontSize: 16, name:"BBTreeGo_R")
//        self.leftScoreLabel.dynamicFont(fontSize: 28, name:"NanumBaeEunHyeCe")
        self.catNameLabel.dynamicFont(fontSize: 28, name:"NanumBaeEunHyeCe")
//        self.itemLabel.dynamicFont(fontSize: 18, name:"NanumBaeEunHyeCe")
        self.selectCatBtn.titleLabel?.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        
        self.graduateTitleLabel.dynamicFont(fontSize: 20, name: "BBTreeG_B")
        self.graduateSubTitle1.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        self.graduateSubTitle2.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        self.graduateCatName.dynamicFont(fontSize: 14, name: "BBTreeGo_R")

        self.itemTitleLabel.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        self.itemSubTitleLabel.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        self.itemSubTitleLabel2.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        self.itemTitleLabel3.dynamicFont(fontSize: 14, name: "BBTreeGo_R")

        self.leaveCardTitleLabel.dynamicFont(fontSize: 20, name: "BBTreeG_B")
        self.leaveSubTitle1.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        self.leaveSubTitle2.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        self.leaveSubTitle3.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        self.leaveSubTitle4.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        self.leaveSubTitle5.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        self.leaveSubTitle6.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        
        self.commitReportDescription.dynamicFont(fontSize: 32, name: "NanumBaeEunHyeCe")
        self.catCollectionDescription.dynamicFont(fontSize: 32, name: "NanumBaeEunHyeCe")
        
        self.scoreAlertTitleLabel1.dynamicFont(fontSize: 20, name: "BBTreeG_B")
        self.scoreAlertTitleLabel2.dynamicFont(fontSize: 20, name: "BBTreeG_B")
        self.scoreAlertSubLabel1.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        self.scoreAlertSubLabel2.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        self.scoreAlertSubLabel3.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        self.scoreAlertSubLabel4.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        self.scoreAlertSubLabel5.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        self.scoreAlertSubLabel6.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        self.scoreAlertSubLabel7.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        
    }
}
