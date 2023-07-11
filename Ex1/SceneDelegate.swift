//
//  SceneDelegate.swift
//  Ex1
//
//  Created by Trương Duy Tân on 02/06/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      

        guard let windowScene = (scene as? UIWindowScene) else { return }

        // khởi tạo window từ window Scene

        window = UIWindow(windowScene: windowScene)

        //gán instance  window và viến window trong appdelegate
        (UIApplication.shared.delegate as? AppDelegate)?.window = window

        let isCompletTutorial = UserDefaultService.shared.conpletedTutorial
        if isCompletTutorial{
            let isLogin:Bool = AuthService.share.isLoggedIn == true
            if isLogin{
                routeToMainController()
            }else{
                routeToLogin()
            }
        }else{
            routeToTutorial()
        }
    }


    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (
            UIApplication.shared.delegate as? AppDelegate
        )?.saveContext()
    }
}

extension SceneDelegate {
    private func routeToTutorial(){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tutorialVC = storyboard.instantiateViewController(withIdentifier: "TutorialViewController")
        guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else{return}
            window.rootViewController = tutorialVC
            window.makeKeyAndVisible()
    
        }
    
    
        private func routeToLogin(){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC")
            let nav = UINavigationController(rootViewController: loginVC)
            nav.setNavigationBarHidden(true, animated: true)
            guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else{return}
            window.rootViewController = nav
            window.makeKeyAndVisible()
    
        }
        
    
        private func routeToMainController(){
            let mainViewController: UIViewController
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let MainVC = storyboard.instantiateViewController(withIdentifier: "MainTabbarViewController")
            guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else{
                return
            }
            window.rootViewController = MainVC
            window.makeKeyAndVisible()

        }
}
