//
//  MainTabBarVC.swift
//  GitCat
//
//  Created by 조윤영 on 20/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.selectedIndex = 1;
        
        tabBar.items![0].title = "Commit Calendar".localized()
        tabBar.items![1].title = "Home".localized()
        tabBar.items![2].title = "Report".localized()
    }
}
