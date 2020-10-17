//
//  GetMoreInfo4VC+Localization.swift
//  GitCat
//
//  Created by 조윤영 on 2020/10/18.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
extension GetMoreInfo4VC {
    func setLocalization() {
        self.mainTitle.text = "Select your coding buddy!".localized()
        self.subTitle.text = "Make a coding buddy for more enjoyable commit!".localized()
        self.catNameTextField.placeholder = "(Maximum 8 Characters)".localized()
        self.basicBtn.setTitle("Origin".localized(), for: .normal)
        self.specialBtn.setTitle("Special", for: .normal)
        self.catNameLabel.text = "Name your coding buddy".localized()
        self.nextMove4Btn.setTitle("Next", for: .normal)
    }
}
