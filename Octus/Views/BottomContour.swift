//
//  BottomContour.swift
//  Octus
//
//  Created by Руслан on 05.12.2023.
//

import Foundation
import UIKit

class BottomContour:UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let borderBottom = CALayer()
        borderBottom.backgroundColor = UIColor(named: "gray2")?.cgColor
        bor
        borderBottom.frame = CGRect(x: 0, y: self
            .frame.size.height - 1, width: self.frame.size.width, height: 1)
        self.layer.addSublayer(borderBottom)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let borderBottom = CALayer()
        borderBottom.backgroundColor = UIColor.black.cgColor
        borderBottom.frame = CGRect(x: 0, y: self
            .frame.size.height - 1, width: self
            .frame.size.width, height: 1)
        self
            .layer.addSublayer(borderBottom)
    }
}
