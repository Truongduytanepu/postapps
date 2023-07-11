//
//  FavoritePresent.swift
//  Ex1
//
//  Created by Trương Duy Tân on 21/06/2023.
//

import Foundation

protocol FavoritePresenter {
    func getPosts()
    func loadmorePosts()
    func refreshPosts()
}

class FavoritePresenterImpl: FavoritePresenter {
    func getPosts() {
        _getPosts(page: currentPage, apiType: .getInit)
    }
    
    func loadmorePosts() {
        guard isCanLoadmore else {
            return
        }
        isCanLoadmore = false
        currentPage += 1
        _getPosts(page: currentPage, apiType: .loadmore)
    }
    
    func refreshPosts() {
        currentPage = 1
        _getPosts(page: currentPage, apiType: .refresh)
    }
    
    private var repository: FavoritePostRepository
    private var favoriteVC: FavoriteDisplay
    
    init(repository: FavoritePostRepository, favoriteVC: FavoriteDisplay) {
        self.repository = repository
        self.favoriteVC = favoriteVC
    }
    var currentPage = 1
    var isCanLoadmore = false

    private func _getPosts(page: Int, pageSize: Int = 20, apiType: APIType) {
        switch apiType {
        case .getInit:
            favoriteVC.showLoading(isShow: true)
        default:
            break
        }
        repository.index(page: page, pageSize: pageSize) { [weak self] response in
            guard let self = self else { return }
            switch apiType {
            case .getInit:
                self.favoriteVC.showLoading(isShow: false)
                self.favoriteVC.getPosts(posts: response.results)
            case .refresh:
                self.favoriteVC.hideRefreshLoading()
                self.favoriteVC.getPosts(posts: response.results)
            case .loadmore:
                self.favoriteVC.loadmorePosts(posts: response.results)
            }
            self.isCanLoadmore = response.isCanLoadmore
            
        } failure: { [weak self] apiError in
            guard let self = self else { return }

            switch apiType {
            case .getInit:
                self.favoriteVC.showLoading(isShow: false)
                self.favoriteVC.getPosts(posts: [])
            case .refresh:
                self.favoriteVC.hideRefreshLoading()
            default:
                break
            }
            self.favoriteVC.callAPIFailure(errorMsg: apiError?.errorMsg ?? "Something went wrong")
        }
    
}
}

