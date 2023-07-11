//
//  UserEntitiy.swift
//  Ex1
//
//  Created by Trương Duy Tân on 09/06/2023.
//

import Foundation

struct UserEntity: Decodable {

    struct ProfileEntity: Decodable {
        var bio: String?
        var avatar: String?
        var gender: String?
        var genderEnum: Gender {
            guard let uwGender = gender else {
                return .male
            }
            return Gender(rawValue: uwGender) ?? .male
        }
    }

    var id: String?
    var username: String?
    var profile: ProfileEntity?
}
