//
//  LabelExtension.swift
//  GitCat
//
//  Created by 조윤영 on 09/03/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func dynamicFont(fontSize size: CGFloat, name: String) {
    let bounds = UIScreen.main.bounds
    let height = bounds.size.height

    switch height {
    case 480.0: //Iphone 3,4S => 3.5 inch
      self.font = UIFont(name: name, size: size * 0.7)
      break
    case 568.0: //iphone 5, SE => 4 inch
    self.font = UIFont(name: name, size: size * 0.8)
      break
    case 667.0: //iphone 6, 6s, 7, 8 => 4.7 inch
        self.font = UIFont(name: name, size: size * 0.92)
      break
    case 736.0: //iphone 6s+ 6+, 7+, 8+ => 5.5 inch
        self.font = UIFont(name: name, size: size * 0.95)
      break
    case 812.0: //iphone X, XS => 5.8 inch
        self.font = UIFont(name: name, size: size)
      break
    case 896.0: //iphone XR => 6.1 inch  // iphone XS MAX => 6.5 inch
        self.font = UIFont(name: name, size: size * 1.1)
      break
    case 1194.0:
        self.font = UIFont(name: name, size: size * 1.7)
        break
    case 1366.0: //iPad 12.9 inch
        self.font = UIFont(name: name, size: size * 1.7)
        break
    default:
      break
    }
  }
  
}

