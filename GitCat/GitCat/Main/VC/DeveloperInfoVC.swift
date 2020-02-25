//
//  DeveloperInfoVC.swift
//  GitCat
//
//  Created by 조윤영 on 25/02/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit
import SwiftGifOrigin

class DeveloperInfoVC: UIViewController {
    @IBOutlet weak var testImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testImageView.loadGif(name: "gif_loading2")
    }



}
