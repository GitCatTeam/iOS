//
//  AuthManageVC.swift
//  GitCat
//
//  Created by 조윤영 on 23/02/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit

class AuthManageVC: UIViewController {

    @IBOutlet weak var userIdDescLabel: CustomLabel!
    @IBOutlet weak var userIdLabel: CustomLabel!
    @IBOutlet weak var logoutLabel: UILabel!
    @IBOutlet weak var resignLabel: UILabel!
    
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
        
        self.userIdLabel.text = gsno(UserDefaults.standard.string(forKey: "userId"))

        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.CustomColor.brownishGrey]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        self.setAlpha()
        self.setFontSize()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        withdrawCardView.roundRadius(radius: 10)
        withdrawCardView.customShadow(width: 1, height: 2, radius: 11, opacity: 0.16)
    }
    
    func setFontSize() {
        self.userIdDescLabel.dynamicFont(fontSize: 16, name: "BBTreeGo_R")
        self.userIdLabel.dynamicFont(fontSize: 16, name: "BBTreeG_L")
        self.logoutLabel.dynamicFont(fontSize: 16, name: "BBTreeGo_R")
        self.resignLabel.dynamicFont(fontSize: 16, name: "BBTreeGo_R")
    }
    
    func setAlpha() {
        backgroundView.alpha = 0;
    }
    
    @IBAction func LogoutAction(_ sender: Any) {
        let cancelModeAction = UIAlertAction(title: "취소", style: .cancel)
        let confirmModeAction = UIAlertAction(title: "확인", style: .default) { (action) in
            
            //deviceToken && isPrivate 관련 삭제하기
            UserDefaults.standard.removeObject(forKey: "canAccessPrivate")
            self.deleteDeviceTokenWhenLogout()
        }
        
        let alert = UIAlertController(title: "로그아웃", message: "로그아웃 하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(cancelModeAction)
        alert.addAction(confirmModeAction)

        present(alert, animated:true)
    }
    
    @IBAction func wthdrawalAction(_ sender: Any) {
        showWithDrawalAlertSheet()
    }
    
    @IBAction func okWithdrawal(_ sender: Any) {
        //deviceToken && isPrivate 관련 삭제하기
        UserDefaults.standard.removeObject(forKey: "canAccessPrivate")
        self.deleteDeviceTokenWhenWidthdrawl()
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
