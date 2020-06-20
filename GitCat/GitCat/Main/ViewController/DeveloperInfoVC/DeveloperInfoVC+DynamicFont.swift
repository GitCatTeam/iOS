//
//  DeveloperInfoVC+DynamicFont.swift
//  GitCat
//
//  Created by 조윤영 on 2020/06/20.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
 
extension DeveloperInfoVC {
    func setFont() {
        self.role1.dynamicFont(fontSize: 16, name: "BBTreeG_B")
        self.role2.dynamicFont(fontSize: 16, name: "BBTreeG_B")
        self.role3.dynamicFont(fontSize: 16, name: "BBTreeG_B")
        self.role4.dynamicFont(fontSize: 16, name: "BBTreeG_B")
        self.role5.dynamicFont(fontSize: 16, name: "BBTreeG_B")
        self.role6.dynamicFont(fontSize: 16, name: "BBTreeG_B")
        
        self.name1.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        self.name2.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        self.name3.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        self.name4.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        self.name5.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        self.name6.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        
        self.detail1.dynamicFont(fontSize: 12, name: "BBTreeGo_R")
        self.detail2.dynamicFont(fontSize: 12, name: "BBTreeGo_R")
        self.detail3.dynamicFont(fontSize: 12, name: "BBTreeGo_R")
        self.detail4.dynamicFont(fontSize: 12, name: "BBTreeGo_R")
        self.detail5.dynamicFont(fontSize: 12, name: "BBTreeGo_R")
        self.detail6.dynamicFont(fontSize: 12, name: "BBTreeGo_R")
        
        self.detail1.setLineHeight(lineHeight: 1.5)
        self.detail2.setLineHeight(lineHeight: 1.5)
        self.detail3.setLineHeight(lineHeight: 1.5)
        self.detail4.setLineHeight(lineHeight: 1.5)
        self.detail5.setLineHeight(lineHeight: 1.5)
        self.detail6.setLineHeight(lineHeight: 1.5)
        
    }
}
