//
//  UserAPIService.swift
//  PostsApp
//
//  Created by Hà Văn Đức on 03/06/2023.
//

import Foundation
import Alamofire

protocol UserAPIService {
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

class UserAPIServiceImpl: UserAPIService {
    func profile(success: ((UserEntity) -> Void)?,
                 failure: ((APIError?) -> Void)?) {
        let router = UserAPIServiceRouter.profile
        
        AF.request(router)
            .cURLDescription { description in
                print(description)
            }
            .validate(statusCode: 200..<300)
            .responseDecodable(of: UserEntity.self) { response in
            switch response.result {
            case .success(let entity):
                success?(entity)
            case .failure(let afError):
                failure?(APIError.from(afError: afError))
            }
        }
    }
    
    func updateProfile(gender: String?,
                       bio: String?,
                       avatar: String?,
                       success: ((ObjectResponse<UserEntity>) -> Void)?,
                       failure: ((APIError?) -> Void)?) {
        var body: Parameters = [
            "gender": gender,
            "bio": bio
        ]
        if avatar != nil {
            body["avatar"] = avatar!
        }
        let router = UserAPIServiceRouter.updateProfile(body: body)
        
        AF.request(router)
            .cURLDescription { description in
                print(description)
            }
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ObjectResponse<UserEntity>.self) { response in
            switch response.result {
            case .success(let entity):
                success?(entity)
            case .failure(let afError):
                failure?(APIError.from(afError: afError))
            }
        }
    }
    
    func updateAvatar(avatar data: Data,
                      success: ((ObjectResponse<UserEntity>) -> Void)?,
                      failure: ((APIError?) -> Void)?) {
        let router = UserAPIServiceRouter.updateAvatar
        
        AF.upload(multipartFormData: { formData in
            formData.append(data, withName: "avatar", fileName: "avatar_\(Date().timeIntervalSince1970).jpg", mimeType: "image/jpg")
        }, with: router)
        .cURLDescription { description in
            print(description)
        }
        .validate(statusCode: 200..<300)
        .responseDecodable(of: ObjectResponse<UserEntity>.self) { response in
            switch response.result {
            case .success(let entity):
                success?(entity)
            case .failure(let afError):
                failure?(APIError.from(afError: afError))
            }
        }
    }
}
