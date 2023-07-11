//
//  FavoriteAPIService.swift
//  Ex1
//
//  Created by Trương Duy Tân on 21/06/2023.
//

import Foundation
import Alamofire

protocol FavoriteAPIServivce{
    func index(page: Int,
               pageSize: Int,
               success: ((ArrayResponse<PostEntity>) -> Void)?,
               failure: ((APIError?) -> Void)?)
    func favorite(postId: String,
                  success: ((ObjectResponse<FavoriteEntity>) -> Void)?,
                  failure: ((APIError?) -> Void)?)
    func unfavorite(postId: String,
                    success: ((ObjectResponse<FavoriteEntity>) -> Void)?,
                    failure: ((APIError?) -> Void)?)
}

class FavoriteAPIServivceImpl: FavoriteAPIServivce {
    func index(page: Int, pageSize: Int, success: ((ArrayResponse<PostEntity>) -> Void)?, failure: ((APIError?) -> Void)?) {
        let router = FavoriteRouter.index(page: page, pageSize: pageSize)
        
        AF.request(router)
            .cURLDescription { description in
                print(description)
            }
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ArrayResponse<PostEntity>.self) { response in
                switch response.result {
                case .success(let entity):
                    success?(entity)
                case .failure(let afError):
                    failure?(APIError.from(afError: afError))
                }
            }
    }
    
    func favorite(postId: String, success: ((ObjectResponse<FavoriteEntity>) -> Void)?, failure: ((APIError?) -> Void)?) {
        let router = FavoriteRouter.favorite(postId: postId)
        
        AF.request(router)
            .cURLDescription { description in
                print(description)
            }
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ObjectResponse<FavoriteEntity>.self) { response in
                switch response.result {
                case .success(let entity):
                    success?(entity)
                case .failure(let afError):
                    failure?(APIError.from(afError: afError))
                }
            }
    }
    
    func unfavorite(postId: String, success: ((ObjectResponse<FavoriteEntity>) -> Void)?, failure: ((APIError?) -> Void)?) {
        let router = FavoriteRouter.unfavorite(postId: postId)
        
        AF.request(router)
            .cURLDescription { description in
                print(description)
            }
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ObjectResponse<FavoriteEntity>.self) { response in
                switch response.result {
                case .success(let entity):
                    success?(entity)
                case .failure(let afError):
                    failure?(APIError.from(afError: afError))
                }
            }
    }
}
