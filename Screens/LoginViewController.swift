//import UIKit
//
//protocol LoginDisplay{
//    func validateFailure(messing: String)
//}
//
//class LoginViewController: UIViewController {
//
//    var presenter: LoginPresenter!
//    
//    override func viewDidLoad() {
//        
//        // khởi tạo instance của authAPIService
//        let authAPIService = AuthAPISerivceImpl()
//        
//        
//        // khởi tạo instance của AuthResponsitory
//        let authReponsitory = AuthRespositoryImpl(authApiService: authAPIService)
//        
//        // khởi tạo instance của LoginPresenter
//        
//        presenter = LoginPresenterImpl(controller: self)
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
//
//extension LoginViewController : LoginDisplay{
//    func validateFailure(messing: String) {
//        print("")
//    }
//}
