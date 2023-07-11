//
//  PinEntity.swift
//  Ex1
//
//  Created by Trương Duy Tân on 22/06/2023.
//

import Foundation

struct PinEntity: Codable {
    let isPin: Bool?
    let user, postID, createdAt, updatedAt: String?
    let id: String?
    
    enum CodingKeys: String, CodingKey {
        case isPin, user
        case postID = "post"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case id
    }
}
