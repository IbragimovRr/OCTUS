//
//  UserDefaults.swift
//  Octus
//
//  Created by Руслан on 24.11.2023.
//

import Foundation


class UD {
    //Save
    
    func saveUserID(id:String) {
        UserDefaults.standard.set(id, forKey: "userID")
    }
    
    func saveNameUser(name:String) {
        UserDefaults.standard.set(name, forKey: "name")
    }
    
    func saveInfoUser(height:String,bodyType:String,landing:String){
        UserDefaults.standard.set(height, forKey: "height")
        UserDefaults.standard.set(bodyType, forKey: "bodyType")
        UserDefaults.standard.set(landing, forKey: "landing")
    }
    
    func saveGender(gender:Gender){
        UserDefaults.standard.set(gender.rawValue, forKey: "gender")
    }
    
    func currentUser(current:Bool) {
        UserDefaults.standard.set(current, forKey: "currentUser")
    }
    
    
    
    //Get
    
    func getUserID() -> String {
        return UserDefaults.standard.string(forKey: "userID") ?? ""
    }
    
    
    func getNameUser() -> String? {
        return UserDefaults.standard.string(forKey: "name")
    }
    
    func getCurrentUser() -> Bool {
        return UserDefaults.standard.bool(forKey: "currentUser")
    }
    
    func getGender() -> Gender{
        let gender = UserDefaults.standard.string(forKey: "gender")
        return Gender(rawValue: gender!)!
    }
    
    func getHeightUser() -> String {
        guard let height = UserDefaults.standard.string(forKey: "height") else {return ""}
        return height
    }
    
    func getBodyTypeUser() -> String {
        guard let bodyType = UserDefaults.standard.string(forKey: "bodyType") else {return ""}
        return bodyType
    }
    
    func getLandingTypeUser() -> String {
        guard let landing = UserDefaults.standard.string(forKey: "landing") else {return ""}
        return landing
    }
    
    
    
}
