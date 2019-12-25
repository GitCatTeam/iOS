//
//  BasicExtension.swift
//  GitCat
//
//  Created by 조윤영 on 23/12/2019.
//  Copyright © 2019 조윤영. All rights reserved.
//


import Foundation
import UIKit


extension UIView {
    
    //원형 뷰
    func circleRadius(){
        self.layer.cornerRadius = self.layer.frame.height/2
        self.layer.masksToBounds = true
    }
    
    func roundRadius(){ //조금 라운드 주는 extension 만들 예정
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
    }
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.1
        self.layer.masksToBounds = false
    }
    
    //뷰 테두리 설정
    func addBorder(_ mask: CAShapeLayer, borderWidth: CGFloat, borderColor: UIColor) {

        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
        
    }
    
    //그림자 추가
    func dropShadow(scale: Bool = true) {
        self.clipsToBounds = true
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 10).cgPath
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 3
        
        self.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    func sectionRound(){
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight,.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        layer.mask = maskLayer
    }
}

extension UIImageView {
    
    //이미지뷰 동그랗게 설정
    func circleImageView() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.width / 2
    }
}

extension UITextView {
    
    //텍스트뷰 스크롤 상단으로 초기화
    //따로 메소드를 호출하지 않아도 이 메소드가 extension에 선언된 것만으로 적용이 됩니다.
    override open func draw(_ rect: CGRect)
    {
        super.draw(rect)
        setContentOffset(CGPoint.zero, animated: false)
    }
    
}

extension CALayer {
    
   
}



