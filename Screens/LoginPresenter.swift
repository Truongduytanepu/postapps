//
//  LoginPresenter.swift
//  Ex1
//
//  Created by Trương Duy Tân on 05/06/2023.
//

import Foundation


//protocol LoginPresenter{
//    func login(username:String,password:String)
//}
//
//class LoginPresenterImpl : LoginPresenter{
//    var controller : LoginDisplay
//    var authResonsitory: AuthRespository!
//    init(controller: LoginDisplay) {
//        self.controller = controller
//        self.authResonsitory = authResonsitory
//    }
//    
//    //    func validateForm() ->Bool{
//    //
//    //        return false
//    //    }
//    
//    
//    func login(username: String,password : String)
//    {
//        if(username.isEmpty){
//            controller.validateFailure(messing: "User is required")
//        }else{
//            authResonsitory.login(ussername: username, password: password) { response in
//                //tắt loading
//                //kiểm tra xem trong respone
//            } failure: { errorMsg in
//                <#code#>
//            }
//
//        }
//    }
//    
//}
