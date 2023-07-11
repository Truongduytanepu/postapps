//
//  Constants.swift
//  Ex1
//
//  Created by Trương Duy Tân on 07/06/2023.
//

import Foundation
import Alamofire


//Xử lí domain của API
struct NetworkConstant {
    static var domain = "http://ec2-52-195-148-148.ap-northeast-1.compute.amazonaws.com"
}

struct APIError {
    var errorCode: String?
    var errorMsg: String?
    var errorKey: String?

    static func from(afError: AFError) -> APIError {
        return APIError(errorMsg: afError.errorDescription)
    }
}
