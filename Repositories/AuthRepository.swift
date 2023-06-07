////
////  AuthRepository.swift
////  Ex1
////
////  Created by Trương Duy Tân on 05/06/2023.
////
//
//import Foundation
//import Alamofire
//protocol AuthAPISerivce{
//    func login(ussername: String,
//               password:String,
//               success:((LoginEntity) -> Void)?,
//               failure: ((String) ->Void)?)
//}
//class AuthAPISerivceImpl: AuthAPISerivce{
//    func login(ussername: String,
//               password:String,
//               success:((LoginEntity) -> Void)?,
//               failure: ((String) ->Void)?) {
//        AF.request("https://learn-api-3t7z.onrender.com/login",
//                   method: .post,
//                   parameters: ["ussername": ussername,
//                                "password": password],
//                   encoder: JSONParameterEncoder.default)
//                    .validate(statusCode: 200..<300)
//                   .responseDecodable(of: LoginEntity.self) { response in
//                       switch response.result{
//                       case .success(let entity):
//                            success?(entity)
//                     case .failure(let entity):
//                        failure?(error?.failureReason)
//                       }
//                    }
//
//  }
//}
//
//protocol AuthRespository{
//    func login(ussername: String,
//               password:String,
//               success:((LoginEntity) -> Void)?,
//               failure: ((String) ->Void)?)
//}
//
//                   class AuthRespositoryImpl: AuthRespository{
//            var authApiService: AuthAPISerivce
//
//            init(authApiService: AuthAPISerivce) {
//                self.authApiService = authApiService
//            }
//
//            func login(ussername: String,
//                       password:String,
//                       success:((LoginEntity) -> Void)?,
//                       failure: ((String) ->Void)?){
//                //        authApiService.
//            }
//        }
//
