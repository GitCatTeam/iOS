//
//  GetMoreInfo1VC.swift
//  GitCat
//
//  Created by 조윤영 on 24/12/2019.
//  Copyright © 2019 조윤영. All rights reserved.
//

import UIKit

class GetMoreInfo1VC: UIViewController {
    
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var otherBtn: UIButton!
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
    
    
    var clickBtnCnt = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        clickBtnCnt = 0
        
        ///////////////////////////////////////////////////
        //FIXME:디폴트 이미지 넣기
        ///////////////////////////////////////////////////
        
        let imageURL = UserDefaults.standard.string(forKey: "userImage")
        userProfileImageView.setImage(imageURL, defaultImgPath: "")
        
        setButtonSelect()
        setButtonColor()
        nextBtn.addShadow()
        
        initAlpha()
        animateView()
        
        setBackBtn(color: UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1))
        birthDatePicker.setValue(UIColor.CustomColor.skyBlue, forKey: "textColor")
        
        nextBtn.isEnabled = false
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userProfileImageView.circleImageView()
        femaleBtn.circleRadius()
        maleBtn.circleRadius()
        otherBtn.circleRadius()
    }
    
    @IBAction func selectGenderAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        nextBtn.isEnabled = true
        nextBtn.backgroundColor = UIColor.CustomColor.skyBlue
        
        if sender == femaleBtn && femaleBtn.isSelected {//여자 버튼 선택되었을 경우
            femaleBtn.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
            
            maleBtn.isSelected = false;
            maleBtn.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            otherBtn.isSelected = false;
            otherBtn.layer.borderColor = UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 192/255).cgColor
            
            
        }else if sender == maleBtn && maleBtn.isSelected{//남자 버튼 선택일 경우
            maleBtn.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
            
            femaleBtn.isSelected = false;
            femaleBtn.layer.borderColor = UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 192/255).cgColor
            otherBtn.isSelected = false;
            otherBtn.layer.borderColor = UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 192/255).cgColor
            
        }else if sender == otherBtn && otherBtn.isSelected{//기타 버튼 선택일 경우
            otherBtn.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
            
            femaleBtn.isSelected = false;
            femaleBtn.layer.borderColor = UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 192/255).cgColor
            maleBtn.isSelected = false;
            maleBtn.layer.borderColor = UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 192/255).cgColor
        } else{
            
            femaleBtn.isSelected = false;
            femaleBtn.layer.borderColor = UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 192/255).cgColor
            maleBtn.isSelected = false;
            maleBtn.layer.borderColor = UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 192/255).cgColor
            otherBtn.isSelected = false;
            otherBtn.layer.borderColor = UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 192/255).cgColor
        }
    }

    @IBAction func moveNextTouchUpAction(_ sender: UIButton) {
        
        clickBtnCnt+=1

        if(clickBtnCnt == 1) {
            
            UIView.animate(withDuration: 0.5, animations: ({
                self.sexLabel.text = "생년월일을 알려주세요"
                self.pageCntLabel.text = "2/4"
                self.sexStackView.alpha = 0
            }))
            
            UIView.animate(withDuration: 0.5, delay:0.5, animations: ({
                self.birthDatePicker.alpha = 1

            }))
        }
        if(clickBtnCnt == 2) {
            print("넘어가야하,는데")
            if let dvc = storyboard? .instantiateViewController(withIdentifier: "GetMoreInfo3VC") as? GetMoreInfo3VC {
                
                self.navigationController?.pushViewController(dvc, animated: true)
            }
        }
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
    
    func setButtonSelect() {
        femaleBtn.isSelected = false
        maleBtn.isSelected = false
        otherBtn.isSelected = false
    }
    func setButtonColor() {
        //여자 버튼 기본 상태 초기화
        femaleBtn.setTitleColor(UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 192/255), for: UIControl.State.normal)
        femaleBtn.layer.borderColor = UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 192/255).cgColor
        //여자 버튼 선택할 경우
        femaleBtn.setTitleColor(UIColor.CustomColor.skyBlue, for: UIControl.State.selected)
        
        //남자 버튼 초기화
        maleBtn.setTitleColor(UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 192/255), for: UIControl.State.normal)
        maleBtn.layer.borderColor = UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 192/255).cgColor
        //남자 버튼 선택할 경우
        maleBtn.setTitleColor(UIColor.CustomColor.skyBlue, for: UIControl.State.selected)
        
        //기타 버튼 초기화
        otherBtn.setTitleColor(UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 192/255), for: UIControl.State.normal)
        otherBtn.layer.borderColor = UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 192/255).cgColor
        //기타 버튼 선택할 경우
        otherBtn.setTitleColor(UIColor.CustomColor.skyBlue, for: UIControl.State.selected)
    }
}
