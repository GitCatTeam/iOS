//
//  GetAccessVC+Localization.swift
//  GitCat
//
//  Created by 조윤영 on 2020/10/17.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation

extension GetAccessVC {
    func setLocalization() {
        self.titleLabel.text = "Repository Permission Settings".localized()
        self.subtitle1Label.text = "Select the boundary for GitHub repository".localized()
        self.subtitle2Label.text = "to collect your commit history".localized()
        self.miniSubTitleLabel.text = "(This can be modified later in the settings)".localized()
        
        self.publicTitleLabel.text = "Public Repository Only".localized()
        self.publicSubTitle1Label.text = "Grant permission to only public repositories".localized()
        self.publicSubTitle2Label.text = "associated with the GitHub account".localized()
        
        self.privateTitleLabel.text = "Include Private Repository".localized()
        self.privateSubTitle1Label.text = "Grant permission to all repositories".localized()
        self.privateSubTitle2Label.text = "associated with the GitHub account.".localized()

        self.publicDesc1Label.text = "\" Commits from private repositories \"".localized()
        self.publicDesc2Label.text = "do not count".localized()

        self.privateDesc1Label.text =  "\" To access private repository \"".localized()
        self.privateDesc2Label.text = "it asks for full-access permission that includes".localized()
        self.privateDesc3Label.text = "both read/write. (but only read permission is granted.)".localized()
        
        self.nextBtn.setTitle(NSLocalizedString("Next", comment: ""), for: .normal)

    }
}
