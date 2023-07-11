//
//  FavoriteRouter.swift
//  Ex1
//
//  Created by Trương Duy Tân on 21/06/2023.
//

import Foundation
import Alamofire

enum FavoriteRouter: URLRequestConvertible {
    case index(page: Int, pageSize: Int)
    case favorite(postId: String)
    case unfavorite(postId: String)

    var baseURL: URL {
        return URL(string: NetworkConstant.domain)!
    }

    var method: HTTPMethod {
        switch self {
        case .index:
            return .get
        case .favorite:
            return .post
        case .unfavorite:
            return .delete
        }
    }

    var path: String {
        switch self {
        case .index, .favorite, .unfavorite:
            return "favorites"
            
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .index(let page, let pageSize):
            return [
                "page": page,
                "pageSize": pageSize
            ]
        case .favorite(let postId):
            return [
                "post_id": postId
            ]
        case .unfavorite(let postId):
            return [
                "post_id": postId
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
        switch self{
        case .unfavorite, .index:
            request = try URLEncoding.default.encode(request, with: parameters)
        case .favorite:
            request = try JSONEncoding.default.encode(request, with: parameters)
        }
       
        return request
    }
}
