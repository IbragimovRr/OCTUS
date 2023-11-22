//
//  Modul.swift
//  Octus
//
//  Created by Руслан on 22.11.2023.
//

import Foundation
import RealmSwift
import FirebaseAuth


enum Gender:String {
    case male = "Male"
    case female = "Female"
}

enum InfoUser {
    case landing
    case bodyType
    case height
}

enum TypeClothes:String {
    case news = "News"
    case brand = "Brand"
    case clothes = "Clothes"
    case shoes = "Shoes"
    case bag = "Bag"
    case accessories = "Accessories"
}

// MARK: - Error Ex

extension AuthErrorCode.Code {
    var errorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "Этот email уже используется в другой учетной записи"
        case .userDisabled:
            return "Ваша учетная запись была отключена. Пожалуйста, обратитесь в службу поддержки."
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return "Пожалуйста, введите действительный адрес электронной почты"
        case .networkError:
            return "Ошибка сети. Пожалуйста, попробуйте снова."
        case .weakPassword:
            return "Ваш пароль слишком слабый. Длина пароля должна составлять не менее 6 символов."
        case .wrongPassword:
            return "Не правильный пароль"
        case .userNotFound:
            return "Учетная запись не найдена"
        case .tooManyRequests:
            return "Слишком много попыток"
        case .internalError:
            return  "Неправильный логин или пароль"
        default:
            return "Неизвестная ошибка повторите позже"
        }
    }
}



// MARK: - Realm

class BagRealmTovar:Object {
    @objc dynamic var name:String?
    @objc dynamic var image:String?
    @objc dynamic var article:Int = 0
    @objc dynamic var size:String?
    @objc dynamic var price = 0
    @objc dynamic var amount = 1
}

// MARK: - String

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
