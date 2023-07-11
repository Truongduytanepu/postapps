//
//  ArrayResponse.swift
//  Ex1
//
//  Created by Trương Duy Tân on 14/06/2023.
//

import Foundation

struct ArrayResponse<T: Decodable>: Decodable {
    var page: Int = 1
    var pageSize: Int = 0
    var results: [T] = []

    var isCanLoadmore: Bool {
        return results.count == pageSize
    }

    enum CodingKeys: String, CodingKey {
        case results = "data"
        case page = "page"
        case pageSize = "pageSize"
    }
}
