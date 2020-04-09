//
//  NewCatCVCell.swift
//  GitCat
//
//  Created by 조윤영 on 09/04/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit

class NewCatCVCell: UICollectionViewCell {
    @IBOutlet weak var baseView: UIView!
    
    @IBOutlet weak var titleLabel: CustomLabel!
    @IBOutlet weak var newCatImageView: UIImageView!
    @IBOutlet weak var newCatDescriptionLabel:
    CustomLabel!
    
    @IBOutlet weak var closedBtn: UIButton!
    @IBOutlet weak var closedBtnImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // do your thing
        setLabelFontSize()
        self.baseView.layer.masksToBounds = false
        self.baseView.layer.cornerRadius = 10
        self.baseView.customShadow(width: 1, height: 2, radius: 4, opacity: 0.16)
        
    }
    
    func setLabelFontSize() {
        self.newCatDescriptionLabel.setLineHeight(lineHeight: 1.42)
        titleLabel.dynamicFont(fontSize: 20, name: "BBTreeG_B")
        newCatDescriptionLabel.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
    }
}
