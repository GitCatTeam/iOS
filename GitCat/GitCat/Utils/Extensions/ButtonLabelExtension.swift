//
//  ButtonLabelExtension.swift
//  GitCat
//
//  Created by 조윤영 on 09/03/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func setDynamicFontSize() {
        NotificationCenter.default.addObserver(self, selector: #selector(setButtonDynamicFontSize),
                                               name: UIContentSizeCategory.didChangeNotification,
                                               object: nil)
    }
    
    @objc func setButtonDynamicFontSize() {
        Common.setButtonTextSizeDynamic(button: self, textStyle: .callout)
    }
    
}

class Common {
    
    class func setButtonTextSizeDynamic(button: UIButton, textStyle: UIFont.TextStyle) {
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: textStyle)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
    }
    
}
