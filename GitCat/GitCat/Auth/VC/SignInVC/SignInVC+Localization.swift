//
//  SignInVC+Localization.swift
//  GitCat
//
//  Created by 조윤영 on 2020/10/17.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
extension SignInVC {
    func setLocalization() {
        self.subTitleLabel.text = "Daily commit with your coding buddy!".localized()
        self.loginBtn.setTitle(NSLocalizedString("Sign in with GitHub", comment: ""), for: .normal)
    }
}
