//
//  RegisterViewController.swift
//  Ex1
//
//  Created by Trương Duy Tân on 11/06/2023.
//

import UIKit
import MBProgressHUD

protocol RegisterDisplay{
    func registerSuccess()
    func registerValidateFailure(field: RegisterFormFeild, message: String?)
    func registerFailure(errorMsg: String?)
    func showLoading(isShow: Bool)
}

enum RegisterFormFeild{
    case username
    case nickname
    case password
}
class RegisterViewController: UIViewController {
    var presenter:RegisterPresent!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var nicknameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var nicknameMsg: UILabel!
    @IBOutlet weak var passwordMsg: UILabel!
    @IBOutlet weak var registerbtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var emailMsg: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let service = AuthAPIServiceImpl()
        let authRepo = AuthRepositoryImpl(authAPIService: service)
        presenter = RegisterPresentImpl(
            registerVC: self,
            authResponsitory: authRepo)
        
            super.viewDidLoad()
            setupView()
       
    }
    
    private func setupView(){
        nicknameMsg.isHidden = true
        passwordMsg.isHidden = true
        emailMsg.isHidden = true
        passwordTF.isSecureTextEntry = true
    }
    
    @IBAction func handleTFChange(_ sender: UITextField){
        emailMsg.isHidden = true
        nicknameMsg.isHidden = true
        passwordMsg.isHidden = true
    }
    
    @IBAction func handleLogin(_ sender: Any) {
       navigationController?.popViewController(animated: true)
    }
    
    @IBAction func handleRegister(_ sender: Any) {
        let nickname = nicknameTF.text ?? ""
        let username = emailTF.text ?? ""
        let password = passwordTF.text ?? ""
        presenter.register(nickname: nickname, username: username, password: password)
    }
    
    private func routeToLogin(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(identifier: "LoginVC")
        let keyWindow = UIApplication.shared.connectedScenes
                                .filter({$0.activationState == .foregroundActive})
                                .compactMap({$0 as? UIWindowScene})
                                .first?.windows
                                .filter({$0.isKeyWindow}).first
        
        keyWindow?.rootViewController = loginVC
        keyWindow?.makeKeyAndVisible()
    }
}


extension RegisterViewController: RegisterDisplay{
    func registerSuccess() {
        showLoading(isShow: false)
        routeToLogin()
    }
    
    func registerValidateFailure(field: RegisterFormFeild, message: String?) {
        switch field{
        
        case .nickname:
            nicknameMsg.text = message
            nicknameMsg.isHidden = false
        case .username:
            emailMsg.text = message
            emailMsg.isHidden = false
        case .password:
            passwordMsg.text = message
            passwordMsg.isHidden = false
        }
    }
    
    func registerFailure(errorMsg: String?) {
        let alert = UIAlertController(title: "Register failure", message: errorMsg ?? "Something went wrong", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func showLoading(isShow: Bool) {
        if isShow{
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        else{
            MBProgressHUD.showAdded(to: self.view, animated: false)
        }
    }
    
    
    
}
