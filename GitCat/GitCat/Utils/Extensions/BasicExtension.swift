//
//  BasicExtension.swift
//  GitCat
//
//  Created by 조윤영 on 23/12/2019.
//  Copyright © 2019 조윤영. All rights reserved.
//


import Foundation
import UIKit
import Kingfisher


extension UIView {
    
    func createDottedLine(width: CGFloat, color: CGColor) {
       let caShapeLayer = CAShapeLayer()
       caShapeLayer.strokeColor = color
       caShapeLayer.lineWidth = width
       caShapeLayer.lineDashPattern = [2,3]
       let cgPath = CGMutablePath()
       let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.width, y: 0)]
       cgPath.addLines(between: cgPoint)
       caShapeLayer.path = cgPath
       layer.addSublayer(caShapeLayer)
    }
    
    //원형 뷰
    func circleRadius(){
        self.layer.cornerRadius = self.frame.height/2
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = true
    }
    
    func roundRadius(){ //조금 라운드 주는 extension 만들 예정
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
    }
    func addShadow() {
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.12
        self.layer.masksToBounds = false
    }
    
    //뷰 테두리 설정
    func addBorder(_ mask: CAShapeLayer, borderWidth: CGFloat, borderColor: UIColor) {
        self.layer.masksToBounds = true
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
    func topSectionRound(_radius:CGFloat = 10) {
        self.clipsToBounds = true
        self.layer.cornerRadius = _radius
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
    }
    func sectionRoundWithoutLeft(_radius:CGFloat = 10) {
        self.clipsToBounds = true
        self.layer.cornerRadius = _radius
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
    }
    func bottomSectionRound(_radius:CGFloat = 10){
        self.clipsToBounds = true
        self.layer.cornerRadius = _radius
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
}

extension UIImageView {
    
    //이미지뷰 동그랗게 설정
    func circleImageView() {
        self.layer.cornerRadius = self.layer.frame.height/2
        self.layer.masksToBounds = true
    }
    func setImage(with urlString: String) {
        let cache = ImageCache.default
        cache.retrieveImage(forKey: urlString, options: nil) { (image, _) in // 캐시에서 키를 통해 이미지를 가져온다.
            if let image = image { // 만약 캐시에 이미지가 존재한다면
                self.image = image // 바로 이미지를 셋한다.
            } else {
                let url = URL(string: urlString) // 캐시가 없다면
                
                let resource = ImageResource(downloadURL: url! , cacheKey: urlString)
                // URL로부터 이미지를 다운받고 String 타입의 URL을 캐시키로 지정하고
                self.kf.setImage(with: resource) // 이미지를 셋한다.
            }
        }
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
extension UILabel {
   func setLineHeight(lineHeight: CGFloat) {
       let paragraphStyle = NSMutableParagraphStyle()
       paragraphStyle.lineSpacing = 1.0
       paragraphStyle.lineHeightMultiple = lineHeight
       paragraphStyle.alignment = self.textAlignment

       let attrString = NSMutableAttributedString()
       if (self.attributedText != nil) {
           attrString.append( self.attributedText!)
       } else {
           attrString.append( NSMutableAttributedString(string: self.text!))
        attrString.addAttribute(NSAttributedString.Key.font, value: self.font ?? "", range: NSMakeRange(0, attrString.length))
       }
    attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
       self.attributedText = attrString
   }
}


