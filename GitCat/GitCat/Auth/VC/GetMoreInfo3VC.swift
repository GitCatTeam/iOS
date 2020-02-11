//
//  GetMoreInfo3VC.swift
//  GitCat
//
//  Created by 조윤영 on 25/12/2019.
//  Copyright © 2019 조윤영. All rights reserved.
//

import UIKit

class GetMoreInfo3VC: UIViewController {
    @IBOutlet weak var MainTitle: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    @IBOutlet weak var interestInDevBtn: LittleRoundBtn!
    @IBOutlet weak var studentBtn: LittleRoundBtn!
    @IBOutlet weak var OneYearDevBtn: LittleRoundBtn!
    @IBOutlet weak var ThreeYearDevBtn: LittleRoundBtn!
    @IBOutlet weak var MoreThanFiveYearDevBtn: LittleRoundBtn!
    
    @IBOutlet weak var nextBtn3: RoundBtn!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackBtn(color: UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1))
        setButtonSelect()
        setButtonColor()
        nextBtn3.addShadow()
        initAlpha()
        
        nextBtn3.isEnabled = false
        animateView()

    }
    
    @IBAction func chooseCareer(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        nextBtn3.isEnabled = true
        nextBtn3.backgroundColor = UIColor.CustomColor.skyBlue
        
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
        
        interestInDevBtn.setTitleColor(#colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1), for: UIControl.State.normal)
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

    /**
     구현함수
     */
    func animateView() {
        UIView.animate(withDuration: 0.5, delay: 0.5,animations: ({
            self.MainTitle.alpha = 1
            self.subTitle.alpha = 1
            self.interestInDevBtn.alpha = 1
            self.studentBtn.alpha = 1
            self.OneYearDevBtn.alpha = 1
            self.ThreeYearDevBtn.alpha = 1
            self.MoreThanFiveYearDevBtn.alpha = 1
        }))
    }
    func initAlpha() {
        self.MainTitle.alpha = 0
        self.subTitle.alpha = 0
        self.interestInDevBtn.alpha = 0
        self.studentBtn.alpha = 0
        self.OneYearDevBtn.alpha = 0
        self.ThreeYearDevBtn.alpha = 0
        self.MoreThanFiveYearDevBtn.alpha = 0
    }
    
}
