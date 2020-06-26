//
//  RepositoryAccessVC.swift
//  GitCat
//
//  Created by 조윤영 on 2020/06/26.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit

class RepositoryAccessVC: UIViewController {
    
    @IBOutlet weak var publicAccessLabel: CustomLabel!
    @IBOutlet weak var privateAccessLabel: CustomLabel!
    @IBOutlet weak var sub1Label: CustomLabel!
    @IBOutlet weak var sub2Label: CustomLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackBtn(color: UIColor.CustomColor.brownishGrey)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.CustomColor.brownishGrey]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

        self.setFontSize()
    }
    
    func setFontSize() {
        self.publicAccessLabel.dynamicFont(fontSize: 17, name: "BBTreeGo_R")
        self.privateAccessLabel.dynamicFont(fontSize: 17, name: "BBTreeGo_R")
        sub1Label.dynamicFont(fontSize: 10, name: "BBTreeGo_R")
        sub2Label.dynamicFont(fontSize: 10, name: "BBTreeGo_R")
    }
    
    @IBAction func checkPublicAccessAction(_ sender: Any) {
        
    }
    
    @IBAction func checkPrivateAccessAction(_ sender: Any) {
        
    }
}
