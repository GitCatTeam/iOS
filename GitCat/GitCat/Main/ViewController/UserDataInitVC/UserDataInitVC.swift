//
//  UserDataInitVC.swift
//  GitCat
//
//  Created by 조윤영 on 05/03/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit

class UserDataInitVC: UIViewController {

    @IBOutlet weak var loadingView: UIImageView!
    
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    var cnt:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.loadGif(name: "gif_cat_loading")
        postUserData()
        cnt = 0

    }
}
