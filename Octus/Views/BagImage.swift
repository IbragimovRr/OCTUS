//
//  BagImage.swift
//  Octus
//
//  Created by Руслан on 05.12.2023.
//

import Foundation
import UIKit

class BagImage:UIButton {
    
    
    func fill() {
        if Bag().getBagTovars().isEmpty == false {
            self.setImage(UIImage(named: "fillBag"), for: .normal)
        }else{
            self.setImage(UIImage(named: "bag"), for: .normal)
        }
    }
    
}
