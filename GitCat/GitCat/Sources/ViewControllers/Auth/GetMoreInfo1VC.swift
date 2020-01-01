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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtonSelect()
        setButtonColor()
        nextBtn.addShadow()
    }

    
    @IBAction func selectGenderAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender == femaleBtn && femaleBtn.isSelected {//여자 버튼 선택되었을 경우
            femaleBtn.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
            
            maleBtn.isSelected = false;
            maleBtn.layer.borderColor = UIColor.init(red: 192/255, green: 192/255, blue: 192/255, alpha: 192/255).cgColor
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
    
    
    @IBAction func moveNextTouchDownAction(_ sender: UIButton) {
        sender.backgroundColor = UIColor.CustomColor.skyBlue
 
    }

    @IBAction func moveNextTouchUpAction(_ sender: UIButton) {
        if let dvc = storyboard? .instantiateViewController(withIdentifier: "GetMoreInfo2VC") as? GetMoreInfo2VC {
            
            self.navigationController?.pushViewController(dvc, animated: true)
            
        }
        
    }
    
    /*----------------------------------------------*/
    /*구현 함수*/
    /*----------------------------------------------*/
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
