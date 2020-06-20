//
//  ReportDetailVC+DynamicFont.swift
//  GitCat
//
//  Created by 조윤영 on 2020/06/20.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation

extension ReportDetailVC {
    func setFontSize() {
        self.descLabel1.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        self.descLabel2.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        self.descLabel3.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        
        self.compareCount.dynamicFont(fontSize: 20, name: "BBTreeG_B")
        self.totalCount.dynamicFont(fontSize: 20, name: "BBTreeG_B")
        self.averageCount.dynamicFont(fontSize: 20, name: "BBTreeG_B")
        
        self.commitDescLabel.dynamicFont(fontSize: 12, name: "BBTreeG_B")
        self.languageDescLabel.dynamicFont(fontSize: 12, name: "BBTreeG_B")
        
        self.repoDescLabel.dynamicFont(fontSize: 12, name: "BBTreeG_B")
        
        self.finalDescLabel.dynamicFont(fontSize: 12, name: "BBTreeG_B")
        
        self.top3Label.dynamicFont(fontSize: 12, name: "BBTreeG_B")
        self.statusLabel1.dynamicFont(fontSize: 11, name: "BBTreeGo_R")
        self.statusPercentLabel1.dynamicFont(fontSize: 12, name: "BBTreeG_B")
        
        self.statusLabel2.dynamicFont(fontSize: 11, name: "BBTreeGo_R")
        self.statusPercentLabel2.dynamicFont(fontSize: 12, name: "BBTreeG_B")
        
        self.statusLabel3.dynamicFont(fontSize: 11, name: "BBTreeGo_R")
        self.statusPercentLabel3.dynamicFont(fontSize: 12, name: "BBTreeG_B")
        
        self.statusLabel4.dynamicFont(fontSize: 11, name: "BBTreeGo_R")
        self.statusPercentLabel4.dynamicFont(fontSize: 12, name: "BBTreeG_B")
        
        self.description1.dynamicFont(fontSize: 11, name: "BBTreeGo_R")
        self.description2.dynamicFont(fontSize: 11, name: "BBTreeGo_R")
        self.description3.dynamicFont(fontSize: 11, name: "BBTreeGo_R")
        
    }
}
