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
        self.circleView.circleRadius()
        
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
