//
//  AlarmVC.swift
//  GitCat
//
//  Created by 조윤영 on 20/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit

class AlarmVC: UIViewController {

    @IBOutlet weak var pushAlarmSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "알림 설정"

        setBackBtn(color: UIColor.CustomColor.brownishGrey)
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.CustomColor.brownishGrey]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        
        if(UserDefaults.standard.bool(forKey: "pushAlarm")) {
            pushAlarmSwitch.isOn = true;
        }else {
            pushAlarmSwitch.isOn = false;
        }
        
        
    }
    @IBAction func selectAlarmSystemAction(_ sender: Any) {
        let bellModeAction = UIAlertAction(title: "벨소리", style: .default) { (action) in
            print("벨소리 선택")
        }
        let silentModeAction = UIAlertAction(title: "진동", style: .default) { (action) in
            print("진동 선택")
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (action) in
            print("취소")
        }
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        alert.addAction(bellModeAction)
        alert.addAction(silentModeAction)
        alert.addAction(cancelAction)
        
        present(alert, animated:true){
            //함수가 성공적으로 수행된 후 작동되는 code
        }
        
    }
    

}
