//
//  LoginPresenter.swift
//  Ex1
//
//  Created by Trương Duy Tân on 05/06/2023.
//

import Foundation


protocol LoginPresenter{
    func login(username:String,password:String)
}

class LoginPresenterImpl : LoginPresenter{
    var loginVC : LoginDisplay
    var authResonsitory: AuthRepository!
    
    init(loginVC: LoginDisplay, authResonsitory: AuthRepository!) {
        self.loginVC = loginVC
        self.authResonsitory = authResonsitory
    }
    
    func validateForm(username: String, password: String) ->Bool{
        var isValid = true
        
        
        if username.isEmpty{
            isValid = false
            loginVC.loginValidateFailure(field: .username, message: "Username is required")
        }else{
            if username.count < 4 || username.count > 40{
                loginVC.loginValidateFailure(field: .username, message: "Username has count > 4 and <40")
                isValid = false
            }
            if username.contains(" "){
                loginVC.loginValidateFailure(field: .username, message: "Username doesn't have space")
                isValid = false
            }
            if username.contains("\t"){
                loginVC.loginValidateFailure(field: .username, message: "Username doesn't have tab")
                isValid = false
            }
        }
        
        if password.isEmpty{
            isValid = false
            loginVC.loginValidateFailure(field: .password, message: "Password is required")
        }
        else{
            if password.count < 4 || username.count > 40{
                loginVC.loginValidateFailure(field: .password, message: "Password has count > 4 and <40")
                isValid = false
            }
            if password.contains(" "){
                loginVC.loginValidateFailure(field: .password, message: "Password doesn't have space")
                isValid = false
            }
            if password.contains("\t"){
                loginVC.loginValidateFailure(field: .password, message: "Password doesn't have tab")
                isValid = false
            }
        }
        return isValid
    }
    
    
    func login(username: String,password : String)
    {
        let isValid = validateForm(username: username, password: password)
        
        guard isValid else {
            ///
            return
        }
        
        loginVC.showLoading(isShow: true)
        authResonsitory.login(username: username, password: password) { [weak self] loginEntity in
            guard let self = self else { return }
            self.loginVC.showLoading(isShow: false)
            
            if let accessToken = loginEntity.accessToken, !accessToken.isEmpty {
                AuthService.share.accessToken = accessToken
                self.loginVC.loginSuccess()
            } else {
                self.loginVC.loginFailure(errorMsg: "Something went wrong")
            }
        } failure: { [weak self] apiError in
            guard let self = self else { return }

            self.loginVC.showLoading(isShow: false)
            self.loginVC.loginFailure(errorMsg: apiError?.errorMsg ?? "Something went wrong")
        }
        
    }
    
}
