//
//  UserDataInitVC.swift
//  GitCat
//
//  Created by 조윤영 on 05/03/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit

class UserDataInitVC: UIViewController {

    @IBOutlet weak var loadingView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.loadGif(name: "gif_cat_loading")
        checkTokenExpired()
        postUserData()
    
    }
    
    func checkTokenExpired() {
        PostUserDataService.shareInstance.checkTokenExpired()
    }
    
    
    func postUserData() {

        PostUserDataService.shareInstance.postUserData { (result) in
            switch result {
                case .networkSuccess( _): //201
                    print("UserData POST SUCCESS")
                    let dvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "MainTabC")
                    
                    dvc.modalPresentationStyle = .fullScreen
                    
                    self.present(dvc, animated: true, completion: nil)
                    break
                    
                //FIXME: 수정
                case .badRequest: //400
                    self.simpleAlert(title: "", message: "다시 시도해주세요")
                    break
                    
                case .duplicated: //401
                    
                    self.simpleAlert(title: "", message: "권한이 없습니다.")
                    break
                    
                case .networkFail:
                    self.networkErrorAlert()
                    break
                    
                default:
                    self.simpleAlert(title: "오류", message: "다시 시도해주세요")
                    break
            }
        }
    }

}
