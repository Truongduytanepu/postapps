//
//  PinPostRouter.swift
//  Ex1
//
//  Created by Trương Duy Tân on 19/06/2023.
//

import Foundation
import Alamofire

enum PinPostRouter: URLRequestConvertible {
    case getPosts(page: Int, pageSize: Int)
    case pin(postID: String)
    case unPin(postID: String)
    
    var baseURL: URL {
        return URL(string: NetworkConstant.domain)!
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPosts:
            return .get
        case .pin:
            return .post
        case .unPin:
            return .delete
        }
    }
    
    var path: String {
        switch self {
        case .getPosts:
            return "pin"
        case .pin:
            return "pin"
        case .unPin:
            return "pin"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getPosts(let page, let pageSize):
            return [
                "page": page,
                "pageSize": pageSize
            ]
        case .pin(let postID):
            return [
                "post_id": postID
            ]
        case .unPin(let postID):
            return [
                "post_id" : postID
            ]
        default:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        
        //Kiểm tra xem đã login hay chưa, nếu login rồi thì gán accessToken thì gán vào header có field là "Authorization"
        if AuthService.share.isLoggedIn {
            let accessToken = AuthService.share.accessToken
            request.setValue(String(format: "Bearer %@", accessToken),
                             forHTTPHeaderField: "Authorization")
        }
        
        switch self {
        case .getPosts, .unPin:
            request = try URLEncoding.default.encode(request, with: parameters)
        case .pin:
            request = try JSONEncoding.default.encode(request, with: parameters)
        }
        request.timeoutInterval = 10
        return request
    }
}

