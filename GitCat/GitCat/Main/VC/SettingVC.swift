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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.deleteNavigationUnderbar()
        
        let imageURL = UserDefaults.standard.string(forKey: "userImage")
        
        userProfileImage.setImage(imageURL, defaultImgPath: "imgDefault")
        userIdLabel.text = UserDefaults.standard.string(forKey: "userId")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userProfileImage.circleRadius()
        userProfileImage.layer.borderColor = UIColor.clear.cgColor
    }
    
    @IBAction func goBackAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func initializeCatAction(_ sender: Any) {
        let cancleModeAction = UIAlertAction(title: "취소", style: .cancel) { (action) in
        }
        let confirmModeAction = UIAlertAction(title: "확인", style: .destructive) { (action) in
            self.setCatInitialized()
        }
        
        let alert = UIAlertController(title: "고양이 초기화", message: "귀여운 고양이들을 보내시겠습니까?     한 번 떠난 고양이는 되돌아오지 못합니다!", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(confirmModeAction)
        alert.addAction(cancleModeAction)
        
        present(alert, animated:true){
            //함수가 성공적으로 수행된 후 작동되는 code
        }
        
    }

}

extension SettingVC {
    func setCatInitialized() {
        DeleteCatService.shareInstance.deleteCat { (result) in
            switch result {
            case .networkSuccess(_):
                break
            case .dataNeeded:
                let dvc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "GetMoreInfo4VC")
                dvc.modalPresentationStyle = .fullScreen
                self.present(dvc, animated: true, completion: nil)
                break
            case .accessDenied:
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
            case .networkFail :
                self.networkErrorAlert()
                break
            default :
                self.simpleAlert(title: "오류", message: "다시 시도해주세요")
                break
            }
        }
    }
}
