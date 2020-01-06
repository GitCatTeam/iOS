//
//  CustomLabel.swift
//  GitCat
//
//  Created by 조윤영 on 06/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
import UIKit

open class CustomLabel : UILabel {
    @IBInspectable open var characterSpacing:CGFloat = 1 {
        didSet {
            let attributedString = NSMutableAttributedString(string: self.text!)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: self.characterSpacing, range: NSRange(location: 0, length: attributedString.length))
            self.attributedText = attributedString
        }

    }
}
