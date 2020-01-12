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
    @IBOutlet weak var commitCountLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8
        
    }
    
}
