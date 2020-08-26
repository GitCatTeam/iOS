//
//  LineChartView.swift
//  GitCat
//
//  Created by 조윤영 on 2020/08/14.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
import UIKit

class LineChartView: UIView {
    var values: [Int] = []
    var dates: [String] = []
    var max:Int = 0
  
    var graphPath: UIBezierPath!
    var zeroPath: UIBezierPath!
    var animated: Bool!
  
    let graphLayer = CAShapeLayer()
    let xLayer = CAShapeLayer()
  
    init(frame: CGRect, values: [Int], dates: [String], animated: Bool) {
        super.init(frame: frame)
        self.values = values
        self.dates = dates
        self.animated = animated
      }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        //MARK: x 그리드 선 그리기
        drawXGridLine()
        //MARK: Line차트 그래프 그리기
        drawLineChart()
    }
    
    func drawXGridLine() {
        var xGrideHeight:CGFloat = 0
        
        for i in 0..<values.count {
            max = max < values[i] ? values[i] : max
        }
        
        for i in 0..<6 {
            let xPath = UIBezierPath()
            xPath.lineWidth = 0.5
            xPath.move(to: CGPoint(x: 0, y: self.frame.height))
            xPath.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
            
            xLayer.path = xPath.cgPath
            
            xLayer.strokeColor = #colorLiteral(red: 0.3921568627, green: 0.3921568627, blue: 0.3921568627, alpha: 1)
            self.layer.addSublayer(xLayer)
            
            let xGridLayer = CAShapeLayer()
            let xGridPath = UIBezierPath()
            
            xGridLayer.lineWidth = 1
            xGridLayer.lineDashPattern = .some([2,2])

            xGrideHeight += (self.frame.height / 7)

            xGridPath.move(to: CGPoint(x: 0, y: xGrideHeight))
            xGridPath.addLine(to: CGPoint(x: self.frame.width, y: xGrideHeight))
            
            xGridLayer.path = xGridPath.cgPath
            
            xGridLayer.strokeColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
            self.layer.addSublayer(xGridLayer)
            
            //그리드 선에 맞는 값라벨 표시하기
            var valueDescriptionLabel: UILabel!
            valueDescriptionLabel = UILabel(frame: CGRect(x: -15, y: xGrideHeight, width: 100, height: 100))
            
            if(max < 5) {
                valueDescriptionLabel.text = "\(5-i)"
            } else {
                if(i == 5) {
                    valueDescriptionLabel.text = "0"
                } else {
                    valueDescriptionLabel.text = "\(Int(max) - i * (Int(max) / 5))"
                }
            }
            
            valueDescriptionLabel.center = CGPoint(x: -15, y: xGrideHeight)
            valueDescriptionLabel.textColor = #colorLiteral(red: 0.537254902, green: 0.8, blue: 0.9647058824, alpha: 1)
            valueDescriptionLabel.dynamicFont(fontSize: 11, name: "BBTreeGo_R")
            valueDescriptionLabel.textAlignment = .center
            
            self.addSubview(valueDescriptionLabel)
        }
    }
    
    func drawLineChart() {
        self.graphPath = UIBezierPath()
        self.zeroPath = UIBezierPath()
            
        self.layer.addSublayer(graphLayer)
            
        let xOffset: CGFloat = self.frame.width / CGFloat(values.count)
        
        var currentX: CGFloat = 0
        let startPosition = CGPoint(x:currentX, y: self.frame.height)
        self.graphPath.move(to: startPosition)
        self.zeroPath.move(to: startPosition)
            
        for i in 0..<values.count {
            currentX += xOffset
            
            var newValue: Double = 0.0
            if(max < 5) {
                newValue = Double(self.values[i]) / 5
            } else {
                newValue = Double(self.values[i]) / Double(max)
            }
            var newY = self.frame.height - (self.frame.height / 6 + (self.frame.height * 5 / 6 * CGFloat(newValue))) + 4
            if (newY < 0) { newY = 0 }
            let newPosition = CGPoint(x: currentX, y: newY )
            self.graphPath.addLine(to: newPosition)
            self.zeroPath.addLine(to: CGPoint(x: currentX, y: self.frame.height))
                
                //x좌표 값 추가하기
                if(Int(dates[i])! % 5 == 0) {
                    drawXLabel(currentX: currentX, index: i)
                }
            }
            
            self.graphPath.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
            self.zeroPath.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
            
            graphLayer.fillColor = #colorLiteral(red: 0.5411764706, green: 0.7960784314, blue: 0.9647058824, alpha: 0.36)
            graphLayer.strokeColor = nil
            graphLayer.lineCap = .round
            graphLayer.lineJoin = .round
            
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
            self.graphLayer.path = newPath
    }
    
    func drawXLabel(currentX: CGFloat, index: Int) {
        var xLabel: UILabel!
        xLabel = UILabel(frame: CGRect(x: currentX, y: self.frame.height + self.frame.height / 20, width: 100, height: 100))
        xLabel.text = "\(dates[index])"
        xLabel.center = CGPoint(x: currentX, y: self.frame.height + self.frame.height / 20)
        xLabel.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        xLabel.textAlignment = .center
        xLabel.dynamicFont(fontSize: 11, name: "BBTreeGo_R")
        
        self.addSubview(xLabel)
    }
}
