//
//  AuthRepository.swift
//  Ex1
//
//  Created by Trương Duy Tân on 05/06/2023.
//

import Foundation

// thực hiện yêu cầu thông qua API
protocol AuthRepository {
    /**
     
     */
    func login(username: String,
               password: String,
               success: ((LoginEntity) -> Void)?,
               failure: ((APIError?) -> Void)?)
    
    func register(username: String,
                  nickname: String,
                  password: String,
                  confirmPassword: String,
                  success: ((LoginEntity) -> Void)?,
                  failure: ((APIError?) -> Void)?)
}

class AuthRepositoryImpl: AuthRepository {
    
    var authAPIService: AuthAPIService
    
    init(authAPIService: AuthAPIService) {
        self.authAPIService = authAPIService
    }
    
    func login(username: String,
               password: String,
               success: ((LoginEntity) -> Void)?,
               failure: ((APIError?) -> Void)?) {
        authAPIService.login(username: username, password: password, success: success, failure: failure)
    }
    
    func register(username: String,
                  nickname: String,
                  password: String,
                  confirmPassword: String,
                  success: ((LoginEntity) -> Void)?,
                  failure: ((APIError?) -> Void)?) {
        authAPIService.register(username: username, nickname: nickname, password: password, confirmPassword: confirmPassword, success: success, failure: failure)
    }
}
