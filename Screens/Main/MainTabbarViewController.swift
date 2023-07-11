//
//  MainTabbarViewController.swift
//  Ex1
//
//  Created by Trương Duy Tân on 12/06/2023.
//

import UIKit
import ESTabBarController_swift


class MainTabbarViewController: ESTabBarController {

    
    lazy var homeVC: UIViewController = {
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PinPostVC")
            viewController.view.backgroundColor = .green
            viewController.tabBarItem = ESTabBarItem(
                CustomStyleTabBarContentView(),
                title: "Pin".uppercased(),
                image: UIImage(named: "pin"),
                selectedImage: UIImage(named: "pin"))
            let nav = AppNavigationController(rootViewController: viewController)
            return nav
        }()
            

    lazy var home1VC: UIViewController = {
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController")
            viewController.view.backgroundColor = .gray
            viewController.tabBarItem = ESTabBarItem(
                CustomStyleTabBarContentView(),
                title: "Home".uppercased(),
                image: UIImage(named: "home"),
                selectedImage: UIImage(named: "home"))
            let nav = AppNavigationController(rootViewController: viewController)
            return nav
        }()
    
    lazy var home2VC: UIViewController = {
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainVC")
            viewController.tabBarItem = ESTabBarItem(
                CustomStyleTabBarContentView(),
                title: "Profile".uppercased(),
                image: UIImage(named: "profile-user"),
                selectedImage: UIImage(named: "profile-user"))
            let nav = AppNavigationController(rootViewController: viewController)
            return nav
        }()
    
    lazy var home3VC: UIViewController = {
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FavoriteVC")
            viewController.view.backgroundColor = .red
            viewController.tabBarItem = ESTabBarItem(
                CustomStyleTabBarContentView(),
                title: "Favorite".uppercased(),
                image: UIImage(named: "heart"),
                selectedImage: UIImage(named: "heart"))
            let nav = AppNavigationController(rootViewController: viewController)
            return nav
        }()
    
    lazy var home4VC: UIViewController = {
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailCommentViewController")
            viewController.view.backgroundColor = .red
            viewController.tabBarItem = ESTabBarItem(
                CustomStyleTabBarContentView(),
                title: "Comment".uppercased(),
                image: UIImage(named: "edit"),
                selectedImage: UIImage(named: "edit"))
            let nav = AppNavigationController(rootViewController: viewController)
            return nav
        }()
    
    override func loadView() {
        super.loadView()
        loadTabBarView()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().tintColor = .clear
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selectedIndex = 0
    }

    private func loadTabBarView() {
        setViewControllers([home1VC, homeVC,home2VC,home3VC, home4VC ], animated: true)
    }
}
