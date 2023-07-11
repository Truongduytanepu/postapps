//
//  AuthAPIService.swift
//  Ex1
//
//  Created by Trương Duy Tân on 09/06/2023.
//

import Foundation
import Alamofire

protocol AuthAPIService {
    func login(username: String, password: String,
               success: ((LoginEntity) -> Void)?,
               failure: ((APIError?) -> Void)?)
    func register(username: String,
                  nickname: String,
                  password: String,
                  confirmPassword: String,
                  success: ((LoginEntity) -> Void)?,
                  failure: ((APIError?) -> Void)?)
    
    func logout(success: ((LoginEntity) -> Void)?,
                failure: ((APIError?) -> Void)?)
}

class AuthAPIServiceImpl: AuthAPIService {
    func login(username: String, password: String, success: ((LoginEntity) -> Void)?, failure: ((APIError?) -> Void)?) {
        let router = AuthRouter.login(username: username, password: password)

        NetworkManager.shared.callAPI(router: router, success: success, failure: failure)
//        AF.request(router)
//            .cURLDescription { description in
//                print(description)
//            }
//            .validate(statusCode: 200..<300)
//            .responseDecodable(of: LoginEntity.self) { response in
//                switch response.result {
//                case .success(let entity):
//                    success?(entity)
//                case .failure(let afError):
//                    failure?(APIError.from(afError: afError))
//                }
            }
    func logout(success: ((LoginEntity) -> Void)?, failure: ((APIError?) -> Void)?) {
        
    }
    
    func register(username: String, nickname: String, password: String, confirmPassword: String, success: ((LoginEntity) -> Void)?, failure: ((APIError?) -> Void)?) {
        let router = AuthRouter.register(username: username, name: nickname, password: password)
        AF.request(router)
            .cURLDescription { description in
                print(description)
            }
            .validate(statusCode: 200..<300)
            .responseDecodable(of: LoginEntity.self) { response in
                switch response.result {
                case .success(let entity):
                    success?(entity)
                case .failure(let afError):
                    failure?(APIError.from(afError: afError))
                }
                
            }
    }
}












