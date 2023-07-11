//
//  Connnectivity.swift
//  Ex1
//
//  Created by Trương Duy Tân on 09/06/2023.
//

import Foundation
import Alamofire


// kiểm tra kết nối internet
struct Connectivity{
    static let sharedInstance = NetworkReachabilityManager()!
    
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
      }
    
}
