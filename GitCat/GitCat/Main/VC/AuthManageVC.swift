//
//  AuthManageVC.swift
//  GitCat
//
//  Created by 조윤영 on 23/02/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit

class AuthManageVC: UIViewController {

    @IBOutlet weak var userIdLabel: CustomLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackBtn(color: UIColor.CustomColor.brownishGrey)
        
        userIdLabel.text = UserDefaults.standard.string(forKey: "userId")

        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.CustomColor.brownishGrey]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        
        self.showNavigationUnderBar()
    }
    
    @IBAction func LogoutAction(_ sender: Any) {
        let confirmModeAction = UIAlertAction(title: "확인", style: .default) { (action) in
            self.postLogout()
            
        }
        
        let alert = UIAlertController(title: "로그아웃", message: "로그아웃 하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(confirmModeAction)

        present(alert, animated:true){
            //함수가 성공적으로 수행된 후 작동되는 code
        }
    }
    
    @IBAction func wthdrawalAction(_ sender: Any) {
        let confirmModeAction = UIAlertAction(title: "확인", style: .default) { (action) in
            self.widthdrawl()
            
        }
        
        let alert = UIAlertController(title: "회원탈퇴", message: "정말 회원탈퇴 하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(confirmModeAction)

        present(alert, animated:true){
            //함수가 성공적으로 수행된 후 작동되는 code
        }
        
    }
    

}

extension AuthManageVC {
    func postLogout() {

        PostLogoutService.shareInstance.postLogout(completion: { (result) in
            switch result {
                case .networkSuccess( _): //201
                    print("UserData POST SUCCESS")
                    
                    UserDefaults.standard.set(false, forKey: "login")
                    let dvc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "AuthInitiVC")
                    dvc.modalPresentationStyle = .fullScreen
                    
                    self.present(dvc, animated: true, completion: nil)
                    
                    break
                    
                case .badRequest: //400
                    self.simpleAlert(title: "", message: "다시 시도해주세요")
                    break
                    
                case .accessDenied: //401
                    let confirmModeAction = UIAlertAction(title: "확인", style: .default) { (action) in
                        UserDefaults.standard.set(false, forKey: "login")
                        let dvc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "AuthInitiVC")
                        dvc.modalPresentationStyle = .fullScreen
                                       
                        self.present(dvc, animated: true, completion: nil)
                     }
                                   
                    let alert = UIAlertController(title: "로그인 필요", message: "재로그인이 필요합니다", preferredStyle: UIAlertController.Style.alert)
                                   
                    alert.addAction(confirmModeAction)
                    self.present(alert, animated:true)
                    break
                    
                case .networkFail:
                    self.networkErrorAlert()
                    break
                    
                default:
                    self.simpleAlert(title: "오류", message: "다시 시도해주세요")
                    break
            }
        })
    }
    
    func widthdrawl() {
        DeleteUserInfo.shareInstance.withdrawal { (result) in
                switch result {
                case .networkSuccess(_):
                    UserDefaults.standard.set(false, forKey: "login")
                    UserDefaults.standard.set(false, forKey: "signUp")
                    
                    let dvc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "AuthInitiVC")
                    dvc.modalPresentationStyle = .fullScreen
                    self.present(dvc, animated: true, completion: nil)
                    
                    break
                case .dataNeeded:
                    break
                case .networkFail :
                    self.networkErrorAlert()
                    
                default :
                    self.simpleAlert(title: "오류", message: "다시 시도해주세요")
                    break
            }
        }
    }
}
