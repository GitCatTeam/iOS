//
//  GradientSlider.swift
//  GitCat
//
//  Created by 조윤영 on 2020/09/17.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable
class GradientSlider: UISlider {

    @IBInspectable var thickness: CGFloat = 20 {
        didSet {
            setup()
        }
    }

    @IBInspectable var sliderThumbImage: UIImage? {
        didSet {
            setup()
        }
    }

    func setup() {
        let trackColor1 = #colorLiteral(red: 0.9019607843, green: 0.9607843137, blue: 1, alpha: 1)
        let trackColor2 = #colorLiteral(red: 0.8117647059, green: 0.9176470588, blue: 0.9843137255, alpha: 1)
        let trackColor3 = #colorLiteral(red: 0.6666666667, green: 0.8705882353, blue: 1, alpha: 1)
        let trackColor4 = #colorLiteral(red: 0.5333333333, green: 0.8039215686, blue: 0.9647058824, alpha: 1)
        let maxTrackColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        do {
            self.setMinimumTrackImage(try self.gradientImage(
            size: self.trackRect(forBounds: self.bounds).size,
            colorSet: [trackColor1.cgColor, trackColor2.cgColor, trackColor3.cgColor, trackColor4.cgColor]),
                                      for: .normal)
            self.setMaximumTrackImage(try self.gradientImage(
            size: self.trackRect(forBounds: self.bounds).size,
            colorSet: [maxTrackColor.cgColor, maxTrackColor.cgColor]),
                                  for: .normal)
            self.setThumbImage(sliderThumbImage, for: .normal)
        } catch {
            self.minimumTrackTintColor = trackColor1
            self.maximumTrackTintColor = maxTrackColor
        }
    }

    func gradientImage(size: CGSize, colorSet: [CGColor]) throws -> UIImage? {
        let tgl = CAGradientLayer()
        tgl.frame = CGRect.init(x:0, y:0, width:size.width, height: size.height)
        tgl.cornerRadius = tgl.frame.height / 2
        tgl.masksToBounds = false
        tgl.colors = colorSet
        tgl.startPoint = CGPoint.init(x:0.0, y:0.5)
        tgl.endPoint = CGPoint.init(x:1.0, y:0.5)

        UIGraphicsBeginImageContextWithOptions(size, tgl.isOpaque, 0.0);
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        tgl.render(in: context)
        let image =

    UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets:
        UIEdgeInsets.init(top: 0, left: size.height, bottom: 0, right: size.height))
        UIGraphicsEndImageContext()
        return image!
    }

    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(
            x: bounds.origin.x,
            y: bounds.origin.y,
            width: bounds.width,
            height: thickness
        )
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}
