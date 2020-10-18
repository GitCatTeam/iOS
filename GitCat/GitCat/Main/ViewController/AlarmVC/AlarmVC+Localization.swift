//
//  AlarmVC+Localization.swift
//  GitCat
//
//  Created by 조윤영 on 2020/10/16.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
extension AlarmVC {
    func setLocalization() {
        self.navigationItem.title = "Notifications Settings".localized()
        self.switchLabel.text = "Allow App Notification".localized()
    }
}
