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
    
    @IBOutlet weak var withdrawTitleLabel: CustomLabel!
    @IBOutlet weak var withdrawSubTitleLabel1: CustomLabel!
    @IBOutlet weak var withdrawSubTitleLabel2: UILabel!
    @IBOutlet weak var withdrawSubTitleLabel3: UILabel!
    
    @IBOutlet weak var withdrawOkBtn: UIButton!
    @IBOutlet weak var withdrawCancelBtn: UIButton!
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var withdrawCardView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackBtn(color: UIColor.CustomColor.brownishGrey)
        
        userIdLabel.text = UserDefaults.standard.string(forKey: "userId")

        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.CustomColor.brownishGrey]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        
        self.showNavigationUnderBar()
        setAlpha()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        withdrawCardView.roundRadius(radius: 10)
        withdrawCardView.customShadow(width: 1, height: 2, radius: 11, opacity: 0.16)
    }
    
    func setAlpha() {
        backgroundView.alpha = 0;
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
    
    func setFontSize() {
        self.withdrawTitleLabel.dynamicFont(fontSize: 17, name: "System Bold")
        self.withdrawSubTitleLabel1.dynamicFont(fontSize: 13, name: "System")
        self.withdrawSubTitleLabel2.dynamicFont(fontSize: 13, name: "System")
        self.withdrawSubTitleLabel3.dynamicFont(fontSize: 13, name: "System Bold")
        
        self.withdrawOkBtn.titleLabel?.dynamicFont(fontSize: 17, name: "System")
        self.withdrawCancelBtn.titleLabel?.dynamicFont(fontSize: 17, name: "System")
        
    }
    
    @IBAction func wthdrawalAction(_ sender: Any) {
        showWithDrawalAlertSheet()
    }
    
    @IBAction func okWithdrawal(_ sender: Any) {
        self.widthdrawl()
    }
    
    @IBAction func cancelWithdraw(_ sender: Any) {
        dismissWithDrawalAlertSheet()
    }
    
    
    func showWithDrawalAlertSheet() {
        UIView.animate(withDuration: 0.5, delay: 0.5,animations: ({
            self.backgroundView.alpha = 1
            
        }))
    }
    
    func dismissWithDrawalAlertSheet() {
        UIView.animate(withDuration: 0.5, delay: 0.5,animations: ({
            self.backgroundView.alpha = 0
            
        }))
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
