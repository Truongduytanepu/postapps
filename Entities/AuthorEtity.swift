//
//  AuthorEtity.swift
//  Ex1
//
//  Created by Trương Duy Tân on 14/06/2023.
//

import Foundation

struct AuthorEntity: Decodable{
    var username: String?
    var created: String?
    var updated: String?
    var profile: ProfileEntity?
    var id: String
    
    enum CodingKeys: String, CodingKey{
        case username = "username"
        case created = "created_at"
        case updated = "updated_at"
        case profile = "profile"
        case id = "id"
    }
}
