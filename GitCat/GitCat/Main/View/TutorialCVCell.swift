//
//  TutorialCVCell.swift
//  GitCat
//
//  Created by 조윤영 on 05/02/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit

protocol TutorialCellDelegate : class {
    func startTutorialAction()
}

class TutorialCVCell: UICollectionViewCell {
    @IBOutlet weak var imageBackgroundView: UIView!
    @IBOutlet weak var tutorialImageView: UIImageView!
    @IBOutlet weak var chapterRoundView: RoundView!
    
    @IBOutlet weak var chapterNumberLabel: UILabel!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var content1: UILabel!
    @IBOutlet weak var content2: UILabel!
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var tutorialStartBtn: RoundBtn!
    

    weak var delegate : TutorialCellDelegate!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.baseView.layer.masksToBounds = false
        self.baseView.layer.cornerRadius = 10
        self.imageBackgroundView.topSectionRound()
        
        self.chapterRoundView.layer.borderColor =  UIColor(red: 137/255, green: 204/255, blue: 246/255, alpha: 1).cgColor
        
        
    }
    
    
    @IBAction func startTutorialAction(_ sender: Any) {
        self.delegate.startTutorialAction()
        
    }
    
}
