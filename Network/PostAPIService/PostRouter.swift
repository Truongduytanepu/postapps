//
//  PostRouter.swift
//  Ex1
//
//  Created by Trương Duy Tân on 14/06/2023.
//

import Foundation
import Alamofire

enum PostRouter: URLRequestConvertible {
    case index(page: Int, pageSize: Int)
    

    var baseURL: URL {
        return URL(string: NetworkConstant.domain)!
    }

    var method: HTTPMethod {
        switch self {
        case .index:
            return .get
        }
    }

    var path: String {
        switch self {
        case .index:
            return "posts"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .index(let page, let pageSize):
            return [
                "page": page,
                "pageSize": pageSize
            ]
        default:
            return nil
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        
        
        
        // kiểm tra xem đã login chưa
        //nếu login rồi thì gán accessToken với tiền tố là bearer vào header có field là authorization
        if AuthService.share.isLoggedIn {
            let accessToken = AuthService.share.accessToken
            request.setValue(String(format: "Bearer %@", accessToken),
                             forHTTPHeaderField: "Authorization")
        }
        switch self.method {
        case .get:
            request = try URLEncoding.default.encode(request, with: parameters)
        default:
            request = try JSONEncoding.default.encode(request, with: parameters)
        }
        return request
    }
}

