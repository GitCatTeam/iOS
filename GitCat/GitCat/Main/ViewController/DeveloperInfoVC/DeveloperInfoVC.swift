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
    @IBOutlet weak var catView1: UIView!
    @IBOutlet weak var catView2: UIView!
    @IBOutlet weak var catView3: UIView!
    @IBOutlet weak var catView4: UIView!
    @IBOutlet weak var catView5: UIView!
    @IBOutlet weak var catView6: UIView!
    
    @IBOutlet weak var role1: CustomLabel!
    @IBOutlet weak var name1: CustomLabel!
    @IBOutlet weak var detail1: CustomLabel!
    
    @IBOutlet weak var role2: CustomLabel!
    @IBOutlet weak var name2: CustomLabel!
    @IBOutlet weak var detail2: CustomLabel!
    
    @IBOutlet weak var role3: CustomLabel!
    @IBOutlet weak var name3: CustomLabel!
    @IBOutlet weak var detail3: CustomLabel!
    
    @IBOutlet weak var role4: CustomLabel!
    @IBOutlet weak var name4: CustomLabel!
    @IBOutlet weak var detail4: CustomLabel!
    
    @IBOutlet weak var role5: CustomLabel!
    @IBOutlet weak var name5: CustomLabel!
    @IBOutlet weak var detail5: CustomLabel!
    
    @IBOutlet weak var role6: CustomLabel!
    @IBOutlet weak var name6: CustomLabel!
    @IBOutlet weak var detail6: CustomLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackBtn(color: UIColor.CustomColor.brownishGrey)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.CustomColor.brownishGrey]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        setFont()
        self.navigationItem.title = "Developers Information".localized()
        self.tabBarController?.tabBar.alpha = 0
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setStyle()

    }
    
    func setStyle() {
        self.catView1.layer.borderWidth = 1.0
        self.catView1.layer.cornerRadius = 16
        self.catView1.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)

        self.catView2.layer.borderWidth = 1.0
        self.catView2.layer.cornerRadius = 16
        self.catView2.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        self.catView3.layer.borderWidth = 1.0
        self.catView3.layer.cornerRadius = 16
        self.catView3.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        self.catView4.layer.borderWidth = 1.0
        self.catView4.layer.cornerRadius = 16
        self.catView4.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        self.catView5.layer.borderWidth = 1.0
        self.catView5.layer.cornerRadius = 16
        self.catView5.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        self.catView6.layer.borderWidth = 1.0
        self.catView6.layer.cornerRadius = 16
        self.catView6.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
    }
}
