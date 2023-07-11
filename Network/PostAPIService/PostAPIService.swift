//
//  PostAPIService.swift
//  Ex1
//
//  Created by Trương Duy Tân on 14/06/2023.
//

import Foundation
import Alamofire

protocol PostAPIService{
    func index(page: Int,
               pageSize: Int,
               success: ((ArrayResponse<PostEntity>) -> Void)?,
               failure: ((APIError?) -> Void)?)
}

class PostAPIServiceImpl: PostAPIService {
    func index(page: Int, pageSize: Int, success: ((ArrayResponse<PostEntity>) -> Void)?, failure: ((APIError?) -> Void)?) {
        let router = PostRouter.index(page: page, pageSize: pageSize)
        
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
}



