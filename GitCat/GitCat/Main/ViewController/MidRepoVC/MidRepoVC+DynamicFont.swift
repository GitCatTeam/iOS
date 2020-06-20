//
//  MidRepoVC+DynamicFont.swift
//  GitCat
//
//  Created by 조윤영 on 2020/06/20.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
extension MidRepoVC {
    func setFontSize() {
        noneCommitLabel.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        desc1.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        desc2.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        desc3.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        desc4.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        desc5.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        scoreLabel.dynamicFont(fontSize: 32, name: "BBTreeGo_R")
        totalCommitLabel.dynamicFont(fontSize: 32, name: "BBTreeGo_R")
        itemLabel.dynamicFont(fontSize: 32, name: "BBTreeGo_R")
        noneItem.dynamicFont(fontSize: 14, name: "BBTreeGo_R")

    }
}
