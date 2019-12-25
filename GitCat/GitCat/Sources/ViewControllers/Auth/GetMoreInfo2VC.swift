//
//  GetMoreInfo2VC.swift
//  GitCat
//
//  Created by 조윤영 on 24/12/2019.
//  Copyright © 2019 조윤영. All rights reserved.
//

import UIKit

class GetMoreInfo2VC: UIViewController {

    @IBOutlet weak var nextBtn2: UIButton!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn2.addShadow()
        birthDatePicker.setValue(UIColor.CustomColor.skyBlue, forKey: "textColor")
        
        

    }
    @IBAction func moveNext2TouchDownAction(_ sender: UIButton) {
        sender.backgroundColor = UIColor.CustomColor.skyBlue
        
    }
    
    @IBAction func moveNext2TouchUpAction(_ sender: UIButton) {
        sender.backgroundColor = UIColor(red: 220/255, green: 221/255, blue: 225/255, alpha: 1)
        
        if let dvc = storyboard? .instantiateViewController(withIdentifier: "GetMoreInfo3VC") as? GetMoreInfo3VC {
            
            self.navigationController?.pushViewController(dvc, animated: true)
            
        }
        
    }
    
    

}
