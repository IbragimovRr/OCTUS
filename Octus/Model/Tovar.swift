//
//  Tovar.swift
//  Octus
//
//  Created by Руслан on 28.11.2023.
//

import Foundation
import Firebase

class Tovar {
    
    var brand:Brand?
    var name:String?
    var color:[String]?
    var image:[String]?
    var size:[String]?
    var outfit:String?
    var price:Int?
    var article:Int?
    var type:TypeClothes?
    
    private static let db = Firestore.firestore()
    
    static func create(tovar:Tovar) {
        let article = Int.random(in: 0..<99999999)
        db.collection("Clothes").document("\(article)").setData([
            "article":article,
            "name":tovar.name,
            "brand":tovar.brand?.name,
            "price":tovar.price,
            "color":tovar.color,
            "image":tovar.image,
            "size":tovar.size,
            "outfit":tovar.outfit,
            "type":tovar.type?.rawValue
        ])
    }
    
    static func getTovars(type:TypeClothes, completion:@escaping ([Tovar]) -> ()) {
        var tovars = [Tovar]()
        db.collection("Clothes").whereField("type", isEqualTo: type.rawValue).getDocuments { qs, err in
            if err == nil {
                for documents in qs!.documents {
                    let data = documents.data()
                    let article = data["article"] as? Int
                    let name = data["name"] as? String
                    let brandName = data["brand"] as? String
                    let price = data["price"] as? Int
                    let color = data["color"] as? [String]
                    let images = data["image"] as? [String]
                    let sizes = data["size"] as? [String]
                    let outfit = data["outfit"] as? String
                    let type = data["type"] as? String
                    let tovar = Tovar()
                    let brand = Brand()
                    brand.name = brandName
                    tovar.brand = brand
                    tovar.image = images
                    tovar.name = name
                    tovar.price = price
                    tovar.size = sizes
                    tovar.article = article
                    tovar.color = color
                    tovar.outfit = outfit
                    tovar.type = TypeClothes(rawValue: type!)!
                    tovars.append(tovar)
                }
                completion(tovars)
            }
        }
    }
    
    static func getTovarByArticle(article:Int, completion:@escaping (Tovar) -> ()) {
        db.collection("Clothes").document("\(article)").getDocument { qs, err in
            if err == nil {
                let data = qs!.data()
                let article = data?["article"] as? Int
                let name = data?["name"] as? String
                let brandName = data?["brand"] as? String
                let price = data?["price"] as? Int
                let color = data?["color"] as? [String]
                let images = data?["image"] as? [String]
                let sizes = data?["size"] as? [String]
                let outfit = data?["outfit"] as? String
                let type = data?["type"] as? String
                let tovar = Tovar()
                let brand = Brand()
                brand.name = brandName
                tovar.brand = brand
                tovar.image = images
                tovar.name = name
                tovar.price = price
                tovar.size = sizes
                tovar.article = article
                tovar.color = color
                tovar.outfit = outfit
                tovar.type = TypeClothes(rawValue: type!)!
                completion(tovar)
            }
        }
    }
    
    static func searchTovar(searchText:String,field:String = "name",completion:@escaping ([Tovar]) -> ()) {
        var text = searchText.capitalizingFirstLetter()
        var tovars = [Tovar]()
        db.collection("Clothes")
            .whereField(field, isGreaterThanOrEqualTo: text)
            .whereField(field, isLessThanOrEqualTo: text+"\u{F7FF}")
            .getDocuments { qs, err in
                if err == nil {
                    tovars.removeAll()
                    for documents in qs!.documents {
                        let data = documents.data()
                        let article = data["article"] as? Int
                        let name = data["name"] as? String
                        let brandName = data["brand"] as? String
                        let price = data["price"] as? Int
                        let color = data["color"] as? [String]
                        let images = data["image"] as? [String]
                        let sizes = data["size"] as? [String]
                        let outfit = data["outfit"] as? String
                        let type = data["type"] as? String
                        let tovar = Tovar()
                        let brand = Brand()
                        brand.name = brandName
                        tovar.brand = brand
                        tovar.image = images
                        tovar.name = name
                        tovar.price = price
                        tovar.size = sizes
                        tovar.article = article
                        tovar.color = color
                        tovar.outfit = outfit
                        tovar.type = TypeClothes(rawValue: type!)!
                        tovars.append(tovar)
                    }
                    completion(tovars)
                }
            }
    }
    
}
