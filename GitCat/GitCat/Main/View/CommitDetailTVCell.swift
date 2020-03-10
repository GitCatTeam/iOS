//
//  CommitDetailTVCell.swift
//  GitCat
//
//  Created by 조윤영 on 19/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit

class CommitDetailTVCell: UITableViewCell {
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var commitLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.circleView.layer.borderWidth = 1
        self.circleView.circleRadius()
        self.circleView.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
       
        setFontSize()
    }
    
    func setFontSize() {
        commitLabel.dynamicFont(fontSize: 12, name: "BBTreeGo_R")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
