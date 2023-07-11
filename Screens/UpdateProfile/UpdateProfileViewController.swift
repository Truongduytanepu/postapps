//
//  UploadProfileViewController.swift
//  Ex1
//
//  Created by Trương Duy Tân on 26/06/2023.
//

import UIKit
import MBProgressHUD
import AlamofireImage
import Alamofire

protocol UserProfileDisplay{
    func displayProfile(user: UserEntity)
    func showLoading(isShow: Bool)
    func getProfileFailure(errorMsg: String?)
    func updateProfileSuccess(user: UserEntity)
    func updateAvatarSuccess(user: UserEntity)
}

class UpdateProfileViewController: UIViewController {

    @IBOutlet weak var updataBtn: UIButton!
    @IBOutlet weak var bioTView: UITextView!
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var nickNameTF: UITextField!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var avatarImg: UIImageView!
    private var avatarStringURL: String?
    
    private var userGender: Gender?{
        didSet{
            maleBtn.isSelected = self.userGender == .male
            femaleBtn.isSelected = self.userGender == .female
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        avatarImg.layer.cornerRadius = avatarImg.frame.height/2
        editBtn.layer.cornerRadius = editBtn.frame.height/2
        
    }
    
}

extension UpdateProfileViewController: UserProfileDisplay{
    
    func displayProfile(user: UserEntity) {
        
        nickNameTF.text = user.username
        bioTView.text = user.profile?.bio
        userGender = user.profile?.genderEnum
        avatarStringURL = user.profile?.avatar
        
        if let avatarImg = user.profile?.avatar {
            AF.download(avatarImg).responseData { [weak self] response in
                guard let self = self else { return }
                if let data = response.value {
                    let image = UIImage(data: data)
                    self.avatarImg.image = image
                }
            }
        } else {
            /// Set avatar is image default
            avatarImg.image = UIImage(named: "heart")
        }
    }
    
    func showLoading(isShow: Bool) {
        if isShow{
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }else{
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func getProfileFailure(errorMsg: String?) {
        let alert = UIAlertController(title: "Get Profile Failure", message: errorMsg ?? "Something went wrong", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    
    func updateProfileSuccess(user: UserEntity) {
        let alert = UIAlertController(title: "Success", message: "Change Profile Successly", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    
    func updateAvatarSuccess(user: UserEntity) {
        
    }
    
    
}
