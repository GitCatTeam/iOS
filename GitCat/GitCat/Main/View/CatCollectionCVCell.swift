
//
//  CatCollectionCVCell.swift
//  GitCat
//
//  Created by 조윤영 on 20/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit

class CatCollectionCVCell: UICollectionViewCell {
    
    @IBOutlet weak var baseView: RoundView!
    @IBOutlet weak var medalImageView: UIImageView!
    
    @IBOutlet weak var carBoderView: UIView!
    @IBOutlet weak var catImageView: UIImageView!
    
    @IBOutlet weak var catNameLabel: UILabel!
    
    @IBOutlet weak var majorLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderWidth = 1.0
        
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.cornerRadius = 8
        self.baseView.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.12
        self.layer.masksToBounds = false

        
        carBoderView.layer.borderColor = UIColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1).cgColor
        carBoderView.layer.borderWidth = 1
        
    }
    
}
