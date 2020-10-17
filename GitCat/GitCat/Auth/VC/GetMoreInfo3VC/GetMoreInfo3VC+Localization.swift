//
//  GetMoreInfo3VC+Localization.swift
//  GitCat
//
//  Created by 조윤영 on 2020/10/17.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation

extension GetMoreInfo3VC {
    func setLocalization() {
        self.MainTitle.text = "How long have you been coding for?".localized()
        self.subTitle.text = "We only ask you this to make GitCat better :)"
            .localized()
        self.interestInDevBtn.setTitle(NSLocalizedString("Interested", comment: ""), for: .normal)
        self.studentBtn.setTitle(NSLocalizedString("Related Student", comment: ""), for: .normal)
        self.OneYearDevBtn.setTitle(NSLocalizedString("About 1 year", comment: ""), for: .normal)
        self.ThreeYearDevBtn.setTitle(NSLocalizedString("About 3 year", comment: ""), for: .normal)
        self.MoreThanFiveYearDevBtn.setTitle(NSLocalizedString("More than 5 years", comment: ""), for: .normal)
        self.nextBtn3.setTitle(NSLocalizedString("Next", comment: ""), for: .normal)
        
    }
}
