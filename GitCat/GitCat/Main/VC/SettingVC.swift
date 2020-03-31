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
        setBackBtn(color: #colorLiteral(red: 0.5307495594, green: 0.8041878939, blue: 0.9690385461, alpha: 1))
        
        let imageURL = UserDefaults.standard.string(forKey: "userImage")
        
        userProfileImage.setImage(imageURL, defaultImgPath: "imgDefault")
        userIdLabel.text = UserDefaults.standard.string(forKey: "userId")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userProfileImage.circleRadius()
        userProfileImage.layer.borderColor = UIColor.clear.cgColor
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
            case .networkFail :
                self.networkErrorAlert()
                
            default :
                self.simpleAlert(title: "오류", message: "다시 시도해주세요")
                break
            }
        }
    }
}
