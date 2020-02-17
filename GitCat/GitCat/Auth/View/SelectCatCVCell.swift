//
//  SelectCatCVCell.swift
//  GitCat
//
//  Created by 조윤영 on 06/02/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit

class SelectCatCVCell: UICollectionViewCell {
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var NewBadgeView: UIView!
    @IBOutlet weak var BuyBadgeView: UIView!
    
    @IBOutlet weak var roundView: UIView!
    
    @IBOutlet weak var baseView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.roundView.layer.cornerRadius = 12
        self.roundView.layer.borderColor = #colorLiteral(red: 0.7480606437, green: 0.7532055974, blue: 0.7486153245, alpha: 1)
        self.roundView.layer.borderWidth = 1

        self.NewBadgeView.layer.cornerRadius = 7
        self.BuyBadgeView.layer.cornerRadius = 7
    }
    
}
