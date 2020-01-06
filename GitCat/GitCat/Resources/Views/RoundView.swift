//
//  RoundView.swift
//  GitCat
//
//  Created by 조윤영 on 23/12/2019.
//  Copyright © 2019 조윤영. All rights reserved.
//

import Foundation
import UIKit

class RoundView: UIView {
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
        self.layer.cornerRadius = self.frame.height/2
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor(red: 136.0/255.0, green: 205.0/255.0, blue: 246.0/255.0, alpha: 1.0).cgColor
    }
    
    
}
