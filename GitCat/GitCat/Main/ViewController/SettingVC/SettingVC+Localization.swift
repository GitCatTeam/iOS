//
//  SettingVC+Localization.swift
//  GitCat
//
//  Created by 조윤영 on 2020/10/16.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation

extension SettingVC {
    func setLocalization() {
        self.settingLabel.text = "Settings".localized()
        self.authManageLAbel.text = "GitHub Account Settings".localized()
        self.accessManageLabel.text = "GitHub Repository Permission".localized()
        self.alaramManageLabel.text = "Notifications Settings".localized()
        self.catInitialBtn.setTitle(NSLocalizedString("Reset Coding Buddie", comment: ""), for: .normal)
        
        self.etcLabel.text = "Other".localized()
        self.introduceDeveloperLabel.text = "Developers Information".localized()
        self.FAQLabel.text = "FAQ".localized()
        self.instagramLabel.text = "GitCat Instagram";
        self.feedbackLabel.text = "Send Feedback";
    }
}
