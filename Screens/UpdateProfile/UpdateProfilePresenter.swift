//
//  UpdateProfilePresenter.swift
//  Ex1
//
//  Created by Trương Duy Tân on 26/06/2023.
//

import Foundation

protocol UpdateProfilePresenter{
    func getProfile()
    func updateProfile(gender: String?, avatar: String?, bio: String?)
    func updateAvatar(avatar data: Data)
}

class updateProfilePresenterImlp: UpdateProfilePresenter{
    var userReppsitory: UserRepository
    var profileDisplay: UserProfileDisplay
    
    init(userReppsitory: UserRepository, profileDisplay: UserProfileDisplay) {
        self.userReppsitory = userReppsitory
        self.profileDisplay = profileDisplay
    }
    
    //lấy thông tin người dùng từ UserRepository và cập nhật lên UserProfileDisplay
    func getProfile() {
        profileDisplay.showLoading(isShow: true)
        userReppsitory.profile{ [weak self] user in
            guard let self = self else {return}
            self.profileDisplay.showLoading(isShow: false)
            self.profileDisplay.displayProfile(user: user)
        } failure: { [weak self] apiError in
            guard let self = self else {return}
            self.profileDisplay.showLoading(isShow: false)
            self.profileDisplay.getProfileFailure(errorMsg: apiError?.errorMsg ?? "Something went wrong")
        }
    }
    
    func updateProfile(gender: String?, avatar: String?, bio: String?) {
        profileDisplay.showLoading(isShow: true)
        userReppsitory.updateProfile(gender: gender, bio: bio, avatar: avatar, success: { [weak self] response in
            guard let self = self else{return}
            profileDisplay.showLoading(isShow: false)
            if let user = response.data{
                self.profileDisplay.updateProfileSuccess(user: user)
            }
        }, failure: {[weak self] apiError in
            guard let self = self else {return}
            self.profileDisplay.showLoading(isShow: false)
            self.profileDisplay.getProfileFailure(errorMsg: apiError?.errorMsg ?? "Something went wrong")
        })
    }
    
    func updateAvatar(avatar data: Data) {
        profileDisplay.showLoading(isShow: true)
        userReppsitory.updateAvatar(avatar: data) { [weak self] response in
            guard let self = self else {return}
            self.profileDisplay.showLoading(isShow: false)
            if let user = response.data{
                self.profileDisplay.updateAvatarSuccess(user: user)
            }
        } failure: {[weak self] apiError in
            guard let self = self else {return}
            self.profileDisplay.showLoading(isShow: false)
            self.profileDisplay.getProfileFailure(errorMsg: apiError?.errorMsg ?? "Something went wrong")
        }
    }
    
    
}
