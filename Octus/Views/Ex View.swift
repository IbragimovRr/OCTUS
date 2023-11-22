//
//  Ex View.swift
//  Octus
//
//  Created by Руслан on 22.03.2024.
//

import Foundation
import UIKit


extension UIView {

  func dropShadow(scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.5
    layer.shadowOffset = CGSize(width: -1, height: 1)
    layer.shadowRadius = 1

    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }

  func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius

    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}

class ShadowView: UIView {
    
    @IBInspectable var shadow:Bool = false {
        didSet {
            if shadow == true {
                self.dropShadow(color: .black, opacity: 0.05, offSet: CGSize(width: -3, height: 3), radius: 10)
            }
        }
    }
    
    
}
