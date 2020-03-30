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
        self.tabBarController?.tabBar.alpha = 0
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        catView1.layer.borderWidth = 1.0
        catView1.layer.cornerRadius = 16
        catView1.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        catView2.layer.borderWidth = 1.0
        catView2.layer.cornerRadius = 16
        catView2.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        catView3.layer.borderWidth = 1.0
        catView3.layer.cornerRadius = 16
        catView3.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        catView4.layer.borderWidth = 1.0
        catView4.layer.cornerRadius = 16
        catView4.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        catView5.layer.borderWidth = 1.0
        catView5.layer.cornerRadius = 16
        catView5.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        catView6.layer.borderWidth = 1.0
        catView6.layer.cornerRadius = 16
        catView6.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
           
        
        
    }
    
    func setFont() {
        role1.dynamicFont(fontSize: 16, name: "BBTreeG_B")
        role2.dynamicFont(fontSize: 16, name: "BBTreeG_B")
        role3.dynamicFont(fontSize: 16, name: "BBTreeG_B")
        role4.dynamicFont(fontSize: 16, name: "BBTreeG_B")
        role5.dynamicFont(fontSize: 16, name: "BBTreeG_B")
        role6.dynamicFont(fontSize: 16, name: "BBTreeG_B")
        
        name1.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        name2.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        name3.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        name4.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        name5.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        name6.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        
        detail1.dynamicFont(fontSize: 12, name: "BBTreeGo_R")
        detail2.dynamicFont(fontSize: 12, name: "BBTreeGo_R")
        detail3.dynamicFont(fontSize: 12, name: "BBTreeGo_R")
        detail4.dynamicFont(fontSize: 12, name: "BBTreeGo_R")
        detail5.dynamicFont(fontSize: 12, name: "BBTreeGo_R")
        detail6.dynamicFont(fontSize: 12, name: "BBTreeGo_R")
        
        detail1.setLineHeight(lineHeight: 1.5)
        detail2.setLineHeight(lineHeight: 1.5)
        detail3.setLineHeight(lineHeight: 1.5)
        detail4.setLineHeight(lineHeight: 1.5)
        detail5.setLineHeight(lineHeight: 1.5)
        detail6.setLineHeight(lineHeight: 1.5)
        
    }



}
