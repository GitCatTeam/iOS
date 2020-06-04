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
    
    
    @IBOutlet weak var catSelectionView: UIView!
    @IBOutlet weak var selectBoxView: UIView!
    
    @IBOutlet weak var basicBtn: UIButton!
    @IBOutlet weak var specialBtn: UIButton!
    
    @IBOutlet weak var basicBtnBottomBorder: UIView!
    @IBOutlet weak var specialBtnBottomBorder: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var newCatCollectionView: UICollectionView!
    
    
    @IBOutlet weak var catNameLabel: UILabel!
    @IBOutlet weak var catNameTextField: UITextField!
    @IBOutlet weak var catNameUnderBar: UIView!
    
    @IBOutlet weak var nextMove4Btn: RoundBtn!
    
    @IBOutlet weak var preparingView: UIImageView!
    @IBOutlet weak var preparingLavel: UILabel!
    
    @IBOutlet weak var alertView: UIView!
    
    @IBOutlet weak var alertcardView: UIView!
    
    @IBOutlet weak var hiddenCatImageView: UIImageView!
    
    @IBOutlet weak var alertTitleLabel: CustomLabel!
    @IBOutlet weak var alertSubTitleLabel: CustomLabel!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    var keyboardShown:Bool = false // 키보드 상태 확인
    var nameFieldShow:Bool = false //애니메이션 시작 플래그
    var originY:CGFloat? // 오브젝트의 기본 위치
    
    var commonCatList = [CatDataModel]();
    var specialCatList = [CatDataModel]();
    var currentCatList = [CatDataModel]();
    
    var newCatList = [CatNewDataModel]();
    
    var catId:Int?
    var catName:String?
    
    let cellIdentifier = "SelectCatCVCell"
    let cellIdentifier2 = "NewCatCVCell"
    
    private let MAX_LENGTH = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setCatList()
        currentCatList = commonCatList;
        self.collectionView.reloadData()
        
        nextMove4Btn.isEnabled = false
        
        setBackBtn(color: UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1))
        nextMove4Btn.addShadow()
        
        initAlpha()
        setButtonSelect()
        animateView()
        
        catNameTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextField.textDidChangeNotification, object: catNameTextField)
        
    }
    
    @objc private func textDidChange(_ notification: Notification) {

        if let textField = notification.object as? UITextField {

            if let text = textField.text {

                // 초과되는 텍스트 제거
                if text.count > 5 {
                    print("?")
                    let index = text.index(text.startIndex, offsetBy: 5)

                    let newString = text.substring(to: index)

                    textField.text = newString

                }

            }

        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        topConstraint.constant = 0
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        collectionView.collectionViewLayout.invalidateLayout()
        newCatCollectionView.collectionViewLayout.invalidateLayout()
        
        setStyle()
        nextMove4Btn.circleRadius()
        setLabelSize()

    }

    
    func setLabelSize() {
        
        
        catNameTextField.font = UIFont(name: "BBTreeGo_R", size: 16)
        catNameTextField.adjustsFontSizeToFitWidth = true
        
        mainTitle.dynamicFont(fontSize: 22, name:"BBTreeG_B")
        subTitle.dynamicFont(fontSize: 13, name:"BBTreeGo_R")
        basicBtn.titleLabel?.dynamicFont(fontSize: 15, name:"BBTreeG_B")
        specialBtn.titleLabel?.dynamicFont(fontSize: 15, name:"BBTreeG_B")
        catNameLabel.dynamicFont(fontSize: 16, name:"BBTreeG_B")

        preparingLavel.dynamicFont(fontSize: 15, name: "BBTreeG_B")
        
        alertTitleLabel.dynamicFont(fontSize: 20, name: "BBTreeG_B")
        alertSubTitleLabel.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        
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
        

    }
    @IBAction func basicBtnAction(_ sender: Any) {
        currentCatList = self.commonCatList;
        collectionView.indexPathsForSelectedItems?
        .forEach {
            self.collectionView.deselectItem(at: $0, animated: false)
            let eachCell:SelectCatCVCell = collectionView.cellForItem(at: $0)! as! SelectCatCVCell
            eachCell.roundView.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        }
        collectionView.reloadData()
        dismissCatNameTextField()
    
        preparingLavel.alpha = 0
        preparingView.alpha = 0
    }
    
    @IBAction func specialBtnAction(_ sender: Any) {
        currentCatList = self.specialCatList;
        collectionView.indexPathsForSelectedItems?
        .forEach {
            self.collectionView.deselectItem(at: $0, animated: false)
            let eachCell:SelectCatCVCell = collectionView.cellForItem(at: $0)! as! SelectCatCVCell
            eachCell.roundView.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        }
        collectionView.reloadData()
        self.catNameTextField.text = ""
        dismissCatNameTextField()
        
        preparingLavel.alpha = 1
        preparingView.alpha = 1
    }
    
    //박훈
    
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
        
        catName = self.catNameTextField.text
        
        postCat(catId: catId, catName: catName)
    }
    
    @IBAction func closeAlertViewAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.alertView.alpha = 0
            self.alertcardView.alpha = 0
        });
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
        self.preparingLavel.alpha = 0
        self.preparingView.alpha = 0
        
        self.alertView.alpha = 0
        self.alertcardView.alpha = 0
        self.newCatCollectionView.alpha = 0
        self.pageControl.alpha = 0
    }
    
   
    func showCatNameTextField() {
        UIView.animate(withDuration: 0.5, delay: 0.5,animations: ({
            self.catNameLabel.alpha = 1
            self.catNameTextField.alpha = 1
            self.catNameUnderBar.alpha = 1
            
        }))
    }
    func dismissCatNameTextField() {
        UIView.animate(withDuration: 0.5, delay: 0.5,animations: ({
            self.catNameLabel.alpha = 0
            self.catNameTextField.alpha = 0
            self.catNameUnderBar.alpha = 0
            
        }))
        
        nextMove4Btn.isEnabled = false
        nextMove4Btn.backgroundColor = UIColor(red: 220/255, green: 221/255, blue: 225/255, alpha: 1)
        
        
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

        
        self.selectBoxView.layer.borderWidth = 1
        self.selectBoxView.layer.borderColor = #colorLiteral(red: 0.7528660893, green: 0.7529937625, blue: 0.7528492808, alpha: 1)
        self.selectBoxView.sectionRoundWithoutLeft(_radius: 7)
        
        self.collectionView.layer.borderWidth = 1
        self.collectionView.layer.borderColor = #colorLiteral(red: 0.7528660893, green: 0.7529937625, blue: 0.7528492808, alpha: 1)
        self.collectionView.layer.cornerRadius = 13
        
        self.alertcardView.layer.masksToBounds = false
        self.alertcardView.layer.cornerRadius = 10
        self.alertcardView.customShadow(width: 1, height: 2, radius: 4, opacity: 0.16)
    }
    
    func setButtonSelect() {
        
        self.basicBtn.setTitleColor(#colorLiteral(red: 0.4576154947, green: 0.8046417236, blue: 0.9821793437, alpha: 1), for: UIControl.State.selected)
        self.basicBtn.setTitleColor(#colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1), for: UIControl.State.normal)
        
        self.specialBtn.setTitleColor(#colorLiteral(red: 0.4576154947, green: 0.8046417236, blue: 0.9821793437, alpha: 1), for: UIControl.State.selected)
        self.specialBtn.setTitleColor(#colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1), for: UIControl.State.normal)
        
        self.basicBtnBottomBorder.alpha = 1
        self.specialBtnBottomBorder.alpha = 0

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
            
            print("======================")
            print(keyboardSize.height)
            print("======================")
            
            let bounds = UIScreen.main.bounds
            let height = bounds.size.height
            
            topConstraint.constant = originY! - (keyboardSize.height - height/8)
            
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

            topConstraint.constant = 0
            
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
    
    func showAlertView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.alertView.alpha = 1
            self.alertcardView.alpha = 1
        });
    }
    
    func showNewCatListView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.alertView.alpha = 1
            self.newCatCollectionView.alpha = 1
            self.pageControl.alpha = 1
        });
    }
    
    @IBAction func closeNewCatViewAction(_ sender: Any) {
        print("닫는버튼 선택")
        UIView.animate(withDuration: 0.5, animations: {
            self.alertView.alpha = 0
            self.newCatCollectionView.alpha = 0
            self.pageControl.alpha = 0
        });
    }
    
    
}

extension GetMoreInfo4VC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        
        let currentCharacterCount = textField.text?.count ?? 0
        print(currentCharacterCount)
        
           if range.length + range.location > currentCharacterCount {
               return false
           }
           let newLength = currentCharacterCount + string.count - range.length
        return newLength <= 6
    }
}

extension GetMoreInfo4VC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if(collectionView == self.collectionView) {
                print(currentCatList.count)
                return currentCatList.count
        }
        if(collectionView == self.newCatCollectionView){
            return newCatList.count
        }
       
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(collectionView == self.newCatCollectionView ){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier2, for: indexPath) as? NewCatCVCell

            let imageURL = gsno(self.newCatList[indexPath.row].profileImg)

            cell?.newCatImageView.setImage(imageURL, defaultImgPath: "imgDefault")
            cell?.newCatDescriptionLabel.text = gsno(newCatList[indexPath.row].description)
            
            
            if(indexPath.row == newCatList.count-1) {
                cell?.closedBtnImageView.alpha = 1
                cell?.closedBtn.alpha = 1
            }else{
                cell?.closedBtnImageView.alpha = 0
                cell?.closedBtn.alpha = 0
            }
            
            return cell!
        }
        
        //선택 고양이 리스트 셀 구현
        if(collectionView == self.collectionView) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? SelectCatCVCell
                
            //새로 지급된 고양이인지 판별
            if(currentCatList[indexPath.row].isNew == true) {
                cell?.NewBadgeView.alpha = 1
            }else{
                cell?.NewBadgeView.alpha = 0
            }
                
            let imageURL = gsno(currentCatList[indexPath.row].profileImg)
            cell?.catImageView.setImage(imageURL, defaultImgPath: "imgDefault")

            return cell!
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if(collectionView == self.newCatCollectionView) {
            
            let cellWidth: CGFloat = newCatCollectionView.frame.width - 20
            let cellHeight: CGFloat = newCatCollectionView.frame.height - 10
        
            return CGSize(width: cellWidth, height: cellHeight)
        }
        if(collectionView == self.collectionView) {
            let cellWidth: CGFloat = collectionView.frame.width / 3.4 - 1
            
            let cellHeight: CGFloat = collectionView.frame.height / 3.15 - 1
            
            return CGSize(width: cellWidth, height: cellHeight)
        }
        
        return CGSize(width: 0, height: 0)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if(collectionView == self.newCatCollectionView) {
            return UIEdgeInsets(top: 0, left:0, bottom: 0, right:0)
        }
        
        return UIEdgeInsets(top: 14.2, left:12, bottom: 14.2, right: 13)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(collectionView == self.collectionView ) {
            if(currentCatList[indexPath.row].isAvailable! != false) {
                let selectedCell:SelectCatCVCell = collectionView.cellForItem(at: indexPath)! as! SelectCatCVCell
                selectedCell.roundView.layer.borderColor = #colorLiteral(red: 0.4652857184, green: 0.8005116582, blue: 0.9823767543, alpha: 1)
                catId = currentCatList[indexPath.row].id
                
                showCatNameTextField()
            }else{
            
                alertSubTitleLabel.text = gsno(currentCatList[indexPath.row].description)
               
                let imageURL = gsno(self.currentCatList[indexPath.row].profileImg)
                hiddenCatImageView.setImage(imageURL, defaultImgPath: "imgDefault")
                
                showAlertView()
                
                let cell:SelectCatCVCell = collectionView.cellForItem(at: indexPath)! as! SelectCatCVCell
                cell.isSelected = false
                
                dismissCatNameTextField()
                
                
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if(collectionView == self.collectionView ) {
            
            let cellToDeselect:SelectCatCVCell = collectionView.cellForItem(at: indexPath)! as! SelectCatCVCell
            cellToDeselect.roundView.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let page = Int(targetContentOffset.pointee.x / (newCatCollectionView.frame.width-12))
        
        self.pageControl.currentPage = page
        
    }
    
}
extension GetMoreInfo4VC {
    
    func setCatList() {
        
        CatListService.sharedInstance.getCatList { (result) in
            switch result {
            case .networkSuccess(let data):
                let catListData = data as? CatListModel
                if let resResult = catListData {
                    self.commonCatList = resResult.data?.normal ?? []
                    self.specialCatList = resResult.data?.special ?? []

                    if(resResult.data?.isNewExist == true) {
                        self.newCatList = resResult.data?.new ?? []
                        self.pageControl.numberOfPages = self.newCatList.count

                        self.newCatCollectionView.reloadData()
                        self.showNewCatListView()
                    }

                    self.currentCatList = self.commonCatList;
                    self.collectionView.reloadData()
                    
                }
                break
                
            case .accessDenied:
                let confirmModeAction = UIAlertAction(title: "확인", style: .default) { (action) in
                    UserDefaults.standard.set(false, forKey: "login")
                    let dvc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "AuthInitiVC")
                    dvc.modalPresentationStyle = .fullScreen
                    
                    self.present(dvc, animated: true, completion: nil)
                }
                
                let alert = UIAlertController(title: "로그인 필요", message: "재로그인이 필요합니다", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(confirmModeAction)

                self.present(alert, animated:true)
                 
                
                break
            case .networkFail :
                self.networkErrorAlert()
                break
                    
            default:
                self.simpleAlert(title: "오류 발생!", message: "다시 시도해주세요")
                break
             }
        }
        
    }
    
    func postCat(catId:Int?, catName: String?) {
        
        let params : [String : Any] =
            ["catId" : catId ?? "",
             "catName" : catName ?? "",
             ]
        
        PostCatSelectedService.shareInstance.postCatSelection(params: params) {(result) in
            switch result {
            case .networkSuccess( _): //201
                print("Cat Selection POST SUCCESS")
                let dvc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "MainTabC")
                
                dvc.modalPresentationStyle = .fullScreen
                
                self.present(dvc, animated: true, completion: nil)
                break
                
            //FIXME: 수정
            case .badRequest: //400
                self.simpleAlert(title: "", message: "다시 시도해주세요")
                break
                
            case .duplicated: //401
                
                self.simpleAlert(title: "", message: "권한이 없습니다.")
                break
                
            case .networkFail:
                self.networkErrorAlert()
                break
                
            default:
                self.simpleAlert(title: "오류", message: "다시 시도해주세요")
                break
            }
        }
    }
}
