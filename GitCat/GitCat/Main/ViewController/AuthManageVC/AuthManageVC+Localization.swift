//
//  AuthManageVC+Localization.swift
//  GitCat
//
//  Created by 조윤영 on 2020/10/16.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
extension AuthManageVC {
    func setLocalization() {
        self.navigationController?.title = "GitHub Account Settings".localized()
        userIdDescLabel.text = "GitHub Login".localized()
        logoutLabel.text = "Sign Out".localized()
        resignLabel.text = "Delete GitCat Account".localized()
        
        withdrawTitleLabel.text = "Delete GitCat Account".localized()
        withdrawSubTitleLabel1.text = "Delete all data within GitCat?".localized()
        withdrawSubTitleLabel2.text = "Deleting GitCat account is permanent".localized()
        withdrawSubTitleLabel3.text = "and it cannot be undone.".localized()
        
        withdrawOkBtn.setTitle(NSLocalizedString("OK", comment: ""), for: .normal)
        withdrawCancelBtn.setTitle(NSLocalizedString("Cancel", comment: ""), for: .normal)
    }
}
