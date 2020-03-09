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
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // do your thing
        setLabelFontSize()
        self.baseView.layer.masksToBounds = false
        self.baseView.layer.cornerRadius = 10
        self.baseView.customShadow(width: 1, height: 2, radius: 10, opacity: 0.16)
        self.imageBackgroundView.topSectionRound()
                
        self.chapterRoundView.layer.borderColor =  UIColor(red: 137/255, green: 204/255, blue: 246/255, alpha: 1).cgColor
        tutorialStartBtn.circleRadius()
                
        self.chapterRoundView.layer.borderColor = #colorLiteral(red: 0.537254902, green: 0.8, blue: 0.9647058824, alpha: 1)
        self.chapterRoundView.layer.borderWidth = 1.5
        self.chapterRoundView.layer.cornerRadius = self.chapterRoundView.layer.frame.height/2
        self.chapterRoundView.layer.masksToBounds = true
        
    }
    
    func setLabelFontSize() {
        title.dynamicFont(fontSize: 20, name: "BBTreeG_B")
        
        content1.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        content2.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        
        chapterNumberLabel.dynamicFont(fontSize: 18, name: "BBTreeG_B")
        
        tutorialStartBtn.titleLabel?.dynamicFont(fontSize: 14, name: "BBTreeG_B")
    }
    
    @IBAction func startTutorialAction(_ sender: Any) {
        self.delegate.startTutorialAction()
        
    }
    
}
