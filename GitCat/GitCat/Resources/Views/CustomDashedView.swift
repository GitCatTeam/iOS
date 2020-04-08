//
//  CustomDashedView.swift
//  GitCat
//
//  Created by 조윤영 on 04/04/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit


class CustomDashedView: UIView {


    override func draw(_ rect: CGRect) {

        let path = UIBezierPath()
        // >> define the pattern & apply it
        let dashPattern: [CGFloat] = [5.0, 3.0]
        path.setLineDash(dashPattern, count: dashPattern.count, phase: 0)
        // <<
        #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1).set()
        path.lineWidth = 1
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: self.bounds.width, y: 0))
        path.stroke()

    }
}

