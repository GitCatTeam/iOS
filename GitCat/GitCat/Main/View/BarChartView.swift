//
//  BarChartView.swift
//  GitCat
//
//  Created by 조윤영 on 2020/08/14.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
import UIKit

class BarChartView: UIView {
    var values: [Double] = []
    var titles: [String] = []
    var colors: [UIColor] = []
    var animated: Bool!
  
    var currentX: CGFloat = 0
    var graphPath: UIBezierPath!
    var zeroPath: UIBezierPath!
    
    let xLayer = CAShapeLayer()
    var graphLayer: CAShapeLayer!
    
    init(frame: CGRect, values: [Double], titles: [String], colors: [UIColor], animated: Bool) {
        super.init(frame: frame)
        self.values = values
        self.titles = titles
        self.colors = colors
        self.animated = animated
      }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        //Bar차트 그래프 그리기
        let xOffset: CGFloat = (self.frame.width / (CGFloat(values.count) + 1))
        
        let sum = values.reduce(0, { (first: Double, second: Double) -> Double in
            return first + second
        })
        
        for i in 0..<values.count {

            self.graphLayer = CAShapeLayer()
            self.graphPath = UIBezierPath()
            self.zeroPath = UIBezierPath()
            
            self.layer.addSublayer(graphLayer)
            graphLayer.lineWidth = self.frame.width / 13
            
            currentX += xOffset
            
            let startPosition = CGPoint(x:currentX, y: self.frame.height * 7 / 8)
            self.graphPath.move(to: startPosition)
            self.zeroPath.move(to: startPosition)
            
            let newPosition = CGPoint(x: currentX, y: self.frame.height * 7 / 8 - (self.frame.height * CGFloat(self.values[i]/sum)))
            self.graphPath.addLine(to: newPosition)
            self.zeroPath.addLine(to: CGPoint(x: currentX, y: self.frame.height * 7 / 8))
            
            graphLayer.fillColor = #colorLiteral(red: 0.5411764706, green: 0.7960784314, blue: 0.9647058824, alpha: 0.36)
            graphLayer.strokeColor = self.colors[i].cgColor
            
            let oldPath = self.zeroPath.cgPath
            let newPath = self.graphPath.cgPath

            if self.animated {
                let animation = CABasicAnimation(keyPath: "path")
                animation.duration = 0.8
                animation.fromValue = oldPath
                animation.toValue = newPath
            
              self.graphLayer.path = newPath
              self.graphLayer.add(animation, forKey: "path")
            }
            
            if(values[i] != 0.0) {
                //퍼센트 라벨 붙이기
                var percentDesciptionLabel: UILabel!
                percentDesciptionLabel = UILabel(frame: CGRect(x: currentX, y: self.frame.height * 7 / 8 - self.frame.height * CGFloat(self.values[i]/sum) - 10, width: 100, height: 100))
                percentDesciptionLabel.text = "\(round(self.values[i] / sum * 100))%"
                percentDesciptionLabel.center = CGPoint(x: currentX, y: self.frame.height * 7 / 8 - self.frame.height * CGFloat(self.values[i]/sum) - 10)
                percentDesciptionLabel.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
                percentDesciptionLabel.textAlignment = .center
                percentDesciptionLabel.dynamicFont(fontSize: 12, name: "BBTreeG_B")
                
                self.addSubview(percentDesciptionLabel)
                
                // 레파지토리 이름 추가
                var repoNameDesciptionLabel: UILabel!
                repoNameDesciptionLabel = UILabel(frame: CGRect(x: currentX, y: self.frame.height + self.frame.height / 60, width: 100, height: 100))
                repoNameDesciptionLabel.text = "\(titles[i])"
                repoNameDesciptionLabel.center = CGPoint(x: currentX, y: self.frame.height + self.frame.height / 60)
                repoNameDesciptionLabel.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
                repoNameDesciptionLabel.textAlignment = .center
                repoNameDesciptionLabel.dynamicFont(fontSize: 11, name: "BBTreeGo_R")
                
                self.addSubview(repoNameDesciptionLabel)
            }
            
            //x좌표 선 그리기
            let xPath = UIBezierPath()
            xPath.lineWidth = 0.5
            xPath.move(to: CGPoint(x: 0, y: self.frame.height * 7 / 8))
            xPath.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height * 7 / 8))
            
            xLayer.path = xPath.cgPath
            
            xLayer.strokeColor = #colorLiteral(red: 0.3921568627, green: 0.3921568627, blue: 0.3921568627, alpha: 1)
            self.layer.addSublayer(xLayer)
            
            self.graphLayer.path = newPath
        }
    }
}
