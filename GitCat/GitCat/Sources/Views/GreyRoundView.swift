//
//  GreyRoundView.swift
//  GitCat
//
//  Created by 조윤영 on 24/12/2019.
//  Copyright © 2019 조윤영. All rights reserved.
//


import Foundation
import UIKit

class GreyRoundView: UIView {
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
        self.layer.cornerRadius = self.frame.height/2
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor(red: 192.0/255.0, green: 192.0/255.0, blue: 192.0/255.0, alpha: 1.0).cgColor
    }
    
    
}
