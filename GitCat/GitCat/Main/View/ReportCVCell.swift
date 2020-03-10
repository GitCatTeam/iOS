//
//  ReportCVCell.swift
//  GitCat
//
//  Created by 조윤영 on 09/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit

class ReportCVCell: UICollectionViewCell {
    
    @IBOutlet weak var mainTitle: UILabel!
    
    @IBOutlet weak var commitCountDescLabel: CustomLabel!
    @IBOutlet weak var commitCountLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var languageDescLabel: CustomLabel!
    @IBOutlet weak var bottomView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderWidth = 1.0
        
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.cornerRadius = 8
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.12
        self.layer.masksToBounds = false
        
        bottomView.bottomSectionRound()
        setFontSize()
    }
    
    func setFontSize() {
        mainTitle.dynamicFont(fontSize: 20, name: "BBTreeG_B")
        commitCountDescLabel.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        commitCountLabel.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        
        languageLabel.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        languageDescLabel.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        
    }
    
}
