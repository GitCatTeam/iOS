//
//  UserDataInitVC.swift
//  GitCat
//
//  Created by 조윤영 on 05/03/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit
import Alamofire

class UserDataInitVC: UIViewController {

    @IBOutlet weak var loadingView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.loadGif(name: "gif_cat_loading")
 
        postUserData()
    
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
                    
                case .accessDenied: //401
                    self.refresh()
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
    
    func refresh() {
    
        let getRefreshHeaders: HTTPHeaders = [
            "Authorization":UserDefaults.standard.string(forKey: "refreshToken")!
        ]
    
        RefreshJWTService.sharedInstance.getRefreshToken(headers: getRefreshHeaders) { (result) in
            switch result {
                case .networkSuccess(let data) :
                 print("들어오기는 하는거야?")
                    let refreshData = data as? RefreshTokenModel
                        
                    if let resResult = refreshData {
                            
                     //FIXME
                     UserDefaults.standard.set(resResult.data?.accessToken, forKey: "token")
                     UserDefaults.standard.set(resResult.data?.refreshToken, forKey: "refreshToken")
                        
                     self.postUserData()
                    }
                 
                 
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
                    
                case .dataNeeded:
                    break
                case .networkFail :
                    break
                                    
                default:
                    break
            }
        }
    }

}
