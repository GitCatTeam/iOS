//
//  PieChartView.swift
//  GitCat
//
//  Created by 조윤영 on 2020/08/14.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
import UIKit

class PieChartView: UIView, CAAnimationDelegate {
    let circleLayer: CAShapeLayer = CAShapeLayer()
    
    var startAngle: CGFloat = (-(.pi) / 2)
    var endAngle: CGFloat = 0.0
    var values: [Double] = []
    var colors: [UIColor] = []
    var currentIndex: Int = 0
    var myCenter = CGPoint.zero
    var graphiWdth: Double = 0
  
    init(frame: CGRect, values: [Double], colors:[UIColor], width:Double) {
        super.init(frame: frame)
        self.values = values
        self.colors = colors
        self.graphiWdth = width
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect:CGRect) {
        self.myCenter = CGPoint(x: rect.midX, y: rect.midY)
        self.add(value: values[currentIndex])
    }
  
    func add(value: Double) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 0.3
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.delegate = self
        let total = values.reduce(0, +)
        endAngle = CGFloat((value/total) * (.pi*2))
    
        let path = UIBezierPath(arcCenter: self.myCenter, radius: CGFloat(self.graphiWdth/3), startAngle: startAngle, endAngle: startAngle + endAngle, clockwise: true)
        let sliceLayer = CAShapeLayer()
        sliceLayer.path = path.cgPath
        sliceLayer.fillColor = nil
        sliceLayer.strokeColor = self.colors[currentIndex].cgColor

        sliceLayer.lineWidth = CGFloat(graphiWdth/5)
        
        sliceLayer.strokeEnd = 1
        sliceLayer.add(animation, forKey: animation.keyPath)
        
        self.layer.addSublayer(sliceLayer)
    }
  
    func animationDidStop(_ anim: CAAnimation, finished flag:Bool) {
        let isFinished = flag
        if isFinished && currentIndex < self.values.count - 1 {
            self.currentIndex += 1
            self.startAngle += endAngle
            self.add(value: self.values[currentIndex])
        }
    }
}
