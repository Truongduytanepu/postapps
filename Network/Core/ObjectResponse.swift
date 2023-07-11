//
//  ObjectResponse.swift
//  Ex1
//
//  Created by Trương Duy Tân on 21/06/2023.
//

import Foundation
import ObjectMapper

class ObjectResponse<T: Decodable>: Decodable {
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}
