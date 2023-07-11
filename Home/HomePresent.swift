//
//  HomePresent.swift
//  Ex1
//
//  Created by Trương Duy Tân on 16/06/2023.
//

import Foundation

protocol HomePresenter {
    func getInitData()
    func getPosts()
    func getPinPost()
    func loadmorePosts()
    func refreshPosts()
    func favorite(postId: String)
    func unfavorite(postId: String)
    func pined(postId: String)
    func unPin(postId: String)
}

class HomePresenterImpl: HomePresenter {
    
    private var postRepository: PostRespository
    private var postFavoriteRepo: FavoritePostRepository
    private var homeVC: HomeDisplay
    private var pinRepo: PinPostRepository
    
    init(postRepository: PostRespository, postFavoriteRepo: FavoritePostRepository, homeVC: HomeDisplay, pinRepo: PinPostRepository) {
        self.postRepository = postRepository
        self.postFavoriteRepo = postFavoriteRepo
        self.homeVC = homeVC
        self.pinRepo = pinRepo
    }
    
    var currentPage = 1
    var isCanLoadmore = false
    
    /// Sử dụng DispatchGroup trong GCD
    private var apiGroup = DispatchGroup()
    
    ///
    let concurrentQueue = DispatchQueue(
        label: "techmaster.queue.concurrent",
        attributes: .concurrent)
    
    
    //    private var favoritePosts = [String]()
    //    private var pinPosts = [String]()
    func getInitData() {
        homeVC.showLoading(isShow: true)
        
        getPosts()
        getFavoritePost()
        getPinPost()
        
        
        
        apiGroup.notify(queue: .main) {
            
            /**
             Sau 2s kể từ lúc cả 2 API getPosts, getFavoritePost hoàn thành thì thực hiện tắt loading và reload lại tableView
             */
            
            /// 2 API chạy xong
            /// asyncAfter chạy code sau N seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.homeVC.showLoading(isShow: false)
                
                /**
                 Thực hiện đẩy xử lý code self.homeVC.reloadTableView() vào techmaster.queue.concurrent concurrent queue
                 */
                self.concurrentQueue.async {
                    /**
                     Xảy ra lỗi vì đang xử lý reload tableview ở một thread khác Main Thread
                     
                     Đặt debug để xem code đang chạy ở thread nào
                     
                     // Lỗi
                     Main Thread Checker: UI API called on a background thread: -[UITableView reloadData]
                     PID: 17784, TID: 197303, Thread name: (none), Queue name: techmaster.queue.concurrent, QoS: 0
                     */
                    
                    
                    
                    /// Fix bằng cách đẩy xử lý UI lên main thread
                    DispatchQueue.main.async {
                        // Đặt debug để xem code đang chạy ở thread nào
                        self.homeVC.reloadTableView()
                        
                    }
                    
                }
            }
        }
    }
    //lấy danh sách các bài viết từ API, sau khi kết quả trả về sẽ cập nhật trên homeVC
    func getPosts() {
//        _getPosts(page: currentPage, apiType: .getInit)
                apiGroup.enter()
                postRepository.index(page: currentPage, pageSize: 20) { [weak self] response in // gửi yêu cầu đến api để lấy danh sách bài viết
                    guard let self = self else { return }

                    /// Ví dụ về việc đẩy code về global queue
                    DispatchQueue.global().async {

                        self.homeVC.getPost(posts: response.results) // cập nhật danh sách api trả về
                        self.apiGroup.leave()
                    }

                } failure: { [weak self] apiError in
                    guard let self = self else { return }
                    self.apiGroup.leave()
                }
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
    
    
    
    
    private func _getPosts(page: Int, pageSize: Int = 20, apiType: APIType) {
        switch apiType {
        case .getInit: // lấy dữ liệu lần đầu
            homeVC.showLoading(isShow: true) // hiển thị showloading
        default:
            break
        }
        // gọi phương thức index trong postRepository để gửi yêu cầu api và lấy danh sách bài viết
        postRepository.index(page: page, pageSize: pageSize) { [weak self] response in
            guard let self = self else { return }
            switch apiType {
            case .getInit:
                self.homeVC.showLoading(isShow: false)
                self.homeVC.getPost(posts: response.results) //ẩn loading và cập nhật bài viết
            case .refresh:
                self.homeVC.hideRefreshLoading()
                self.homeVC.getPost(posts: response.results) // làm mới danh sách bài viết
            case .loadmore:
                self.homeVC.displayLoadmorePosts(posts: response.results) // hiển thị danh sách bài viết tải thêm
            }
            self.isCanLoadmore = response.isCanLoadmore
            
        } failure: { [weak self] apiError in
            guard let self = self else { return }
            
            switch apiType {
            case .getInit:
                self.homeVC.showLoading(isShow: false)
                self.homeVC.getPost(posts: []) // hiển thị danh sách bài viết trống
            case .refresh:
                self.homeVC.hideRefreshLoading()
            default:
                break
            }
            self.homeVC.displayAPIFailure(errorMsg: apiError?.errorMsg ?? "Something went wrong") // Hiển thị lỗi
        }
    }
    
    /**
     Đây chỉ là ví dụ DEMO về cách call GCD, nếu áp dụng vào bài toán thực tế vẫn còn hạn chế.
     Cần sự can thiệp của API để logic và hiệu suất ứng dụng được nâng cao
     */
    func getPinPost() {
        apiGroup.enter()
        pinRepo.getPosts(page: 1, pageSize: 100) { [weak self] response in
            guard let self = self else {return}
            let postIds = response.results.compactMap({ $0.id})
            self.homeVC.getPinSuccess(postIds: postIds)
            self.apiGroup.leave()
        }failure: {[weak self] apiError in
            guard let self = self else { return }
            self.homeVC.displayAPIFailure(errorMsg: apiError?.errorMsg ?? "Something went wrong")
            /// Báo cho dispatch group rằng có 1 task  này đã xử lý xong
            self.apiGroup.leave()
        }
    }
    private func getFavoritePost() {
        /// Báo cho dispatch group rằng có 1 task vào queue để xử lý
        apiGroup.enter()
        postFavoriteRepo.index(page: 1, pageSize: 100) { [weak self] response in
            guard let self = self else { return }
            /**
             Nếu API call succes -> Danh sách (mảng) các bài post đã favorite
             */
            
            /// Lấy ra mảng post id đã favorite
            let postIds = response.results.compactMap({ $0.id })
            
            /// Truyền sang viewcontroller. Truyền sang để lưu ở viewcontroller để xử lý UI
            self.homeVC.getFavoriteSuccess(postIds: postIds)
            
            /// Báo cho dispatch group rằng có 1 task  này đã xử lý xong
            self.apiGroup.leave()
        } failure: { [weak self] apiError in
            guard let self = self else { return }
            self.homeVC.displayAPIFailure(errorMsg: apiError?.errorMsg ?? "Something went wrong") // Hiển thị lỗi
            /// Báo cho dispatch group rằng có 1 task  này đã xử lý xong
            self.apiGroup.leave()
        }
    }
    
    func pined(postId: String) {
        pinRepo.pinPost(postID: postId, success: { [weak self] response in
            guard let self = self else { return }
            if let post = response.data, let postId = post.postID {
                self.homeVC.pined(postId: postId)
            }
        }) { [weak self] apiError in
            guard let self = self else { return }
            self.homeVC.displayAPIFailure(errorMsg: apiError?.errorMsg ?? "Something went wrong")
        }
    }
    
    func unPin(postId: String) {
        pinRepo.unPin(postID: postId, success: { [weak self] response in
            guard let self = self else { return }
            if let post = response.data, let postId = post.postID {
                self.homeVC.getUnPinSuccess(postIds: postId)
            }
        }) { [weak self] apiError in
            guard let self = self else { return }
            self.homeVC.displayAPIFailure(errorMsg: apiError?.errorMsg ?? "Something went wrong")
        }
    }
    /// Call API favorite
    func favorite(postId: String) {
        postFavoriteRepo.favorite(postId: postId) { [weak self] response in
            guard let self = self else { return }
            
            /// Call success mình sẽ được 1 object data trong đó có postId
            if let post = response.data, let postId = post.postID {
                
                /// Truyển sang viewcontroller để add nó vào mạng favorite ids và thực hiện reload lại tableview để tableview vẽ lại UI.
                self.homeVC.favorited(postId: postId)
            }
        } failure: { [weak self] apiError in
            guard let self = self else { return }
            self.homeVC.displayAPIFailure(errorMsg: apiError?.errorMsg ?? "Something went wrong") // Hiển thị lỗi
        }
    }
    func unfavorite(postId: String) {
        postFavoriteRepo.unfavorite(postId: postId) { [weak self] response in
            guard let self = self else { return }
            if let post = response.data, let postId = post.postID {
                //                self.favoritePosts.append(postId)
                self.homeVC.getUnFavoriteSuccess(postIds: postId)
            }
        } failure: { [weak self] apiError in
            guard let self = self else { return }
            self.homeVC.displayAPIFailure(errorMsg: apiError?.errorMsg ?? "Something went wrong") // Hiển thị lỗi
        }
    }
}
