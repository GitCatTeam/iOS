//
//  ReportVC+Localization.swift
//  GitCat
//
//  Created by 조윤영 on 2020/10/18.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
extension ReportDetailVC {
    func setLocalization() {
        self.descLabel1.text = "Since Last Month".localized()
        self.descLabel2.text = "Total Commit".localized()
        self.descLabel3.text = "Daily average".localized()
        self.commitDescLabel.text = "Commit Count Stats".localized()
        self.languageDescLabel.text = "Ratio of used programming languages".localized()
        self.repoDescLabel.text = "Repository Contribution".localized()
        self.finalDescLabel.text = "This Month's Review" .localized()
    }
}
