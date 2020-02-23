//
//  HomeVC.swift
//  GitCat
//
//  Created by 조윤영 on 30/12/2019.
//  Copyright © 2019 조윤영. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var catChatLabel: UILabel!

    @IBOutlet weak var OverlayView: UIView!

    @IBOutlet weak var pointerView: RoundView!
    @IBOutlet weak var chapter1: RoundView!
    @IBOutlet weak var chapter2: RoundView!
    @IBOutlet weak var chapter3: RoundView!
    @IBOutlet weak var chapter4: RoundView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellIdentifier = "TutorialCVCell"
    
    let pointerPosition:[Int] = [0, 24, 48, 72]
    var pointerIndex = 0
    let chapterData:[String] = ["01","02","03","04"]
    let imageData:[UIImage] = [ UIImage(named: "imgTutorial1")!, UIImage(named: "imgTutorial2")!, UIImage(named: "imgTutorial3")!, UIImage(named: "imgTutorial4")!]

    let titleData:[String] = ["커밋으로 고양씨 성장시키기", "고양씨 졸업시키기", "달력과 레포트로 나의 개발 돌아보기", "튜토리얼 완료하고 고양이 받자!"]
    let content1Data:[String] = ["매일 꾸준히 커밋해보세요.", "4단계 고양씨는 졸업하게 되지만, 걱정 마세요!", "하단의 커밋달력을 통해 일일 커밋 현황을,", "어플 사용에 익숙해 지는 겸, 간단한 미션을 완료하면"]
    let content2Data:[String] = ["고양씨의 개발환경이 4단계에 걸쳐 개선됩니다.", "우측 상단의 수집 버튼을 통해 졸업앨범을 볼 수 있어요.", " 레포트를 통해 매달 개발 통계를 확인할 수 있어요.", "고양이 한 마리를 데려갈 수 있어요."]
    
    let durationOfAnimationInSecond = 0.5
    var defaultXMovement: CGFloat = 24
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        catChatLabel.setLineHeight(lineHeight: 0.8)

        
        self.pointerView.layer.borderWidth = 0
        self.chapter1.layer.borderWidth = 0
        self.chapter2.layer.borderWidth = 0
        self.chapter3.layer.borderWidth = 0
        self.chapter4.layer.borderWidth = 0
        
        let leftSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))

        leftSwipeGestureRecognizer.direction = .left
        rightSwipeGestureRecognizer.direction = .right

        collectionView.addGestureRecognizer(leftSwipeGestureRecognizer)
        collectionView.addGestureRecognizer(rightSwipeGestureRecognizer)
    }
    
    @IBAction func tutorialStartAction(_ sender: Any) {
        OverlayView.alpha = 0
    
    }

    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer) {
        if(sender.direction == .left) {
            //다음 튜토리얼로 넘어간다.
            //picker 24만큼 오른쪽으로 이동
            curveAnimation(view: pointerView, direction:"left", animationOptions: .curveEaseInOut, isReset: false)
            //이미지1 + label2 값 바꿔야함

        }

        if(sender.direction == .right) {
            //이전 튜토리얼로 되돌아간다.
            curveAnimation(view: pointerView, direction:"right", animationOptions: .curveEaseInOut, isReset: false)
        }
    }
    
    func curveAnimation(view: UIView, direction:String, animationOptions: UIView.AnimationOptions, isReset: Bool) {


        if(direction == "left"){
            if(pointerIndex != 3) {
                pointerIndex += 1
            }
            var nextX:Int = self.pointerPosition[self.pointerIndex]
            UIView.animate(withDuration: durationOfAnimationInSecond, delay: 0, options: animationOptions, animations: {
                view.transform = isReset ? .identity : CGAffineTransform.identity.translatedBy(x: CGFloat(nextX), y: 0)

            }, completion: nil)

        }
        else {

            if(pointerIndex != 0) {
                pointerIndex -= 1
            }
             var nextX:Int = self.pointerPosition[self.pointerIndex]

            UIView.animate(withDuration: durationOfAnimationInSecond, delay: 0, options: animationOptions, animations: {
                view.transform = isReset ? .identity : CGAffineTransform.identity.translatedBy(x: CGFloat(nextX), y: 0)

            }, completion: nil)
        }
        
    }
}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? TutorialCVCell
        
        cell?.tutorialImageView.image = self.imageData[indexPath.row]
        cell?.chapterNumberLabel.text = self.chapterData[indexPath.row]
        cell?.title.text = self.titleData[indexPath.row]
        cell?.content1.text = self.content1Data[indexPath.row]
        cell?.content2.text = self.content2Data[indexPath.row]
        
        return cell!
    }

}
extension HomeVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: 345, height: 390)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left:0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

