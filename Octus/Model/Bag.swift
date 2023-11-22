//
//  Bag.swift
//  Octus
//
//  Created by Руслан on 04.12.2023.
//

import Foundation
import RealmSwift


class Bag {
    
    
    func saveToBag(tovar:Tovar,size:String?) {
        let realm = try! Realm()
        let bagRealm = BagRealmTovar()
        bagRealm.article = tovar.article!
        bagRealm.name = tovar.name!
        bagRealm.price = tovar.price!
        bagRealm.size = size
        bagRealm.image = tovar.image![0]
        try! realm.write {
            realm.add(bagRealm)
        }
        
    }
    
    func getBagTovars() -> [BagRealmTovar] {
        let realm = try! Realm()
        let objects = realm.objects(BagRealmTovar.self)
        var tovars = [BagRealmTovar]()
        for x in objects {
            tovars.append(x)
        }
        return tovars
    }
    
    func delete(tovar: BagRealmTovar){
        let realm = try! Realm()
        try! realm.write {
            realm.delete(tovar)
        }
    }
    
}
