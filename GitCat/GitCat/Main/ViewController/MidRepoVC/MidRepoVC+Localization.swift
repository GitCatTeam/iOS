//
//  MidRepoVC+Localization.swift
//  GitCat
//
//  Created by 조윤영 on 2020/10/18.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
extension MidRepoVC {
    func setLocalization() {
        self.navigationItem.title = "Commit Calendar".localized()
        self.statusLabel1.text = "0".localized()
        self.statusLabel2.text = "1 ~ 5".localized()
        self.statusLabel3.text = "6 ~ 10".localized()
        self.statusLabel4.text = "10+".localized()
        self.desc1.text = "Today's Commit".localized()
        self.desc2.text = "Received Point".localized()
        self.desc3.text = "Total Commit".localized()
        self.desc4.text = "Received Item".localized()
        self.desc5.text = "Commit History Details".localized()
        self.noneItem.text = "None!".localized()
        self.noneCommitLabel.text = "No commit history available!".localized()
    }
}
