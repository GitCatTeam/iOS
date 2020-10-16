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
    
    @IBOutlet weak var FAQLabel: CustomLabel!
    @IBOutlet weak var instagramLabel: CustomLabel!
    @IBOutlet weak var feedbackLabel: CustomLabel!
    @IBOutlet weak var settingLabel: CustomLabel!
    @IBOutlet weak var etcLabel: CustomLabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.deleteNavigationUnderbar()
        self.setFontSize()
        self.setLocalization()
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
    }
    
    @IBAction func goBackAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func changeAccessibilityAction(_ sender: Any) {
        let cancelTitle = "Cancel".localized()
        let okTitle = "OK".localized()
        let permissionChangeTitle =  "Change GitHub Repository Permission".localized()
        let permissionChangeMessage = "Do you want to change your permission?                                              you need to signIn again".localized()
        let cancelModeAction = UIAlertAction(title: cancelTitle, style: .cancel)
        let confirmModeAction = UIAlertAction(title: okTitle, style: .default) { (action) in
            UserDefaults.standard.removeObject(forKey: "canAccessPrivate")
            self.deleteDeviceToken()
        }
        
        let alert = UIAlertController(title: permissionChangeTitle, message:permissionChangeMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(cancelModeAction)
        alert.addAction(confirmModeAction)

        present(alert, animated:true)
    }
    
    @IBAction func initializeCatAction(_ sender: Any) {
        let cancelTitle = "Cancel".localized()
        let okTitle = "OK".localized()
        let cancleModeAction = UIAlertAction(title: cancelTitle, style: .cancel) { (action) in
        }
        let confirmModeAction = UIAlertAction(title: okTitle, style: .destructive) { (action) in
            self.setCatInitialized()
        }
        
        let initializeCatTitle = "Reset Coding Buddies".localized()
        let intializeCatMessage = "Would you like to let go of all your adorable cats?                                    Released cats cannot be brought back.".localized()
        let alert = UIAlertController(title: initializeCatTitle, message: intializeCatMessage, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(confirmModeAction)
        alert.addAction(cancleModeAction)
        
        present(alert, animated:true){
            //함수가 성공적으로 수행된 후 작동되는 code
        }
    }
    
    @IBAction func sendFeedbackAction(_ sender: Any) {
        
    }
    
}
