//
//  GetMoreInfo4VC.swift
//  GitCat
//
//  Created by 조윤영 on 25/12/2019.
//  Copyright © 2019 조윤영. All rights reserved.
//

import UIKit

//FIXME: 콜렉션뷰 셀 오토 빼고 나서 계속 에러남 ㅋㅋㅋㅋㅋㅋㅋ

class GetMoreInfo4VC: UIViewController {
    var keyboardHeight: CGFloat = 0.0
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    
    @IBOutlet weak var catSelectionView: UIView!
    @IBOutlet weak var selectBoxView: UIView!
    
    @IBOutlet weak var basicBtn: UIButton!
    @IBOutlet weak var specialBtn: UIButton!
    @IBOutlet weak var eventBtn: UIButton!
    
    @IBOutlet weak var basicBtnBottomBorder: UIView!
    @IBOutlet weak var specialBtnBottomBorder: UIView!
    @IBOutlet weak var eventBtnBottomBorder: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var catNameLabel: UILabel!
    @IBOutlet weak var catNameTextField: UITextField!
    @IBOutlet weak var catNameUnderBar: UIView!
    
    @IBOutlet weak var nextMove4Btn: RoundBtn!
    @IBOutlet weak var nameTextField: UITextField!
    
    var keyboardShown:Bool = false // 키보드 상태 확인
    var nameFieldShow:Bool = false //애니메이션 시작 플래그
    var originY:CGFloat? // 오브젝트의 기본 위치
    
    let cellIdentifier = "SelectCatCVCell"
    
    let dummyImageData:[UIImage] = [UIImage(named: "imgCatNero")!, UIImage(named: "imgCatPanda")!, UIImage(named: "imgCatCheeze")!, UIImage(named: "imgCatPanda")!, UIImage(named: "imgCatPanda")!, UIImage(named: "imgCatNormal")!, UIImage(named: "imgCatPanda")!, UIImage(named: "imgCatPanda")!, UIImage(named: "imgCatNormal")!, UIImage(named: "imgCatNormal")!, UIImage(named: "imgCatCheeze")!, UIImage(named: "imgCatCheeze")!, UIImage(named: "imgCatNero")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextMove4Btn.isEnabled = false
        
        setBackBtn(color: UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1))
        nextMove4Btn.addShadow()
        
        initAlpha()
        setButtonSelect()
        setStyle()
        animateView()
        
    }
    
    @IBAction func catTypeSelectedAction(_ sender: UIButton) {
        sender.isSelected = true
        
        if(sender.isSelected == true) {
            sender.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
        }else{
            sender.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        }
        
        if(sender != self.basicBtn) {
            self.basicBtn.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
            self.basicBtn.isSelected = false
            self.basicBtnBottomBorder.alpha = 0
        }else{
            self.basicBtnBottomBorder.alpha = 1
        }
        
        if (sender != self.specialBtn) {
            self.specialBtn.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
            self.specialBtn.isSelected = false
            self.specialBtnBottomBorder.alpha = 0
        }else{
            self.specialBtnBottomBorder.alpha = 1
        }
        
        if (sender != self.eventBtn) {
            self.eventBtn.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
            self.eventBtn.isSelected = false
            self.eventBtnBottomBorder.alpha = 0
        }else {
            self.eventBtnBottomBorder.alpha = 1
        }
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
        self.catSelectionView.alpha = 0
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
            self.catSelectionView.alpha = 1
            
        }))
    }
    
    func setStyle() {
        self.basicBtn.layer.borderWidth = 1
        self.basicBtn.layer.borderColor = #colorLiteral(red: 0.7528827786, green: 0.7529742718, blue: 0.752851665, alpha: 1)
        self.basicBtn.topSectionRound(_radius: 7)
        
        self.specialBtn.layer.borderWidth = 1
        self.specialBtn.layer.borderColor = #colorLiteral(red: 0.7528827786, green: 0.7529742718, blue: 0.752851665, alpha: 1)
        self.specialBtn.topSectionRound(_radius: 7)
        
        self.eventBtn.layer.borderWidth = 1
        self.eventBtn.layer.borderColor = #colorLiteral(red: 0.7528827786, green: 0.7529742718, blue: 0.752851665, alpha: 1)
        self.eventBtn.topSectionRound(_radius: 7)
        
        self.selectBoxView.layer.borderWidth = 1
        self.selectBoxView.layer.borderColor = #colorLiteral(red: 0.7528660893, green: 0.7529937625, blue: 0.7528492808, alpha: 1)
        self.selectBoxView.sectionRoundWithoutLeft(_radius: 7)
        
        self.collectionView.layer.borderWidth = 1
        self.collectionView.layer.borderColor = #colorLiteral(red: 0.7528660893, green: 0.7529937625, blue: 0.7528492808, alpha: 1)
        self.collectionView.layer.cornerRadius = 13
    }
    
    func setButtonSelect() {
        
        self.basicBtn.setTitleColor(#colorLiteral(red: 0.4576154947, green: 0.8046417236, blue: 0.9821793437, alpha: 1), for: UIControl.State.selected)
        self.basicBtn.setTitleColor(#colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1), for: UIControl.State.normal)
        
        self.specialBtn.setTitleColor(#colorLiteral(red: 0.4576154947, green: 0.8046417236, blue: 0.9821793437, alpha: 1), for: UIControl.State.selected)
        self.specialBtn.setTitleColor(#colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1), for: UIControl.State.normal)
        
        self.eventBtn.setTitleColor(#colorLiteral(red: 0.4576154947, green: 0.8046417236, blue: 0.9821793437, alpha: 1), for: UIControl.State.selected)
        self.eventBtn.setTitleColor(#colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1), for: UIControl.State.normal)
        
        self.basicBtnBottomBorder.alpha = 1
        self.specialBtnBottomBorder.alpha = 0
        self.eventBtnBottomBorder.alpha = 0
        self.basicBtn.isSelected = true
        
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

extension GetMoreInfo4VC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyImageData.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? SelectCatCVCell
        
        cell?.catImageView.image = dummyImageData[indexPath.row]
        
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //76
        let cellWidth: CGFloat = collectionView.frame.width / 3.4
        let cellHeight: CGFloat = collectionView.frame.height / 3.15
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //FIXME: 이거 안됨
        
        let cell = collectionView.cellForItem(at: indexPath) as? SelectCatCVCell

        cell?.catImageView.layer.borderColor = #colorLiteral(red: 0.4652857184, green: 0.8005116582, blue: 0.9823767543, alpha: 1)
        
        showCatNameTextField()
        

    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? SelectCatCVCell
        cell?.catImageView.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        
    }
}
