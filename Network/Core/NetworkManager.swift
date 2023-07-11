//
//  NetworkManager.swift
//  Ex1
//
//  Created by Trương Duy Tân on 23/06/2023.
//

import Foundation
import Alamofire

class NetworkManager{
    static var shared = NetworkManager()
    private let session: Session!
    private init() {
//        self.session = Session()
        session = Session(interceptor: AuthenticateHandler())
        session.sessionConfiguration.timeoutIntervalForRequest = 60
    }
    
    func callAPI<T: Decodable>(router: URLRequestConvertible,
                               success: ((T)-> Void)?,
                               failure: ((APIError)-> Void)?){
        session.request(router).cURLDescription { description in
            print(description)
        }
        .validate(statusCode: 200..<300)
        .responseDecodable(of: T.self){ response in
            switch response.result {
            case .success(let entity):
                success?(entity)
            case .failure(let afError):
                if let data = response.data{
                    if let responseString = String(data: data, encoding: .utf8){
                        failure?(APIError(errorMsg: responseString, errorKey: nil))
                    }else{
                        do{
                            if let httpStatusCode = response.response?.statusCode{
                                
                            }
                            // Chuyển dât có kiểu dữ liệu là data sang dictionary (Json)
                            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                            
                            if let json = jsonObject as? [String: Any]{
                                let message = json["message"] as? String?
                                failure?(APIError(errorMsg: message ?? "Something went wrong", errorKey: nil))
                            }
                        }catch{
                            print("erorMsg")
                        }
                    }
                }
            }
        }
    }
    
}

