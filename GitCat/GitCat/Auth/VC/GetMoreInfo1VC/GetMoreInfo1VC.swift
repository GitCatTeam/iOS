//
//  GetMoreInfo1VC.swift
//  GitCat
//
//  Created by 조윤영 on 24/12/2019.
//  Copyright © 2019 조윤영. All rights reserved.
//

import UIKit

class GetMoreInfo1VC: UIViewController {
    
    @IBOutlet weak var femaleBtn: CircleBtn!
    @IBOutlet weak var maleBtn: CircleBtn!
    @IBOutlet weak var otherBtn: CircleBtn!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var BigTitle: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userEmailUnderBarView: UIView!
    
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var sexStackView: UIStackView!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    @IBOutlet weak var pageCntLabel: UILabel!
    
    @IBOutlet weak var pageLabel: UILabel!

    var clickBtnCnt:Int = 0
    var userGender:String = ""
    var userBirthday:String = ""

    fileprivate let gregorian = Calendar(identifier: .gregorian)
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    fileprivate let formatter2: DateFormatter = {
           let formatter2 = DateFormatter()
           formatter2.dateFormat = "yyyyMMdd"
           return formatter2
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        clickBtnCnt = 0
        
        setStyle();
        setButtonSelect()
        setButtonColor()
        setLabelSize()
        
        initAlpha()
        animateView()
        
    }
    
    func setInitData() {
        self.userEmailLabel.text = UserDefaults.standard.string(forKey: "userId")
        self.userBirthday = formatter.string(from: Date())
        let imageURL = UserDefaults.standard.string(forKey: "userImage")
        self.userProfileImageView.setImage(imageURL, defaultImgPath: "imgDefault")
        self.birthDatePicker.setValue(UIColor.CustomColor.skyBlue, forKey: "textColor")
        self.birthDatePicker.setValue(false, forKey: "highlightsToday")
        
    }
    
    func setStyle() {
        self.nextBtn.addShadow()
        setBackBtn(color: UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1))
        
    }

    override func viewWillAppear(_ animated: Bool) {
        clickBtnCnt = 0
        
        self.nextBtn.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.8666666667, blue: 0.8823529412, alpha: 1)
        self.nextBtn.isEnabled = false
        
        self.femaleBtn.isSelected = false
        self.femaleBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)

        self.maleBtn.isSelected = false;
        self.maleBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        self.otherBtn.isSelected = false;
        self.otherBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        self.userProfileImageView.circleImageView()
        self.nextBtn.circleRadius()
        self.femaleBtn.circleRadius()
        self.maleBtn.circleRadius()
        self.otherBtn.circleRadius()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.userProfileImageView.circleImageView()
        self.nextBtn.circleRadius()
        self.femaleBtn.circleRadius()
        self.maleBtn.circleRadius()
        self.otherBtn.circleRadius()
    }
    
    @IBAction func selectGenderAction(_ sender: UIButton) {
        self.nextBtn.isEnabled = true
        self.nextBtn.backgroundColor = UIColor.CustomColor.skyBlue
        
        if sender == self.femaleBtn && self.femaleBtn.isSelected {//여자 버튼 선택되었을 경우
            
            self.femaleBtn.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
            
            self.maleBtn.isSelected = false;
            self.maleBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            self.otherBtn.isSelected = false;
            self.otherBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            
            userGender = "F"
            
        } else if sender == self.maleBtn && self.maleBtn.isSelected {//남자 버튼 선택일 경우
            self.maleBtn.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
            
            self.femaleBtn.isSelected = false;
            self.femaleBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            self.otherBtn.isSelected = false;
            self.otherBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            
            userGender = "M"
            
        } else if sender == self.otherBtn && self.otherBtn.isSelected {//기타 버튼 선택일 경우
            self.otherBtn.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
            
            self.femaleBtn.isSelected = false;
            self.femaleBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            self.maleBtn.isSelected = false;
            self.maleBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            
            userGender = "E"
            
        } else {
            self.femaleBtn.isSelected = false;
            self.femaleBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            self.maleBtn.isSelected = false;
            self.maleBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            self.otherBtn.isSelected = false;
            self.otherBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            
        }
    }

    @IBAction func moveNextTouchUpAction(_ sender: UIButton) {
        clickBtnCnt+=1

        if(clickBtnCnt == 1) {
            UIView.animate(withDuration: 0.5, animations: ({
                self.sexLabel.text = "생년월일을 알려주세요"
                self.pageCntLabel.text = "2/3"
                self.sexStackView.alpha = 0
                
            }))
            
            UIView.animate(withDuration: 0.5, delay:0.5, animations: ({
                self.birthDatePicker.alpha = 1

            }))
        }
        
        if(clickBtnCnt == 2) {
            if let dvc = storyboard? .instantiateViewController(withIdentifier: "GetMoreInfo3VC") as? GetMoreInfo3VC {
                userGender = "M"
                
                UserDefaults.standard.set(userGender, forKey: "userGender")
                UserDefaults.standard.set(userBirthday, forKey:"userBirthday")
                self.navigationController?.pushViewController(dvc, animated: true)
            }
        }
    }
    
    @IBAction func datePickerAction(_ sender: Any) {
        userBirthday = gsno(formatter.string(from: birthDatePicker.date))
        
    }
    
    func initAlpha() {
        self.BigTitle.alpha = 0
        self.subTitle.alpha = 0
        self.userProfileImageView.alpha = 0
        self.userEmailLabel.alpha = 0
        self.userEmailUnderBarView.alpha = 0
        self.sexLabel.alpha = 0
        self.sexStackView.alpha = 0
        self.birthDatePicker.alpha = 0
        
       }
       
       func animateView() {
           UIView.animate(withDuration: 0.5, delay: 0.5,animations: ({
               self.BigTitle.alpha = 1
               self.subTitle.alpha = 1
               self.userProfileImageView.alpha = 1
               self.userEmailLabel.alpha = 1
               self.userEmailUnderBarView.alpha = 1
           }))
        
           UIView.animate(withDuration: 0.5, delay: 1.0, animations: ({
               self.sexLabel.alpha = 1
               self.sexStackView.alpha = 1
           }))
    }
    
    func setLabelSize() {
        self.BigTitle.dynamicFont(fontSize: 22, name:"BBTreeG_B")
        self.subTitle.dynamicFont(fontSize: 13, name:"BBTreeGo_R")
        self.userEmailLabel.dynamicFont(fontSize: 18, name:"BBTreeG_B")
        self.sexLabel.dynamicFont(fontSize: 16, name:"BBTreeG_B")
        self.femaleBtn.titleLabel?.dynamicFont(fontSize: 14,  name:"BBTreeG_B")
        self.maleBtn.titleLabel?.dynamicFont(fontSize: 14,  name:"BBTreeG_B")
        self.otherBtn.titleLabel?.dynamicFont(fontSize: 14,  name:"BBTreeG_B")
        self.pageLabel.dynamicFont(fontSize: 12, name:"BBTreeGo_R")
        self.nextBtn.titleLabel?.dynamicFont(fontSize: 16, name:"BBTreeG_B")
        
    }
    
    func setButtonSelect() {
        self.femaleBtn.isSelected = false
        self.maleBtn.isSelected = false
        self.otherBtn.isSelected = false
        
    }
    
    func setButtonColor() {
        self.femaleBtn.setTitleColor(#colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1), for: UIControl.State.normal)
        self.femaleBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)

        self.femaleBtn.setTitleColor(UIColor.CustomColor.skyBlue, for: UIControl.State.selected)
        
        self.maleBtn.setTitleColor(#colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1), for: UIControl.State.normal)
        self.maleBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        self.maleBtn.setTitleColor(UIColor.CustomColor.skyBlue, for: UIControl.State.selected)
        
        otherBtn.setTitleColor(#colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1), for: UIControl.State.normal)
        otherBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)

        otherBtn.setTitleColor(UIColor.CustomColor.skyBlue, for: UIControl.State.selected)
        
    }
}
