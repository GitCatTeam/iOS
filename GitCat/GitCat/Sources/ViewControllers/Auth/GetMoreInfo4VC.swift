//
//  GetMoreInfo4VC.swift
//  GitCat
//
//  Created by 조윤영 on 25/12/2019.
//  Copyright © 2019 조윤영. All rights reserved.
//

import UIKit

class GetMoreInfo4VC: UIViewController, UITextFieldDelegate {
    var keyboardHeight: CGFloat = 0.0
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var firstCatView: RoundView!
    @IBOutlet weak var secondCatView: RoundView!
    @IBOutlet weak var thirdCatView: RoundView!
    
    @IBOutlet weak var firstCatImageView: RoundImageView!
    @IBOutlet weak var secondCatImageView: RoundImageView!
    @IBOutlet weak var thirdCatImageView: RoundImageView!
    
    @IBOutlet weak var nextMove4Btn: RoundBtn!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    var keyboardShown:Bool = false // 키보드 상태 확인
    var originY:CGFloat? // 오브젝트의 기본 위치
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextMove4Btn.addShadow()
        
        firstCatView.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
        secondCatView.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
        thirdCatView.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
        
        firstCatImageView.isUserInteractionEnabled = true
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(GetMoreInfo4VC.imageTapped1(img:)))
        firstCatImageView.addGestureRecognizer(tapGestureRecognizer1)
        
        secondCatImageView.isUserInteractionEnabled = true
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(GetMoreInfo4VC.imageTapped2(img:)))
        secondCatImageView.addGestureRecognizer(tapGestureRecognizer2)
        
        thirdCatImageView.isUserInteractionEnabled = true
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(GetMoreInfo4VC.imageTapped3(img:)))
        thirdCatImageView.addGestureRecognizer(tapGestureRecognizer3)
    }
    
    @objc func imageTapped1(img: AnyObject) {
        firstCatView.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
        
        secondCatView.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
        thirdCatView.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
        
    }
    @objc func imageTapped2(img: AnyObject) {
        secondCatView.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
        
        firstCatView.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
        thirdCatView.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
        
    }
    @objc func imageTapped3(img: AnyObject) {
        thirdCatView.layer.borderColor = UIColor.CustomColor.skyBlue.cgColor
        
        firstCatView.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
        secondCatView.layer.borderColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1).cgColor
        
    }
    
    @IBAction func startTouchDownAction(_ sender: UIButton) {
        sender.backgroundColor = UIColor.CustomColor.skyBlue
    }
    
    
    @IBAction func startTouchUpAction(_ sender: Any) {
        let dvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as! UINavigationController
        
        self.present(dvc, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)? .cgRectValue {
            if keyboardSize.height == 0.0 || keyboardShown == true
            {
                return
            }
            originY = topConstraint.constant
            topConstraint.constant = originY! - (keyboardSize.height-40)
        
            UIView.animate(withDuration: 2, animations: {
                () -> Void in
                self.view.layoutIfNeeded()
            }) {(Bool) in
                self.keyboardShown = true
            }
        }
    }
    @objc func keyboardWillHide(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if keyboardShown == false {
                return
            }

            originY = topConstraint.constant
            topConstraint.constant = originY! + (keyboardSize.height-40)
            
            UIView.animate(withDuration: 2, animations: {
                () -> Void in
                self.view.layoutIfNeeded()
            } ) { (Bool) in
                self.keyboardShown = false
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
