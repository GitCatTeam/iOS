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
    @IBOutlet weak var timeLabel: CustomLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setFontSize()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setFontSize() {
        commitLabel.dynamicFont(fontSize: 12, name: "BBTreeGo_R")
        timeLabel.dynamicFont(fontSize: 10, name: "BBTreeG_L")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }


}
