//
//  UserDefaultSingleton.swift
//  Ex1
//
//  Created by Trương Duy Tân on 09/06/2023.
//

import Foundation

class UserDefaultService{
    
    
    //  khởi tạo 1 instance của classs
    static var shared = UserDefaultService()
    private var standard = UserDefaults.standard
    
    private enum Keys: String{
        case kComoletedTutorial
    }
    // ngăn không cho khởi tạo instance thứ 2 của class
    private init(){
        
    }
    
    var conpletedTutorial:Bool{
        get{
            return standard.bool(forKey: "kComoletedTutorial")
        }
        
        set{
            standard.set(newValue, forKey: Keys.kComoletedTutorial.rawValue)
            standard.synchronize()
        }
    }
    func clearAll(){
        standard.removeObject(forKey:"kComoletedTutorial")
    }

}


