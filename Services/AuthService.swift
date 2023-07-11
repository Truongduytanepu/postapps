//
//  AuthService.swift
//  Ex1
//
//  Created by Trương Duy Tân on 09/06/2023.
//

import Foundation
import KeychainSwift


//lưu trữ và quản lý keychain
class AuthService{
    static var share = AuthService()
    private var keychain: KeychainSwift
    private enum Keys: String{
        case kAccessToken
        case kRefreshToken

    }
    
    
    
    private init(){
        keychain = KeychainSwift()
    }
    
    //đọc và ghi giá trị token
    var accessToken:String{
        get{
            // trả về giá trị token
            return keychain.get(Keys.kAccessToken.rawValue) ?? ""
        }
        set{
            // nếu giá trị rỗng, sẽ xóa tương ứng trong keychain
            if newValue.isEmpty{
                keychain.delete(Keys.kAccessToken.rawValue)
            //lưu giá trị vào keychain
            }else{
                keychain.set(newValue, forKey: Keys.kAccessToken.rawValue)
            }
        }
    }
    var refreshToken: String{
        get{
            // trả về giá trị token
            return keychain.get(Keys.kAccessToken.rawValue) ?? ""
        }
        set{
            // nếu giá trị rỗng, sẽ xóa tương ứng trong keychain
            if newValue.isEmpty{
                keychain.delete(Keys.kAccessToken.rawValue)
                //lưu giá trị vào keychain
            }else{
                keychain.set(newValue, forKey: Keys.kAccessToken.rawValue)
            }
        }
    }
    // kiểm tra xem token có khác rỗng không
    var isLoggedIn: Bool{
        return !accessToken.isEmpty
    }
    
    
    // kiểm tra user đã login hay chưa
    func clearAll(){
        accessToken = ""
    }


}
