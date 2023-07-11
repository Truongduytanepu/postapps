//
//  UserRepository.swift
//  Ex1
//
//  Created by Trương Duy Tân on 28/06/2023.
//

import Foundation

//xử lú phản hồi api
protocol UserRepository {
    func profile(success: ((UserEntity) -> Void)?,
                 failure: ((APIError?) -> Void)?)
    
    func updateProfile(gender: String?,
                       bio: String?,
                       avatar: String?,
                       success: ((ObjectResponse<UserEntity>) -> Void)?,
                       failure: ((APIError?) -> Void)?)
    
    func updateAvatar(avatar data: Data,
                      success: ((ObjectResponse<UserEntity>) -> Void)?,
                      failure: ((APIError?) -> Void)?)
}

class UserRepositoryImpl: UserRepository{
    
    var apiService: UserAPIService
    init(apiService: UserAPIService) {
        self.apiService = apiService
    }
    func profile(success: ((UserEntity) -> Void)?, failure: ((APIError?) -> Void)?) {
        apiService.profile(success: success, failure: failure)
    }
    
    func updateProfile(gender: String?, bio: String?, avatar: String?, success: ((ObjectResponse<UserEntity>) -> Void)?, failure: ((APIError?) -> Void)?) {
        apiService.updateProfile(gender: gender, bio: bio, avatar: avatar, success: success, failure: failure)
    }
    
    func updateAvatar(avatar data: Data, success: ((ObjectResponse<UserEntity>) -> Void)?, failure: ((APIError?) -> Void)?) {
        apiService.updateAvatar(avatar: data, success: success, failure: failure)
    }
    
    
}
