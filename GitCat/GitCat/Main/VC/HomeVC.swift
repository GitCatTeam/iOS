//
//  HomeVC.swift
//  GitCat
//
//  Created by 조윤영 on 30/12/2019.
//  Copyright © 2019 조윤영. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var catChatLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        catChatLabel.setLineHeight(lineHeight: 0.8)


        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
