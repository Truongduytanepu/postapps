//
//  FavoriteRepository.swift
//  Ex1
//
//  Created by Trương Duy Tân on 21/06/2023.
//

import Foundation

protocol FavoritePostRepository {
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

class FavoritePostRepositoryImpl: FavoritePostRepository {
    var apiService: FavoriteAPIServivce
    
    init(apiService: FavoriteAPIServivce) {
        self.apiService = apiService
    }
    
    func index(page: Int,
               pageSize: Int,
               success: ((ArrayResponse<PostEntity>) -> Void)?, failure: ((APIError?) -> Void)?) {
        apiService.index(page: page, pageSize: pageSize, success: success, failure: failure)
    }
    
    func favorite(postId: String,
                  success: ((ObjectResponse<FavoriteEntity>) -> Void)?,
                  failure: ((APIError?) -> Void)?) {
        apiService.favorite(postId: postId, success: success, failure: failure)
    }
    
    func unfavorite(postId: String,
                    success: ((ObjectResponse<FavoriteEntity>) -> Void)?,
                    failure: ((APIError?) -> Void)?) {
        apiService.unfavorite(postId: postId, success: success, failure: failure)
    }
}
