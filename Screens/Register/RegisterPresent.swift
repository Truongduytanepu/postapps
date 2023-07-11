//
//  RegisterPresent.swift
//  Ex1
//
//  Created by Trương Duy Tân on 12/06/2023.
//

import Foundation


protocol RegisterPresent{
    func register(nickname: String, username: String, password:String)
}



class RegisterPresentImpl: RegisterPresent{
    var registerVC: RegisterDisplay
    var authResponsitory: AuthRepository!
    init(registerVC: RegisterDisplay, authResponsitory: AuthRepository) {
        self.registerVC = registerVC
        self.authResponsitory = authResponsitory
    }
    
    
    private func validateForm(nickname: String, username:String, password:String) -> Bool{
        var isValid = true
        if nickname.isEmpty{
            registerVC.registerValidateFailure(field: .nickname, message: "Username is required")
        }
        else{
            if nickname.count < 4 || username.count > 40{
                registerVC.registerValidateFailure(field: .nickname, message: "Username has count > 4 and <40")
                isValid = false
            }
            if nickname.contains(" "){
                registerVC.registerValidateFailure(field: .nickname, message: "Username doesn't have space")
                isValid = false
            }
            if nickname.contains("\t"){
                registerVC.registerValidateFailure(field: .nickname, message: "Username doesn't have tab")
                isValid = false
            }
        }
        if username.isEmpty{
            registerVC.registerValidateFailure(field: .username, message: "Email is required")
        }
        else{
            if username.count < 4 || username.count > 40{
                registerVC.registerValidateFailure(field: .username, message: "Email has count > 4 and <40")
                isValid = false
            }
            if username.contains(" "){
                registerVC.registerValidateFailure(field: .username, message: "Email doesn't have space")
                isValid = false
            }
            if username.contains("\t"){
                registerVC.registerValidateFailure(field: .username, message: "Email doesn't have tab")
                isValid = false
            }
        }
        if password.isEmpty{
            registerVC.registerValidateFailure(field:.password , message: "Password is required")
        }
        else{
            if password.count < 4 || password.count > 40{
                registerVC.registerValidateFailure(field: .password, message: "Password has count > 4 and <40")
                isValid = false
            }
            if password.contains(" "){
                registerVC.registerValidateFailure(field: .password, message: "Pasword doesn't have space")
                isValid = false
            }
            if password.contains("\t"){
                registerVC.registerValidateFailure(field: .password, message: "Password doesn't have tab")
                isValid = false
            }
        }
        return isValid
    }
    func register(nickname: String, username: String, password: String) {
        let isValid = validateForm(nickname: nickname, username: username, password: password)
        
        guard isValid else {
            return
        }
        
        registerVC.showLoading(isShow: true)
        authResponsitory.register(username: username, nickname: nickname, password: password, confirmPassword: password) { [weak self] loginEntity in
            guard let self = self else { return }

            self.registerVC.showLoading(isShow: false)
            
            if let accessToken = loginEntity.accessToken, !accessToken.isEmpty {
                AuthService.share.accessToken = accessToken
                self.registerVC.registerSuccess()
            } else {
                self.registerVC.registerFailure(errorMsg: "Something went wrong")
            }
        } failure: { [weak self] apiError in
            guard let self = self else { return }

            self.registerVC.showLoading(isShow: false)
            self.registerVC.registerFailure(errorMsg: apiError?.errorMsg ?? "Something went wrong")
        }
    }
        }
