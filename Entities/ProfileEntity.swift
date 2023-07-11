//
//  ProfileEntity.swift
//  Ex1
//
//  Created by Trương Duy Tân on 14/06/2023.
//

import Foundation

struct ProfileEntity: Decodable{
    var bio: String?
    var created: String?
    var updated: String?
    var gender: String?
    var avatar: String?
    
    enum CodingKeys: String, CodingKey{
        case bio = "bio"
        case created = "created_at"
        case updated = "updated_at"
        case gender = "gender"
        case avatar = "avatar"
    }
}
