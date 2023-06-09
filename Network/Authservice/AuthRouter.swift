//
//  AuthRouter.swift
//  Ex1
//
//  Created by Trương Duy Tân on 07/06/2023.
//

import Foundation
import Alamofire


enum AuthRouter: URLRequestConvertible{
    case login(username: String, password: String)
    case register(username: String, name: String, password: String)
    case logout
    case refresh(refresh: String)
    
    var baseURL: URL{
        return URL(string: NetworkConstant.domain)!
        
    }
    
    var method: HTTPMethod{
        switch self{
        case .login, .register, .refresh:
            return .post
        case .logout:
            return .delete
        }
    }
    
    var path: String{
        switch self{
        case .login:
            return "login"
        case .register:
            return "register"
        case .logout:
            return "logout"
        case .refresh:
            return "refresh_token"
        }
    }
    var parameters: Parameters? {
        switch self {
        case .login(let username, let password):
            return [
                "username": username,
                "password": password
            ]
        case .register(let username, let name, let password):
            return [
                "username": username,
                "name": name,
                "password": password
            ]
        case .refresh(let refresh):
            return [
                "refresh_token": refresh
            ]
        default:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        switch self{
        case .login, .register, .refresh:
            request = try JSONEncoding.default.encode(request, with: parameters)
        case .logout:
            request = try JSONEncoding.default.encode(request, with: nil)
        }
        request.timeoutInterval = 30
        return request
    }
}
