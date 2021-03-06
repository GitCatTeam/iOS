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
    
    //원형 뷰
    func circleRadius(){
        self.layer.cornerRadius = self.frame.height/2
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = true
    }
    
    func roundRadius(radius:CGFloat){ //조금 라운드 주는 extension 만들 예정
        
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func addShadow() {
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.12
        self.layer.masksToBounds = false
    }

    func customShadow(width:CGFloat, height:CGFloat, radius:CGFloat, opacity:Float) {
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.shadowOffset = CGSize(width: width, height: height)
        
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.masksToBounds = false
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
    func bottomSectionRound(_radius:CGFloat){
        self.clipsToBounds = true
        self.layer.cornerRadius = _radius
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
}

extension UIImage {
    static func gradientImage(with bounds: CGRect,
                            colors: [CGColor],
                            locations: [NSNumber]?) -> UIImage? {

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        // This makes it horizontal
        gradientLayer.startPoint = CGPoint(x: 0.0,
                                        y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0,
                                        y: 0.5)

        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIImageView {
    func loadGIFView(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    //이미지뷰 동그랗게 설정
    func circleImageView() {
        self.layer.cornerRadius = self.layer.frame.height/2
        self.layer.masksToBounds = true
    }
    
    public func setImage(_ urlString: String?, defaultImgPath : String) {
        
        let defaultImg = UIImage(named: defaultImgPath)
        //혹시나 오류가 발생한 경우 defualtImg 를 출력
        
        if let url = urlString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if url.isEmpty {                //  만약 이미지가 없는 경우
                self.image = defaultImg
            } else {                        // URL 에 존재하는 경우
                self.kf.setImage(with: URL(string: url), placeholder: defaultImg, options: [.transition(ImageTransition.fade(0.5))])        // Kingfisher 에서
            }
        } else {
            self.image = defaultImg
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


