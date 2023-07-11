//
//  enums.swift
//  Ex1
//
//  Created by Trương Duy Tân on 09/06/2023.
//

import Foundation

enum APIType {
    case getInit
    case refresh
    case loadmore
}

enum Gender: String, CaseIterable{
    case male
    case female
}
