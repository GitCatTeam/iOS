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
        settingLabel.text = "Settings".localized()
        authManageLAbel.text = "GitHub Account Settings".localized()
        accessManageLabel.text = "GitHub Repository Permission".localized()
        alaramManageLabel.text = "Notifications Settings".localized()
        catInitialBtn.setTitle(NSLocalizedString("Reset Coding Buddie", comment: ""), for: .normal)
        
        etcLabel.text = "Other".localized()
        introduceDeveloperLabel.text = "Developers Information".localized()
        FAQLabel.text = "FAQ".localized()
        instagramLabel.text = "GitCat Instagram";
        feedbackLabel.text = "Send Feedback";
    }
}
