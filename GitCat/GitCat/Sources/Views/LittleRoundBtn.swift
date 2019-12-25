
//
//  LittleRoundView.swift
//  GitCat
//
//  Created by 조윤영 on 25/12/2019.
//  Copyright © 2019 조윤영. All rights reserved.
//

import Foundation
import UIKit

class LittleRoundBtn: UIButton {
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
    }

}

