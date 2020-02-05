//
//  GetMoreInfo4VC.swift
//  GitCat
//
//  Created by 조윤영 on 25/12/2019.
//  Copyright © 2019 조윤영. All rights reserved.
//

import UIKit

class GetMoreInfo4VC: UIViewController {
    var keyboardHeight: CGFloat = 0.0
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    @IBOutlet weak var catNameLabel: UILabel!
    @IBOutlet weak var catNameTextField: UITextField!
    @IBOutlet weak var catNameUnderBar: UIView!
    
    
    @IBOutlet weak var nextMove4Btn: RoundBtn!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    var keyboardShown:Bool = false // 키보드 상태 확인
    var nameFieldShow:Bool = false //애니메이션 시작 플래그
    var originY:CGFloat? // 오브젝트의 기본 위치
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextMove4Btn.isEnabled = false
        
        setBackBtn(color: UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1))
        nextMove4Btn.addShadow()
        
        initAlpha()
        
        animateView()
        
    }
    
    
    @IBAction func nameFieldEditingChangedAction(_ sender: Any) {
        if catNameTextField.text!.isEmpty {
            nextMove4Btn.isEnabled = false
            nextMove4Btn.backgroundColor = UIColor(red: 220/255, green: 221/255, blue: 225/255, alpha: 1)
        }else{
            nextMove4Btn.isEnabled = true
            nextMove4Btn.backgroundColor = UIColor.CustomColor.skyBlue
        }
    }
    
    
    @IBAction func startTouchDownAction(_ sender: UIButton) {
        sender.backgroundColor = UIColor.CustomColor.skyBlue
    }
    
    
    @IBAction func startTouchUpAction(_ sender: UIButton) {
        
        sender.backgroundColor = UIColor(red: 220/255, green: 221/255, blue: 225/255, alpha: 1)
        let dvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "MainTabC") 
        
        dvc.modalPresentationStyle = .fullScreen
        
        self.present(dvc, animated: true, completion: nil)
    }
    
    /**
     구현 함수
     */

    
    func initAlpha() {
        self.mainTitle.alpha = 0
        self.subTitle.alpha = 0
        //collectionView.alpha = 0
        self.catNameLabel.alpha = 0
        self.catNameTextField.alpha = 0
        self.catNameUnderBar.alpha = 0
    }
    
   
    func showCatNameTextField() {
        UIView.animate(withDuration: 0.5, delay: 0.5,animations: ({
            self.catNameLabel.alpha = 1
            self.catNameTextField.alpha = 1
            self.catNameUnderBar.alpha = 1
            
        }))
    }
    func animateView() {
        UIView.animate(withDuration: 0.5, delay: 0.5,animations: ({
            self.mainTitle.alpha = 1
            self.subTitle.alpha = 1
//            self.collectionView.alpha = 1
            
        }))
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

extension GetMoreInfo4VC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         let currentCharacterCount = textField.text?.count ?? 0
           if range.length + range.location > currentCharacterCount {
               return false
           }
           let newLength = currentCharacterCount + string.count - range.length
           return newLength <= 5
    }
}
