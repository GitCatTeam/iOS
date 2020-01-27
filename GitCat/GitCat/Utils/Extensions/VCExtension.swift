//
//  VCExtension.swift
//  GitCat
//
//  Created by 조윤영 on 25/12/2019.
//  Copyright © 2019 조윤영. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func gsno(_ value : String?) -> String{
        if let _value = value{
            return _value
        }else{
            return ""
        }
    }
    func gino(_ value : Int?) -> Int{
        if let _value = value{
            return _value
        }else{
            return -1
        }
    }
    func gfno(_ value : Float?) -> Float{
        if let _value = value{
            return _value
        }else{
            return -1.0
        }
    }
    func gdno(_ value : Double?) -> Double{
        if let _value = value{
            return _value
        }else{
            return -1.0
        }
    }
    func gbno(_ value : Bool?) -> Bool {
        if let _value = value {
            return _value
        }else {
            return false
        }
    }
    //네트워크 에러 팝업
    func networkErrorAlert() {
        
        let alert = UIAlertController(title: "네트워크 오류", message: "네트워크 상태를 확인해주세요", preferredStyle: .alert)
        alert.view.tintColor = UIColor.CustomColor.skyBlue
        let okAction = UIAlertAction(title: "확인",style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    //Toast
    func showToast(controller: UIViewController, message : String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        controller.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    //백버튼 색만 바꾸기
    func setBackBtnColor(color : UIColor){
        navigationItem.leftBarButtonItem?.tintColor = color
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
    }
    //커스텀 백버튼 설정
    func setBackBtn(color : UIColor){
        
        let backBTN = UIBarButtonItem(image: UIImage(named: "icBack"), //백버튼 이미지 파일 이름에 맞게 변경해주세요.
            style: .plain,
            target: self,
            action: #selector(self.pop))
        navigationItem.leftBarButtonItem = backBTN
        navigationItem.leftBarButtonItem?.tintColor = color
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
    }
    //네비게이션 바 투명하게 하는 함수
    func setNavigationBar() {
        let bar: UINavigationBar! = self.navigationController?.navigationBar
        bar.backgroundColor = UIColor.clear
        
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        
    }
    //확인 팝업
    func simpleAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인",style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    //확인, 취소 팝업
    func simpleAlertwithHandler(title: String, message: String, okHandler : ((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인",style: .default, handler: okHandler)
        let cancelAction = UIAlertAction(title: "취소",style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func pop(){
        self.navigationController?.popViewController(animated: true)
    }
    
    //커스텀 팝업 띄우기 애니메이션
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    //커스텀 팝업 끄기 애니메이션
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
}
