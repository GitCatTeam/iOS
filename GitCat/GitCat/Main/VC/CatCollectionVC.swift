//
//  CatCollectionVC.swift
//  GitCat
//
//  Created by 조윤영 on 20/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit

class CatCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingBackgroundView: UIView!
    @IBOutlet weak var loadingView: UIImageView!
    
    let cellIdentifier:String = "catCollectionViewcell"
    var catCollectionList = [CatCollectionDataModel]()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setBackBtn(color: #colorLiteral(red: 0.5307495594, green: 0.8041878939, blue: 0.9690385461, alpha: 1))
        
        loadingView.alpha = 1
        loadingBackgroundView.alpha = 1
        
        getCatCollection()
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 137/255, green: 204/255, blue: 246/255, alpha: 1)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let bar: UINavigationBar! = self.navigationController?.navigationBar
        bar.backgroundColor = UIColor.white
        
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catCollectionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CatCollectionCVCell
        
        cell.catNameLabel.text = catCollectionList[indexPath.row].name
        cell.resultLabel.text = catCollectionList[indexPath.row].endingMent
        
        let imageURL = catCollectionList[indexPath.row].img
        cell.catImageView.setImage(imageURL, defaultImgPath: "imgDefault")
        
        if(catCollectionList[indexPath.row].isMedal == true) {
            cell.medalImageView.alpha = 1
        }else {
            cell.medalImageView.alpha = 0
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (view.frame.width - 42) / 2
        let height: CGFloat = ((view.frame.width - 42) / 2) * 0.8 + 53
        
        if UIDevice.current.model.hasPrefix("iPad") {
            let width: CGFloat = (view.frame.width - 42) / 3 - 10
            let height: CGFloat = ((view.frame.width - 42) / 3) + 53
            return CGSize(width: width, height: height)
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        }


}


extension CatCollectionVC {
    func getCatCollection() {
        CatCollectionService.sharedInstance.getGraduateCats { (result) in
        switch result {
        case .networkSuccess(let data):
            let graduateCatData = data as? CatCollectionModel
            if let resResult = graduateCatData {
                self.catCollectionList = resResult.data ?? []
                self.collectionView.reloadData()
                self.loadingView.alpha = 0
                self.loadingBackgroundView.alpha = 0
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
        case .networkFail :
            self.networkErrorAlert()
            self.loadingView.alpha = 0
            self.loadingBackgroundView.alpha = 0
            break
                                
        default:
            self.simpleAlert(title: "오류 발생!", message: "다시 시도해주세요")
            self.loadingView.alpha = 0
            self.loadingBackgroundView.alpha = 0
            break
            }
                        
        }
    }
                
}
