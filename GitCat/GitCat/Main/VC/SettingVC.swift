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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackBtn(color: #colorLiteral(red: 0.5307495594, green: 0.8041878939, blue: 0.9690385461, alpha: 1))
        ///////////////////////////////////////////////////
        //FIXME:디폴트 이미지 넣기
        ///////////////////////////////////////////////////
        
        let imageURL = UserDefaults.standard.string(forKey: "userImage")
        userProfileImage.setImage(imageURL, defaultImgPath: "")
    }
    @IBAction func initializeCatAction(_ sender: Any) {
        let cancleModeAction = UIAlertAction(title: "취소", style: .cancel) { (action) in
        }
        let confirmModeAction = UIAlertAction(title: "확인", style: .destructive) { (action) in
        }
        
        let alert = UIAlertController(title: "고양이 초기화", message: "귀여운 고양이들을 보내시겠습니까?     한 번 떠난 고양이는 되돌아오지 못합니다!", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(confirmModeAction)
        alert.addAction(cancleModeAction)
        
        
        
        present(alert, animated:true){
            //함수가 성공적으로 수행된 후 작동되는 code
        }
        
    }
    

}
