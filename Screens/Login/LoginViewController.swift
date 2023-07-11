import UIKit
import MBProgressHUD

protocol LoginDisplay{
    func loginSuccess()
    func loginValidateFailure(field: LoginFormField, message: String?)
    func loginFailure(errorMsg: String?)
    func showLoading(isShow: Bool)
}

enum LoginFormField{
    case username
    case password
}

class LoginViewController: UIViewController {

    var presenter: LoginPresenter!

    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var forgotPassword: UIButton!
    @IBOutlet weak var passwordMsg: UILabel!
    @IBOutlet weak var userMsg: UILabel!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUser: UITextField!
    override func viewDidLoad() {

        // khởi tạo instance của authAPIService
        let authApiService = AuthAPIServiceImpl()
        


        // khởi tạo instance của AuthResponsitory
        
        let authRepo = AuthRepositoryImpl(authAPIService: authApiService)

        // khởi tạo instance của LoginPresenter

        presenter = LoginPresenterImpl(loginVC: self, authResonsitory: authRepo)
        super.viewDidLoad()
        setupView()
        
        
    }

    @IBAction func handleUsername(_ sender: UITextField) {
        print(sender.text ?? "")
        userMsg.isHidden = true
    }
    
    @IBAction func handlePassword(_ sender: UITextField) {
        print(sender.text ?? "")
        passwordMsg.isHidden = true
    }
    
    @IBAction func handleForgotPassword(_ sender: Any) {
       
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        presenter.login(username: txtUser.text ?? "", password: txtPassword.text ?? "")
    }
    
    @IBAction func btnRegister(_ sender: UIButton) {
        routeToRegister()
        
    }
    
    
    
    private func setupView(){
        userMsg.isHidden = true
        passwordMsg.isHidden = true
        txtPassword.isSecureTextEntry = true
    }
    @IBAction func Login(_ sender: Any) {
        let username = txtUser.text ?? ""
        let password = txtPassword.text ?? ""
        presenter.login(username: username, password: password)
    }
}
extension LoginViewController {
    private func routeToLogin(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC")
        guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else {
            return
        }
        
//        let keyWindow = UIApplication.shared.connectedScenes
//                                .filter({$0.activationState == .foregroundActive})
//                                .compactMap({$0 as? UIWindowScene})
//                                .first?.windows
//                                .filter({$0.isKeyWindow}).first
//
//        keyWindow?.rootViewController = loginVC
//        keyWindow?.makeKeyAndVisible()
    }
    
    
    private func routeToMain(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVC = storyboard.instantiateViewController(withIdentifier: "MainTabbarViewController")
        let keyWindow = UIApplication.shared.connectedScenes
                                        .filter({$0.activationState == .foregroundActive})
                                        .compactMap({$0 as? UIWindowScene})
                                        .first?.windows
                                        .filter({$0.isKeyWindow}).first
        
                keyWindow?.rootViewController = mainVC
                keyWindow?.makeKeyAndVisible()

    }
    
    private func routeToRegister() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RegisterVC")
        navigationController?.pushViewController(vc, animated: true)
    }
}





extension LoginViewController : LoginDisplay{
    func loginSuccess() {
            showLoading(isShow: false)
            routeToMain()
        }
    
    func loginValidateFailure(field: LoginFormField, message: String?) {
        switch field {
        case .username:
            userMsg.isHidden = false
            userMsg.text = message
        case .password:
            passwordMsg.isHidden = false
            passwordMsg.text = message
        }
    }
    
    func loginFailure(errorMsg: String?) {
        let alert = UIAlertController(title: "Login failure", message: errorMsg ?? "Something went wrong", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func showLoading(isShow: Bool) {
        if isShow {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        } else {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}
extension LoginViewController {
    private func submit() {
        let username = txtUser.text ?? ""
        let password = txtPassword.text ?? ""
        presenter.login(username: username, password: password)
    }
}


