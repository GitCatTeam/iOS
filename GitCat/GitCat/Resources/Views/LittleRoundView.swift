//
//  LittleRoundView.swift
//  GitCat
//
//  Created by 조윤영 on 04/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
import UIKit

class LittleRoundView: UIView {
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
    }

}

