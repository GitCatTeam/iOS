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
       
        nextBtn3.circleRadius()
        setButtonStyle()
    }
    
    func setButtonStyle() {
        interestInDevBtn.layer.borderWidth = 1.0
        interestInDevBtn.layer.cornerRadius = 12
        interestInDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        studentBtn.layer.borderWidth = 1.0
        studentBtn.layer.cornerRadius = 12
        studentBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        OneYearDevBtn.layer.borderWidth = 1.0
        OneYearDevBtn.layer.cornerRadius = 12
        OneYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        ThreeYearDevBtn.layer.borderWidth = 1.0
        ThreeYearDevBtn.layer.cornerRadius = 12
        ThreeYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        MoreThanFiveYearDevBtn.layer.borderWidth = 1.0
        MoreThanFiveYearDevBtn.layer.cornerRadius = 12
        MoreThanFiveYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)

    }
    
    func setLabelSize() {
        MainTitle.dynamicFont(fontSize: 22, name:"BBTreeG_B")
        subTitle.dynamicFont(fontSize: 13, name:"BBTreeGo_R")
        
        interestInDevBtn.titleLabel?.dynamicFont(fontSize: 16, name:"BBTreeGo_R")
        studentBtn.titleLabel?.dynamicFont(fontSize: 16, name:"BBTreeGo_R")
        OneYearDevBtn.titleLabel?.dynamicFont(fontSize: 16, name:"BBTreeGo_R")
        ThreeYearDevBtn.titleLabel?.dynamicFont(fontSize: 16, name:"BBTreeGo_R")
        MoreThanFiveYearDevBtn.titleLabel?.dynamicFont(fontSize: 16, name:"BBTreeGo_R")
        
        nextBtn3.titleLabel?.dynamicFont(fontSize: 16, name:"BBTreeG_B")
        pageLabel.dynamicFont(fontSize: 11, name:"BBTreeGo_R")
    }
    
    @IBAction func chooseCareer(_ sender: UIButton) {
        sender.isSelected = true
        nextBtn3.isEnabled = true
        nextBtn3.backgroundColor = UIColor.CustomColor.skyBlue
        
        if sender == interestInDevBtn && interestInDevBtn.isSelected {
            
            userCareer = "개발에 관심이 있음"
            interestInDevBtn.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
            
            studentBtn.isSelected = false
             studentBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            OneYearDevBtn.isSelected = false
             OneYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            ThreeYearDevBtn.isSelected = false
             ThreeYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            MoreThanFiveYearDevBtn.isSelected = false
             MoreThanFiveYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            
        }else if sender == studentBtn && studentBtn.isSelected {
            userCareer = "관련 학부생/대학원생"
            
            studentBtn.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
            
            interestInDevBtn.isSelected = false
            interestInDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            OneYearDevBtn.isSelected = false
            OneYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            ThreeYearDevBtn.isSelected = false
            ThreeYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            MoreThanFiveYearDevBtn.isSelected = false
            MoreThanFiveYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            
        } else if sender == OneYearDevBtn && OneYearDevBtn.isSelected {
            userCareer = "1년차"
            
            OneYearDevBtn.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
            
            studentBtn.isSelected = false
            studentBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            interestInDevBtn.isSelected = false
            interestInDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            ThreeYearDevBtn.isSelected = false
            ThreeYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            MoreThanFiveYearDevBtn.isSelected = false
            MoreThanFiveYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        } else if sender == ThreeYearDevBtn && ThreeYearDevBtn.isSelected {
            userCareer = "3년차"
            
            ThreeYearDevBtn.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
            
            studentBtn.isSelected = false
            studentBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            interestInDevBtn.isSelected = false
            interestInDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            OneYearDevBtn.isSelected = false
            OneYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            MoreThanFiveYearDevBtn.isSelected = false
            MoreThanFiveYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        } else if sender == MoreThanFiveYearDevBtn && MoreThanFiveYearDevBtn.isSelected {
            userCareer = "5년차 이상"
            
            MoreThanFiveYearDevBtn.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
            
            studentBtn.isSelected = false
            studentBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            interestInDevBtn.isSelected = false
            interestInDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            OneYearDevBtn.isSelected = false
            OneYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            ThreeYearDevBtn.isSelected = false
            ThreeYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        } else{
            
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
        let gender = UserDefaults.standard.string(forKey: "userGender") ?? ""
        let birth = UserDefaults.standard.string(forKey: "userBirthday") ?? ""
        
        
        putInfo(name: name, gender: gender, birth: birth, devCareer: userCareer ?? "개발에 관심이 있음")
        
        UserDefaults.standard.set(true, forKey: "login")
        UserDefaults.standard.set(true, forKey: "signUp")
        
        sender.backgroundColor = UIColor(red: 220/255, green: 221/255, blue: 225/255, alpha: 1)
        
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
        interestInDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)

        studentBtn.setTitleColor(#colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1), for: UIControl.State.normal)
        studentBtn.setTitleColor(UIColor.CustomColor.skyBlue, for: UIControl.State.selected)
        studentBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        OneYearDevBtn.setTitleColor(#colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1), for: UIControl.State.normal)
        OneYearDevBtn.setTitleColor(UIColor.CustomColor.skyBlue, for: UIControl.State.selected)
        OneYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        ThreeYearDevBtn.setTitleColor(#colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1), for: UIControl.State.normal)
        ThreeYearDevBtn.setTitleColor(UIColor.CustomColor.skyBlue, for: UIControl.State.selected)
        ThreeYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        MoreThanFiveYearDevBtn.setTitleColor(#colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1), for: UIControl.State.normal)
        MoreThanFiveYearDevBtn.setTitleColor(UIColor.CustomColor.skyBlue, for: UIControl.State.selected)
        MoreThanFiveYearDevBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
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

//MARK: Networking Extension
extension GetMoreInfo3VC {

    func putInfo(name: String, gender: String, birth:String, devCareer:String) {


        let params : [String : Any] = ["name" : name ,
                                       "gender" : gender ,
                                       "birth": birth ,
                                       "devCareer":devCareer ]

        PutAdditionalInfoService.shareInstance.putAdditionalInfo(params: params) { (result) in

            switch result {
            case .networkSuccess( _): //200
                let dvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "UserDataInitVC")
                dvc.modalPresentationStyle = .fullScreen
                self.present(dvc, animated: true, completion: nil)
                break

            case .accessDenied, .badRequest: //401(없는 사용자), 400(비번 불일치)
                self.simpleAlert(title: "회원가입 실패", message: "다시 시도해주세요.")
                break

            case .networkFail :
                self.networkErrorAlert()
                break

            default :
                self.simpleAlert(title: "오류", message: "다시 시도해주세요.")
                break
            }
        }
    }
}
