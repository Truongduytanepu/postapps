//
//  PostRepository.swift
//  Ex1
//
//  Created by Trương Duy Tân on 16/06/2023.
//

import Foundation
import CoreData
protocol PostRespository{
    func index(page: Int,
               pageSize: Int,
               success: ((ArrayResponse<PostEntity>) -> Void)?,
               failure: ((APIError?) -> Void)?)
}

class PostRespositoryImpl: PostRespository{
    
    var apiService: PostAPIService
//    var coreDataService: PostCoreDataService
    
    init(apiService: PostAPIService) {
        self.apiService = apiService
    }
//    }
//    func index(page: Int,
//               pageSize: Int,
//               success: ((ArrayResponse<PostEntity>) -> Void)?,
//               failure: ((APIError?) -> Void)?){
//
//        // kiểm tra xem có internet không, nếu có thì thực hiện call api bình thường và save dât xuoosng coredata
//        if Connectivity.isConnectedToInternet{
//            apiService.index(page: page, pageSize: page, success: { reponse in
//                if !reponse.results.isEmpty{
//                    self.coreDataService.clear()
//
//                    reponse.results.forEach{ post in
//                        self.coreDataService.create(postEntity: post)
//                    }
//                }
//                success?(reponse)
//
//
//            }, failure: { err in
//                self.coreDataService.index(page: page, pageSize: pageSize, success: success, failure: failure)
//            }
//            )}
//        else{
//            coreDataService.index(page: page, pageSize: pageSize, success: success, failure: failure)
//        }
//
        func index(page: Int, pageSize: Int, success: ((ArrayResponse<PostEntity>) -> Void)?, failure: ((APIError?) -> Void)?) {
            apiService.index(page: page, pageSize: pageSize, success: success, failure: failure)
        }
//
//    }
}

