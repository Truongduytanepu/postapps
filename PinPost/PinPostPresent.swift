//
//  PinPostPresenter.swift
//  PostsApp
//
//  Created by Hà Văn Đức on 25/05/2023.
//

import Foundation

protocol PinPostPresenter {
    func getInitData()
    func getPosts()
    func loadMorePosts()
    func refreshPosts()
    func favourite(postID: String)
    func unFavourite(postID: String)
    func pin(postID: String)
    func unPin(postID: String)
}

class PinPostPresenterImpl: PinPostPresenter {
    
    private var pinRepository: PinPostRepository
    private var pinPostVC: PinPostViewController
    private var favouriteRepository: FavoritePostRepository
    
   
    init(pinRepository: PinPostRepository, pinPostVC: PinPostViewController, favouriteRepository: FavoritePostRepository) {
        self.pinRepository = pinRepository
        self.pinPostVC = pinPostVC
        self.favouriteRepository = favouriteRepository
    }
    
    var currentPage = 1
    var loadMoreAvailable = false
    private var apiGroup = DispatchGroup()
    let concurentQueue = DispatchQueue(label: "techmaster.queue.concurrent", attributes: .concurrent)
    
    func getInitData() {
        pinPostVC.showLoading(isShow: true)
        
        getPosts()
        getFavouritePosts()
        getPinPosts()
        
        apiGroup.notify(queue: .main) {
            DispatchQueue.main.async {
                self.pinPostVC.showLoading(isShow: false)
                self.concurentQueue.async {
                    DispatchQueue.main.async {
                        self.pinPostVC.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func getPosts() {
        _getPost(page: currentPage, apiType: .getInit)
    }
    
    func loadMorePosts() {
        guard loadMoreAvailable else {return}
        loadMoreAvailable = false
        currentPage += 1
        _getPost(page: currentPage, apiType: .loadmore)
    }
    
    func refreshPosts() {
        currentPage = 1
        _getPost(page: currentPage, apiType: .refresh)
        getFavouritePosts()
        
    }
    
    private func _getPost(page: Int, pageSize: Int = 100, apiType: APIType) {
        switch apiType {
        case .getInit:
            pinPostVC.showLoading(isShow: true)
        default:
            break
        }
        pinRepository.getPosts(page: page, pageSize: pageSize) { [weak self] response in
            guard let self = self else {return}
            
            switch apiType {
            case .getInit:
                self.pinPostVC.showLoading(isShow: false)
                self.pinPostVC.getPosts(posts: response.results)
            case .loadmore:
                self.pinPostVC.loadmorePosts(posts: response.results)
            case .refresh:
                self.pinPostVC.hideRefreshLoading()
                self.pinPostVC.getPosts(posts: response.results)
            }
            self.loadMoreAvailable = response.isCanLoadmore
            
        } failure: { [weak self] apiError in
            guard let self = self else {return}
            switch apiType {
            case .getInit:
                self.pinPostVC.showLoading(isShow: false)
                self.pinPostVC.getPosts(posts: [])
            case .refresh:
                self.pinPostVC.hideRefreshLoading()
            case .loadmore:
                self.pinPostVC.loadmorePosts(posts: [])
            }
            self.pinPostVC.callAPIFailure(errorMsg: apiError?.errorMsg ?? "Something went wrong")
        }
    }
    
    private func getFavouritePosts() {
        apiGroup.enter()
        favouriteRepository.index(page: 1, pageSize: 100) { [weak self] response in
            guard let self = self else {return}
            let postIDs = response.results.compactMap({$0.id})
            self.pinPostVC.getFavouritePostSuccess(postIDs: postIDs)
            self.apiGroup.leave()
        } failure: { [weak self] apiError in
            guard let self = self else {return}
            self.apiGroup.leave()
            self.pinPostVC.callAPIFailure(errorMsg: apiError?.errorMsg ?? "Something went wrong")
        }
    }
    
    private func getPinPosts() {
        apiGroup.enter()
        pinRepository.getPosts(page: 1, pageSize: 100) { [weak self] response in
            guard let self = self else {return}
            let postIDs = response.results.compactMap({$0.id})
            self.pinPostVC.getPinPostSuccess(postIDs: postIDs)
            self.apiGroup.leave()
        } failure: { [weak self] apiError in
            guard let self = self else {return}
            self.apiGroup.leave()
            self.pinPostVC.callAPIFailure(errorMsg: apiError?.errorMsg ?? "Something went wrong")
        }
    }
    
    //Call API Favourite
    func favourite(postID: String) {
        favouriteRepository.favorite(postId: postID) { [weak self] response in
            guard let self = self else {return}
            if let post = response.data, let postID = post.postID {
                self.pinPostVC.favouritePost(postID: postID)
            }
        } failure: { [weak self] apiError in
            guard let self = self else {return}
            self.pinPostVC.callAPIFailure(errorMsg: apiError?.errorMsg ?? "Something went wrong")
        }
    }
    
    func unFavourite(postID: String) {
        favouriteRepository.unfavorite(postId: postID) { [weak self] response in
            guard let self = self else {return}
            if let post = response.data, let postID = post.postID {
                self.pinPostVC.unFavouritePostSuccess(postID: postID)
            }
        } failure: { [weak self] apiError in
            guard let self = self else {return}
            self.pinPostVC.callAPIFailure(errorMsg: apiError?.errorMsg ?? "Something went wrong")
        }
    }
    //Call API Pin
    func pin(postID: String) {
        pinRepository.pinPost(postID: postID) { [weak self] response in
            guard let self = self else {return}
            if let post = response.data, let postID = post.postID {
                self.pinPostVC.pinPost(postID: postID)
            }
        } failure: { [weak self] apiError in
            guard let self = self else {return}
            self.pinPostVC.callAPIFailure(errorMsg: apiError?.errorMsg ?? "Something went wrong")
        }
    }
    
    func unPin(postID: String) {
        pinRepository.unPin(postID: postID) { [weak self] response in
            guard let self = self else {return}
            if let post = response.data, let postID = post.postID {
                self.pinPostVC.unPinPostSuccess(postID: postID)
            }
        } failure: { [weak self] apiError in
            guard let self = self else {return}
            self.pinPostVC.callAPIFailure(errorMsg: apiError?.errorMsg ?? "Something went wrong")
        }
    }
    
}
