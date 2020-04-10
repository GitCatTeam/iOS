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
    
    
    
    var clickBtnCnt = 0
    var userGender:String?
    var userBirthday:String?
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    
    //포맷터 초기화
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clickBtnCnt = 0

        setStyle();
        setButtonSelect()
        setButtonColor()
        nextBtn.addShadow()
        setLabelSize()
        
        initAlpha()
        animateView()
        
        setBackBtn(color: UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1))
        
        userBirthday = formatter.string(from: Date())

    }
    
    func setStyle() {
        let imageURL = UserDefaults.standard.string(forKey: "userImage")
        userProfileImageView.setImage(imageURL, defaultImgPath: "imgDefault")
        
        birthDatePicker.setValue(UIColor.CustomColor.skyBlue, forKey: "textColor")
        
        nextBtn.circleRadius()
        femaleBtn.circleRadius()
        maleBtn.circleRadius()
        otherBtn.circleRadius()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        clickBtnCnt = 0
        
        nextBtn.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.8666666667, blue: 0.8823529412, alpha: 1)
        nextBtn.isEnabled = false
        
        femaleBtn.isSelected = false
        femaleBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)

        maleBtn.isSelected = false;
        maleBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        otherBtn.isSelected = false;
        otherBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
        userProfileImageView.circleImageView()
        nextBtn.circleRadius()
        femaleBtn.circleRadius()
        maleBtn.circleRadius()
        otherBtn.circleRadius()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userProfileImageView.circleImageView()
        nextBtn.circleRadius()
        femaleBtn.circleRadius()
        maleBtn.circleRadius()
        otherBtn.circleRadius()
    }
    
    @IBAction func selectGenderAction(_ sender: UIButton) {
        sender.isSelected = true
        nextBtn.isEnabled = true
        nextBtn.backgroundColor = UIColor.CustomColor.skyBlue
        
        if sender == femaleBtn && femaleBtn.isSelected {//여자 버튼 선택되었을 경우
            
            femaleBtn.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
            
            maleBtn.isSelected = false;
            maleBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            otherBtn.isSelected = false;
            otherBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            
            userGender = "F"
            
            
        }else if sender == maleBtn && maleBtn.isSelected{//남자 버튼 선택일 경우
            maleBtn.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
            
            femaleBtn.isSelected = false;
            femaleBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            otherBtn.isSelected = false;
            otherBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            
            userGender = "M"
            
        }else if sender == otherBtn && otherBtn.isSelected{//기타 버튼 선택일 경우
            otherBtn.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
            
            femaleBtn.isSelected = false;
            femaleBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            maleBtn.isSelected = false;
            maleBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            
            userGender = "E"
        } else{
            
            femaleBtn.isSelected = false;
            femaleBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            maleBtn.isSelected = false;
            maleBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            otherBtn.isSelected = false;
            otherBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
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
    
    
    /**
    구현 함수
    **/
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
        BigTitle.dynamicFont(fontSize: 22, name:"BBTreeG_B")
        subTitle.dynamicFont(fontSize: 13, name:"BBTreeGo_R")
        userEmailLabel.dynamicFont(fontSize: 18, name:"BBTreeG_B")
        sexLabel.dynamicFont(fontSize: 16, name:"BBTreeG_B")
        femaleBtn.titleLabel?.dynamicFont(fontSize: 14,  name:"BBTreeG_B")
        maleBtn.titleLabel?.dynamicFont(fontSize: 14,  name:"BBTreeG_B")
        otherBtn.titleLabel?.dynamicFont(fontSize: 14,  name:"BBTreeG_B")
        pageLabel.dynamicFont(fontSize: 12, name:"BBTreeGo_R")
        
        nextBtn.titleLabel?.dynamicFont(fontSize: 16, name:"BBTreeG_B")
    }
    
    func setButtonSelect() {
        femaleBtn.isSelected = false
        maleBtn.isSelected = false
        otherBtn.isSelected = false
    }
    
    func setButtonColor() {
        //여자 버튼 기본 상태 초기화
        femaleBtn.setTitleColor(#colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1), for: UIControl.State.normal)
        femaleBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        //여자 버튼 선택할 경우
        femaleBtn.setTitleColor(UIColor.CustomColor.skyBlue, for: UIControl.State.selected)
        
        //남자 버튼 초기화
        maleBtn.setTitleColor(#colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1), for: UIControl.State.normal)
        maleBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        //남자 버튼 선택할 경우
        maleBtn.setTitleColor(UIColor.CustomColor.skyBlue, for: UIControl.State.selected)
        
        //기타 버튼 초기화
        otherBtn.setTitleColor(#colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1), for: UIControl.State.normal)
        otherBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        //기타 버튼 선택할 경우
        otherBtn.setTitleColor(UIColor.CustomColor.skyBlue, for: UIControl.State.selected)
    }
}
