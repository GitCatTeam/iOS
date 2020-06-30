//
//  GetMoreInfo4VC+NetworkExtension.swift
//  GitCat
//
//  Created by 조윤영 on 2020/06/20.
//  Copyright © 2020 조윤영. All rights reserved.
//
import UIKit

extension GetMoreInfo4VC {
    func setCatList() {
        CatListService.sharedInstance.getCatList { (result) in
            switch result {
            case .networkSuccess(let data):
                let catListData = data as? CatListModel
                if let resResult = catListData {
                    self.commonCatList = resResult.data?.normal ?? []
                    self.specialCatList = resResult.data?.special ?? []

                    if(resResult.data?.isNewExist == true) {
                        self.newCatList = resResult.data?.new ?? []
                        self.pageControl.numberOfPages = self.newCatList.count

                        self.newCatCollectionView.reloadData()
                        self.showNewCatListView()
                    }
                    self.currentCatList = self.commonCatList;
                    self.collectionView.reloadData()
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
            case .maintainance(let data)://419
                let maintainDateData = data as? MaintainanceModel
                if let resResult = maintainDateData {
                    let startTime = resResult.startTime
                    let endTime = resResult.endTime
                    self.simpleAlert(title: "서버 점검", message: "더 나은 서비스를 위해    잠시 서버 점검 중입니다.   \(String(describing: startTime))시 ~ \(String(describing: endTime))시까지 서버")
                }
                break
            case .networkFail :
                self.networkErrorAlert()
                break
                    
            default:
                self.simpleAlert(title: "오류 발생!", message: "다시 시도해주세요")
                break
             }
        }
    }
    
    func postCat(catId:Int?, catName: String?) {
        let params : [String : Any] =
            ["catId" : catId ?? "",
             "catName" : catName ?? "",
             ]
        
        PostCatSelectedService.shareInstance.postCatSelection(params: params) {(result) in
            switch result {
            case .networkSuccess( _): //201
                print("Cat Selection POST SUCCESS")
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
                self.catNameTextField.text = ""
                break
            }
        }
    }
}
