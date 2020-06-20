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
    
    @IBOutlet weak var interestInDevBtn: UIButton!
    @IBOutlet weak var studentBtn: UIButton!
    @IBOutlet weak var OneYearDevBtn: UIButton!
    @IBOutlet weak var ThreeYearDevBtn: UIButton!
    @IBOutlet weak var MoreThanFiveYearDevBtn: LittleRoundBtn!
    
    @IBOutlet weak var nextBtn3: RoundBtn!
    @IBOutlet weak var pageLabel: UILabel!
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var userCareer:String? = "개발에 관심이 있음"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackBtn(color: UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1))
        setButtonSelect()
        setButtonColor()
        nextBtn3.addShadow()
        initAlpha()
        
        nextBtn3.isEnabled = false
        animateView()
        setLabelSize()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
        self.nextBtn3.circleRadius()
        setButtonStyle()
        
    }
    
    func setButtonStyle() {
        self.interestInDevBtn.layer.borderWidth = 1.0
        self.interestInDevBtn.layer.cornerRadius = 12
        self.interestInDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        self.studentBtn.layer.borderWidth = 1.0
        self.studentBtn.layer.cornerRadius = 12
        self.studentBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        self.OneYearDevBtn.layer.borderWidth = 1.0
        self.OneYearDevBtn.layer.cornerRadius = 12
        self.OneYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        self.ThreeYearDevBtn.layer.borderWidth = 1.0
        self.ThreeYearDevBtn.layer.cornerRadius = 12
        self.ThreeYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        self.MoreThanFiveYearDevBtn.layer.borderWidth = 1.0
        self.MoreThanFiveYearDevBtn.layer.cornerRadius = 12
        self.MoreThanFiveYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)

    }
    
    func setLabelSize() {
        self.MainTitle.dynamicFont(fontSize: 22, name:"BBTreeG_B")
        self.subTitle.dynamicFont(fontSize: 13, name:"BBTreeGo_R")
        
        self.interestInDevBtn.titleLabel?.dynamicFont(fontSize: 16, name:"BBTreeGo_R")
        self.studentBtn.titleLabel?.dynamicFont(fontSize: 16, name:"BBTreeGo_R")
        self.OneYearDevBtn.titleLabel?.dynamicFont(fontSize: 16, name:"BBTreeGo_R")
        self.ThreeYearDevBtn.titleLabel?.dynamicFont(fontSize: 16, name:"BBTreeGo_R")
        self.MoreThanFiveYearDevBtn.titleLabel?.dynamicFont(fontSize: 16, name:"BBTreeGo_R")
        
        self.nextBtn3.titleLabel?.dynamicFont(fontSize: 16, name:"BBTreeG_B")
        self.pageLabel.dynamicFont(fontSize: 11, name:"BBTreeGo_R")
    }
    
    @IBAction func chooseCareer(_ sender: UIButton) {
        sender.isSelected = true
        self.nextBtn3.isEnabled = true
        self.nextBtn3.backgroundColor = UIColor.CustomColor.skyBlue
        
        if sender == self.interestInDevBtn && self.interestInDevBtn.isSelected {
            
            userCareer = "개발에 관심이 있음"
            self.interestInDevBtn.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
            
            self.studentBtn.isSelected = false
            self.studentBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            self.OneYearDevBtn.isSelected = false
            self.OneYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            self.ThreeYearDevBtn.isSelected = false
            self.ThreeYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            self.MoreThanFiveYearDevBtn.isSelected = false
            self.MoreThanFiveYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            
        } else if sender == self.studentBtn && self.studentBtn.isSelected {
            userCareer = "관련 학부생/대학원생"
            
            self.studentBtn.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
            
            self.interestInDevBtn.isSelected = false
            self.interestInDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            self.OneYearDevBtn.isSelected = false
            self.OneYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            self.ThreeYearDevBtn.isSelected = false
            self.ThreeYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            self.MoreThanFiveYearDevBtn.isSelected = false
            self.MoreThanFiveYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            
        } else if sender == self.OneYearDevBtn && self.OneYearDevBtn.isSelected {
            userCareer = "1년차"
            
            self.OneYearDevBtn.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
            
            self.studentBtn.isSelected = false
            self.studentBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            self.interestInDevBtn.isSelected = false
            self.interestInDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            self.ThreeYearDevBtn.isSelected = false
            self.ThreeYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            self.MoreThanFiveYearDevBtn.isSelected = false
            self.MoreThanFiveYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            
        } else if sender == self.ThreeYearDevBtn && self.ThreeYearDevBtn.isSelected {
            userCareer = "3년차"
            
            self.ThreeYearDevBtn.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
            
            self.studentBtn.isSelected = false
            self.studentBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            self.interestInDevBtn.isSelected = false
            self.interestInDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            self.OneYearDevBtn.isSelected = false
            self.OneYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            self.MoreThanFiveYearDevBtn.isSelected = false
            self.MoreThanFiveYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            
        } else if sender == self.MoreThanFiveYearDevBtn && self.MoreThanFiveYearDevBtn.isSelected {
            userCareer = "5년차 이상"
            
            self.MoreThanFiveYearDevBtn.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
            
            self.studentBtn.isSelected = false
            self.studentBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            self.interestInDevBtn.isSelected = false
            self.interestInDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            self.OneYearDevBtn.isSelected = false
            self.OneYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            self.ThreeYearDevBtn.isSelected = false
            self.ThreeYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            
        } else {
            interestInDevBtn.isSelected = false
            interestInDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            studentBtn.isSelected = false
            studentBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            interestInDevBtn.isSelected = false
            interestInDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            OneYearDevBtn.isSelected = false
            OneYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            ThreeYearDevBtn.isSelected = false
            ThreeYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            MoreThanFiveYearDevBtn.isSelected = false
            MoreThanFiveYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            
        }
    }
    
    @IBAction func moveNext3TouchUpAction(_ sender: UIButton) {
        let name = UserDefaults.standard.string(forKey: "userId") ?? ""
//        let gender = UserDefaults.standard.string(forKey: "userGender") ?? ""
//        let birth = UserDefaults.standard.string(forKey: "userBirthday") ?? ""
        let gender = "E"
        let birth = gsno(formatter.string(from: Date()))
        
        putInfo(name: name, gender: gender, birth: birth, devCareer: userCareer ?? "개발에 관심이 있음")
        
        UserDefaults.standard.set(true, forKey: "login")
        UserDefaults.standard.set(true, forKey: "signUp")
        
        sender.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.8666666667, blue: 0.8823529412, alpha: 1)
    }
    
    func setButtonSelect() {
        self.interestInDevBtn.isSelected = false
        self.studentBtn.isSelected = false
        self.OneYearDevBtn.isSelected = false
        self.ThreeYearDevBtn.isSelected = false
        self.MoreThanFiveYearDevBtn.isSelected = false
        
    }
    
    func setButtonColor() {
        self.interestInDevBtn.setTitleColor(#colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1), for: UIControl.State.normal)
        self.interestInDevBtn.setTitleColor(UIColor.CustomColor.skyBlue, for: UIControl.State.selected)
        self.interestInDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)

        self.studentBtn.setTitleColor(#colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1), for: UIControl.State.normal)
        self.studentBtn.setTitleColor(UIColor.CustomColor.skyBlue, for: UIControl.State.selected)
        self.studentBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        self.OneYearDevBtn.setTitleColor(#colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1), for: UIControl.State.normal)
        self.OneYearDevBtn.setTitleColor(UIColor.CustomColor.skyBlue, for: UIControl.State.selected)
        self.OneYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        self.ThreeYearDevBtn.setTitleColor(#colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1), for: UIControl.State.normal)
        self.ThreeYearDevBtn.setTitleColor(UIColor.CustomColor.skyBlue, for: UIControl.State.selected)
        self.ThreeYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        self.MoreThanFiveYearDevBtn.setTitleColor(#colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1), for: UIControl.State.normal)
        self.MoreThanFiveYearDevBtn.setTitleColor(UIColor.CustomColor.skyBlue, for: UIControl.State.selected)
        self.MoreThanFiveYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
    }

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
