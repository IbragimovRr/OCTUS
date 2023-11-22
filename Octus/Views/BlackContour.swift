//
//  BlackContour.swift
//  Octus
//
//  Created by Руслан on 22.11.2023.
//

import Foundation
import UIKit

class BlackContour:UIView {
    
    
    @IBInspectable var lineWidth:CGFloat = 1 {
        didSet {
            layer.borderWidth = lineWidth
        }
    }
    @IBInspectable var color:UIColor = UIColor.black {
        didSet {
            layer.borderColor = color.cgColor
        }
    }
    
    
    func createBorder(view:UIView) {
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
    }
    
    func deleteBorder(view:UIView) {
        view.layer.borderWidth = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = lineWidth
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = lineWidth
    }
}
