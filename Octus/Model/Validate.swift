//
//  Validate.swift
//  Octus
//
//  Created by Руслан on 08.12.2023.
//

import Foundation

class Validate {
    
    func email(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func password(_ password: String) -> Bool {
        if password.count >= 8 {
            return true
        }else {
            return false
        }
    }
}
