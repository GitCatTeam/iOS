//
//  AuthManageVC.swift
//  GitCat
//
//  Created by 조윤영 on 23/02/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit

class AuthManageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackBtn(color: UIColor.CustomColor.brownishGrey)
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.CustomColor.brownishGrey]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    @IBAction func LogoutAction(_ sender: Any) {
        let confirmModeAction = UIAlertAction(title: "확인", style: .default) { (action) in
        }
        
        let alert = UIAlertController(title: "로그아웃", message: "로그아웃 하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(confirmModeAction)

        present(alert, animated:true){
            //함수가 성공적으로 수행된 후 작동되는 code
        }
    }

}
