//
//  SignInVC.swift
//  GitCat
//
//  Created by 조윤영 on 23/12/2019.
//  Copyright © 2019 조윤영. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {
    @IBOutlet weak var loginBtnView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtnView.addShadow()
    }
    @IBAction func signInTouchUpAction(_ sender: UIButton) {
        print("로그인 버튼 선택")
        self.loginBtnView.backgroundColor = UIColor.white
//        sender.setTitleColor(UIColor.CustomColor.skyBlue, for: UIControl.State.normal)

    }
    
    @IBAction func signInTouchDownAction(_ sender: UIButton) {
        self.loginBtnView.backgroundColor = UIColor.CustomColor.skyBlue
//        sender.setTitleColor(UIColor.white, for: UIControl.State.normal)
    }

    @IBAction func signUpAction(_ sender: Any) {
        
    }
    
}
