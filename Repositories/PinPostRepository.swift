//
//  PinPostRepository.swift
//  Ex1
//
//  Created by Trương Duy Tân on 19/06/2023.
//

import Foundation

protocol PinPostRepository {
    func getPosts(page: Int,
                  pageSize: Int,
                  success: ((ArrayResponse<PostEntity>) -> Void)?,
                  failure: ((APIError?) -> Void)?)
    func pinPost(postID: String,
                success: ((ObjectResponse<PinEntity>) -> Void)?,
                failure: ((APIError?) -> Void)?)
    func unPin(postID: String,
               success: ((ObjectResponse<PinEntity>) -> Void)?,
               failure: ((APIError?) -> Void)?)
}

class PinPostRepositoryImpl: PinPostRepository {
   
    
    
    var pinAPIService: PinPostAPIService
    
    init(pinAPIService: PinPostAPIService) {
        self.pinAPIService = pinAPIService
    }
    
    func getPosts(page: Int, pageSize: Int, success: ((ArrayResponse<PostEntity>) -> Void)?, failure: ((APIError?) -> Void)?) {
        pinAPIService.getPosts(page: page, pageSize: pageSize, success: success, failure: failure)
    }
    func pinPost(postID: String, success: ((ObjectResponse<PinEntity>) -> Void)?, failure: ((APIError?) -> Void)?) {
        pinAPIService.pinPost(postID: postID, success: success, failure: failure)
    }
    func unPin(postID: String, success: ((ObjectResponse<PinEntity>) -> Void)?, failure: ((APIError?) -> Void)?) {
        pinAPIService.unPin(postID: postID, success: success, failure: failure)
    }
}
