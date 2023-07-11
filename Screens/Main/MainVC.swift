//
//  MainViewController.swift
//  Ex1
//
//  Created by Trương Duy Tân on 12/06/2023.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var avatar: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    
    func setupVC(){
        avatar.layer.cornerRadius = avatar.frame.height/2
    }
    @IBAction func EditProfile(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "UpdateProfileViewController") as! UpdateProfileViewController
        navigationController?.pushViewController(viewController, animated: true)
        navigationController?.isNavigationBarHidden = false
    
        
    }
    @IBAction func handleLogout(_ sender: Any) {
        AuthService.share.clearAll()
        UserDefaultService.shared.clearAll()
        routToNavigation()
    }
    
    private func routToNavigation(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC")
        let nav = UINavigationController(rootViewController: loginVC)
        nav.setNavigationBarHidden(true, animated: true)
        (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController = nav
        (UIApplication.shared.delegate as? AppDelegate)?.window?.makeKeyAndVisible()
    }
   

}
