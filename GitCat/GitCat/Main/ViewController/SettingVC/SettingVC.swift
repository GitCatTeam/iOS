//
//  SettingVC.swift
//  GitCat
//
//  Created by 조윤영 on 27/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {

    @IBOutlet weak var userProfileImage: RoundImageView!
    @IBOutlet weak var userIdLabel: CustomLabel!
    @IBOutlet weak var authManageLAbel: CustomLabel!
    @IBOutlet weak var accessManageLabel: CustomLabel!
    @IBOutlet weak var alaramManageLabel: CustomLabel!
    @IBOutlet weak var catInitialBtn: UIButton!
    @IBOutlet weak var introduceDeveloperLabel: CustomLabel!
    @IBOutlet weak var instagramLabel: CustomLabel!
    
    @IBOutlet weak var settingLabel: CustomLabel!
    @IBOutlet weak var etcLabel: CustomLabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.deleteNavigationUnderbar()
        self.setFontSize()
        
        let imageURL = UserDefaults.standard.string(forKey: "userImage")
        
        userProfileImage.setImage(imageURL, defaultImgPath: "imgDefault")
        userIdLabel.text = UserDefaults.standard.string(forKey: "userId")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.userProfileImage.circleRadius()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.userProfileImage.circleRadius()
        self.userProfileImage.layer.borderColor = UIColor.clear.cgColor
    }

    func setFontSize() {
        userIdLabel.dynamicFont(fontSize: 20, name: "BBTreeG_B")
        authManageLAbel.dynamicFont(fontSize: 16, name: "BBTreeGo_R")
        accessManageLabel.dynamicFont(fontSize: 16, name: "BBTreeGo_R")
        alaramManageLabel.dynamicFont(fontSize: 16, name: "BBTreeGo_R")
        catInitialBtn.titleLabel?.dynamicFont(fontSize: 16, name: "BBTreeGo_R")
        settingLabel.dynamicFont(fontSize: 12, name: "BBTreeGo_R")
        etcLabel.dynamicFont(fontSize: 12, name: "BBTreeGo_R")
        introduceDeveloperLabel.dynamicFont(fontSize: 16, name: "BBTreeGo_R")
        instagramLabel.dynamicFont(fontSize: 16, name: "BBTreeGo_R")
    }
    
    @IBAction func goBackAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func changeAccessibilityAction(_ sender: Any) {
        let cancelModeAction = UIAlertAction(title: "취소", style: .cancel)
        let confirmModeAction = UIAlertAction(title: "확인", style: .default) { (action) in
            UserDefaults.standard.removeObject(forKey: "canAccessPrivate")
            self.deleteDeviceToken()
        }
        
        let alert = UIAlertController(title: "권한 설정 변경", message: "권한을 변경하시겠습니까?                          변경 시, 재로그인이 필요합니다.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(cancelModeAction)
        alert.addAction(confirmModeAction)

        present(alert, animated:true)
    }
    
    @IBAction func initializeCatAction(_ sender: Any) {
        let cancleModeAction = UIAlertAction(title: "취소", style: .cancel) { (action) in
        }
        let confirmModeAction = UIAlertAction(title: "확인", style: .destructive) { (action) in
            self.setCatInitialized()
        }
        
        let alert = UIAlertController(title: "고양이 초기화", message: "귀여운 고양이들을 보내시겠습니까?             한 번 떠난 고양이는 되돌아오지 못합니다!", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(confirmModeAction)
        alert.addAction(cancleModeAction)
        
        present(alert, animated:true){
            //함수가 성공적으로 수행된 후 작동되는 code
        }
    }
}
