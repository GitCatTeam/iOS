//
//  SignInVC.swift
//  GitCat
//
//  Created by 조윤영 on 23/12/2019.
//  Copyright © 2019 조윤영. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {
    
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        loginBtn.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
        loginBtn.addShadow()
        
    }
    
    @IBAction func signInTouchUpAction(_ sender: UIButton) {
        
        sender.backgroundColor = UIColor.white
        sender.setTitleColor(UIColor.CustomColor.skyBlue, for: UIControl.State.normal)
        
        //상태에 따른 이동
        //if github 계정이 있다면?
        
        if let dvc = storyboard? .instantiateViewController(withIdentifier: "GetMoreInfo1VC") as? GetMoreInfo1VC {

            self.navigationController?.pushViewController(dvc, animated: true)
        }
    }
    
    @IBAction func signInTouchDownAction(_ sender: UIButton) {
        sender.backgroundColor = UIColor.CustomColor.skyBlue
        sender.setTitleColor(UIColor.white, for: UIControl.State.normal)
    }

    @IBAction func signUpAction(_ sender: Any) {
        
    }
    
}
