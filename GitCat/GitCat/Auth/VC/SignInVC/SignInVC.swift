//
//  SignInVC.swift
//  GitCat
//
//  Created by 조윤영 on 23/12/2019.
//  Copyright © 2019 조윤영. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class SignInVC: UIViewController{
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var subTitleLabel: CustomLabel!

    var userEmail:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setLabelSize()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.loginBtn.circleRadius()
        self.loginBtn.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
        self.loginBtn.customShadow(width: 1, height: 1, radius: 2, opacity: 0.1)
    }

    @IBAction func signInTouchUpAction(_ sender: UIButton) {
        sender.backgroundColor = UIColor.white
        sender.setTitleColor(UIColor.CustomColor.skyBlue, for: UIControl.State.normal)
        
        if !isKeyPresentInUserDefaults(key: "canAccessPrivate") {
            let dvc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "GetAccessVC")
            dvc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(dvc, animated: true)
        } else {
            let dvc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "OAuthVC")
            dvc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(dvc, animated: true)
        }
    }
    
    @IBAction func signInTouchDownAction(_ sender: UIButton) {
        sender.backgroundColor = UIColor.CustomColor.skyBlue
        sender.setTitleColor(UIColor.white, for: UIControl.State.highlighted)
        
    }
    
    func setLabelSize() {
        subTitleLabel.dynamicFont(fontSize: 17, name: "BBTreeGo_R")
        loginBtn.titleLabel?.dynamicFont(fontSize: 14, name:"BBTreeG_B")
        
    }
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}

