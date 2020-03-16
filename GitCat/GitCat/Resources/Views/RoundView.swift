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
        
    }
    
    
}
class CircleView:UIView {
    override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = self.bounds.width/2
        self.layer.masksToBounds = true
        self.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
    }
}

class ChapterView:UIView {
    override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = self.bounds.width/2
        self.layer.borderWidth = 1.5
        self.layer.masksToBounds = true
        self.layer.borderColor = #colorLiteral(red: 0.537254902, green: 0.8, blue: 0.9647058824, alpha: 1)
    }
}

