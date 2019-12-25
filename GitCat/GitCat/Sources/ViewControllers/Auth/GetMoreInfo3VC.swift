//
//  GetMoreInfo3VC.swift
//  GitCat
//
//  Created by 조윤영 on 25/12/2019.
//  Copyright © 2019 조윤영. All rights reserved.
//

import UIKit

class GetMoreInfo3VC: UIViewController {
    
    @IBOutlet weak var interestInDevBtn: LittleRoundBtn!
    @IBOutlet weak var studentBtn: LittleRoundBtn!
    @IBOutlet weak var OneYearDevBtn: LittleRoundBtn!
    @IBOutlet weak var ThreeYearDevBtn: LittleRoundBtn!
    @IBOutlet weak var MoreThanFiveYearDevBtn: LittleRoundBtn!
    
    @IBOutlet weak var nextBtn3: RoundBtn!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonSelect()
        setButtonColor()
        nextBtn3.addShadow()
    }
    @IBAction func chooseCareer(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender == interestInDevBtn && interestInDevBtn.isSelected {
            
            interestInDevBtn.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
            
            studentBtn.isSelected = false
             studentBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
            OneYearDevBtn.isSelected = false
             OneYearDevBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
            ThreeYearDevBtn.isSelected = false
             ThreeYearDevBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
            MoreThanFiveYearDevBtn.isSelected = false
             MoreThanFiveYearDevBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
            
        }else if sender == studentBtn && studentBtn.isSelected {
            studentBtn.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
            
            interestInDevBtn.isSelected = false
            interestInDevBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
            OneYearDevBtn.isSelected = false
            OneYearDevBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
            ThreeYearDevBtn.isSelected = false
            ThreeYearDevBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
            MoreThanFiveYearDevBtn.isSelected = false
            MoreThanFiveYearDevBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
            
        } else if sender == OneYearDevBtn && OneYearDevBtn.isSelected {
            OneYearDevBtn.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
            
            studentBtn.isSelected = false
            studentBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
            interestInDevBtn.isSelected = false
            interestInDevBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
            ThreeYearDevBtn.isSelected = false
            ThreeYearDevBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
            MoreThanFiveYearDevBtn.isSelected = false
            MoreThanFiveYearDevBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
        } else if sender == ThreeYearDevBtn && ThreeYearDevBtn.isSelected {
            ThreeYearDevBtn.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
            
            studentBtn.isSelected = false
            studentBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
            interestInDevBtn.isSelected = false
            interestInDevBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
            OneYearDevBtn.isSelected = false
            OneYearDevBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
            MoreThanFiveYearDevBtn.isSelected = false
            MoreThanFiveYearDevBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
        } else if sender == MoreThanFiveYearDevBtn && MoreThanFiveYearDevBtn.isSelected {
            MoreThanFiveYearDevBtn.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
            
            studentBtn.isSelected = false
            studentBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
            interestInDevBtn.isSelected = false
            interestInDevBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
            OneYearDevBtn.isSelected = false
            OneYearDevBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
            ThreeYearDevBtn.isSelected = false
            ThreeYearDevBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
        } else{
            
            interestInDevBtn.isSelected = false
            interestInDevBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
            studentBtn.isSelected = false
            studentBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
            interestInDevBtn.isSelected = false
            interestInDevBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
            OneYearDevBtn.isSelected = false
            OneYearDevBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
            ThreeYearDevBtn.isSelected = false
            ThreeYearDevBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
        }
    }
    
    @IBAction func moveNext3TouchDownAction(_ sender: UIButton) {
        sender.backgroundColor = UIColor.CustomColor.skyBlue
    }
    
    @IBAction func moveNext3TouchUpAction(_ sender: UIButton) {
        sender.backgroundColor = UIColor(red: 220/255, green: 221/255, blue: 225/255, alpha: 1)
        
        if let dvc = storyboard? .instantiateViewController(withIdentifier: "GetMoreInfo4VC") as? GetMoreInfo4VC {
            self.navigationController?.pushViewController(dvc, animated: true)
        }
    }
    
    
    func setButtonSelect() {
        interestInDevBtn.isSelected = false
        studentBtn.isSelected = false
        OneYearDevBtn.isSelected = false
        ThreeYearDevBtn.isSelected = false
        MoreThanFiveYearDevBtn.isSelected = false
    }
    
    func setButtonColor() {
        
        interestInDevBtn.setTitleColor(UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), for: UIControl.State.normal)
        interestInDevBtn.setTitleColor(UIColor.CustomColor.skyBlue, for: UIControl.State.selected)
        interestInDevBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor

        studentBtn.setTitleColor(UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), for: UIControl.State.normal)
        studentBtn.setTitleColor(UIColor.CustomColor.skyBlue, for: UIControl.State.selected)
        studentBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
        
        OneYearDevBtn.setTitleColor(UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), for: UIControl.State.normal)
        OneYearDevBtn.setTitleColor(UIColor.CustomColor.skyBlue, for: UIControl.State.selected)
        OneYearDevBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
        
        ThreeYearDevBtn.setTitleColor(UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), for: UIControl.State.normal)
        ThreeYearDevBtn.setTitleColor(UIColor.CustomColor.skyBlue, for: UIControl.State.selected)
        ThreeYearDevBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
        
        MoreThanFiveYearDevBtn.setTitleColor(UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1), for: UIControl.State.normal)
        MoreThanFiveYearDevBtn.setTitleColor(UIColor.CustomColor.skyBlue, for: UIControl.State.selected)
        MoreThanFiveYearDevBtn.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
    }

}
