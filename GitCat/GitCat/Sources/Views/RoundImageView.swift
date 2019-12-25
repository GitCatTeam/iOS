//
//  RoundImageView.swift
//  GitCat
//
//  Created by 조윤영 on 25/12/2019.
//  Copyright © 2019 조윤영. All rights reserved.
//

import Foundation
import UIKit

class RoundImageView: UIImageView {
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.width / 2
    }
}

