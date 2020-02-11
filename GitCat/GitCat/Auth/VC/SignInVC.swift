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
    
    var signInData : SignInCodeData?
    var userEmail:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        loginBtn.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
        loginBtn.addShadow()

    }

    @IBAction func signInTouchUpAction(_ sender: UIButton) {
        
        sender.backgroundColor = UIColor.white
        sender.setTitleColor(UIColor.CustomColor.skyBlue, for: UIControl.State.normal)
        
        signIn()
        
    }
    
    @IBAction func signInTouchDownAction(_ sender: UIButton) {
      
        
        sender.backgroundColor = UIColor.CustomColor.skyBlue
        sender.setTitleColor(UIColor.white, for: UIControl.State.normal)
    }

    @IBAction func signUpAction(_ sender: Any) {
        
    }
    
}



extension SignInVC {
    func signIn() {
        AuthService.sharedInstance.getUserEmail(completion: { (result) in
            switch result {
            case .networkSuccess(let data) :
                let detailData = data as? SignInCodeData
                
                if let resResult = detailData {
                    
                    self.signInData = resResult
                    
                    print(self.signInData?.message ?? "")
                    self.userEmail = self.signInData?.data?.email
                    print("email:\(self.userEmail)")
//                    UserDefaults.standard.set(self.userEmail, forKey: "userEmail")
                }
                break
                
            case .networkFail :
                self.networkErrorAlert()
                
            default:
                self.simpleAlert(title: "오류 발생!", message: "다시 시도해주세요")
                break
            }
        })
    }
    
}
