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
    @IBOutlet weak var publicCheckBoxImage: UIImageView!
    
    @IBOutlet weak var privateAccessLabel: CustomLabel!
    @IBOutlet weak var privateCheckBoxImage: UIImageView!
    
    @IBOutlet weak var sub1Label: CustomLabel!
    @IBOutlet weak var sub2Label: CustomLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackBtn(color: UIColor.CustomColor.brownishGrey)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.CustomColor.brownishGrey]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

        self.setFontSize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setAlpha()
        
        let canAccessPrivateRepo = UserDefaults.standard.bool(forKey: "canAccessPrivate")
        if canAccessPrivateRepo {
            self.publicCheckBoxImage.alpha = 1
        } else {
            self.privateCheckBoxImage.alpha = 1
        }
    }
    
    func setAlpha() {
        self.publicCheckBoxImage.alpha = 0
        self.privateCheckBoxImage.alpha = 0
    }
    
    func setFontSize() {
        self.publicAccessLabel.dynamicFont(fontSize: 17, name: "BBTreeGo_R")
        self.privateAccessLabel.dynamicFont(fontSize: 17, name: "BBTreeGo_R")
        sub1Label.dynamicFont(fontSize: 10, name: "BBTreeGo_R")
        sub2Label.dynamicFont(fontSize: 10, name: "BBTreeGo_R")
    }
    
    @IBAction func checkPublicAccessAction(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "canAccessPrivate")
        self.publicCheckBoxImage.alpha = 1
        self.privateCheckBoxImage.alpha = 0
    }
    
    @IBAction func checkPrivateAccessAction(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "canAccessPrivate")
        self.publicCheckBoxImage.alpha = 0
        self.privateCheckBoxImage.alpha = 1
    }
}
