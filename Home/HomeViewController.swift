//
//  HomeViewController.swift
//  Ex1
//
//  Created by Trương Duy Tân on 14/06/2023.
//

import UIKit
import Alamofire
import MBProgressHUD

protocol HomeDisplay {
    func getPost(posts: [PostEntity])
    func displayLoadmorePosts(posts: [PostEntity])
    func displayAPIFailure(errorMsg: String?)
    func showLoading(isShow: Bool)
    func hideRefreshLoading()
    func getFavoriteSuccess(postIds: [String])
    func getUnFavoriteSuccess(postIds: String)
    func pined(postId: String)
    func getPinSuccess(postIds: [String])
    func getUnPinSuccess(postIds: String)
    func favorited(postId: String)
    func reloadTableView()
    
}

class HomeViewController: UIViewController {

    private var favoritePosts = [String]()
    private var pinPost = [String]()
    private var posts: [PostEntity]?
    @IBOutlet weak var TableView: UITableView!
    private var cacheImages = [String: UIImage]()
    private var refresher = UIRefreshControl()
    private var presenter: HomePresenter!

    override func viewDidLoad() {
        let service = PostAPIServiceImpl()
        let repo = PostRespositoryImpl(apiService: service)
        let favoritePost = FavoritePostRepositoryImpl(apiService: FavoriteAPIServivceImpl())
        let pinPost = PinPostRepositoryImpl(pinAPIService: PinPostAPIServiceImpl())
        presenter = HomePresenterImpl(postRepository: repo, postFavoriteRepo: favoritePost, homeVC: self, pinRepo: pinPost)
        super.viewDidLoad()
        setupTableView()
        presenter.getInitData()
        presenter.getPosts()
    }

    private func setupTableView() {
        TableView.delegate = self
        TableView.dataSource = self
        TableView.tableFooterView = UIView()
        TableView.separatorStyle = .none
        TableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        TableView.refreshControl = refresher
        refresher.addTarget(self, action: #selector(refreshPosts), for: .valueChanged)
    }

    @objc private func refreshPosts() {
        presenter.refreshPosts()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        let post = posts![indexPath.row]
        if let user = post.author, let avatarImg = user.profile?.avatar {
            if let imgCached = cacheImages[avatarImg] {
                cell.authorAvatar(image: imgCached)
            } else {
                loadImage(link: avatarImg) { image in
                    cell.authorAvatar(image: image)
                }
            }
        } else {
            cell.authorAvatar(image: nil)
        }
        
        /**
         Nếu mà trong mảng favoritePosts (favorites post ids mà lấy ở API get list favorite)
         */
        let isFavorite = self.favoritePosts.contains(where: { $0 == post.id })
        
        /**
         Khi click vào 1 hình trái tim (favorite)
         */
        cell.favoriteHandleCallback = { [weak self] in
            guard let self = self else { return }
            if isFavorite {
                /// Nếu mà đã thích rồi thì unfavorite
                self.presenter.unfavorite(postId: post.id!)
            } else {
                /// Chưa thích thì call API thích bài post
                self.presenter.favorite(postId: post.id!)
            }
        }
        
        let isPin = self.pinPost.contains(where: {$0 == post.id})
        
        cell.pinHandleCallBack = {[weak self] in
            guard let self = self else{return}
            if isPin{
                self.presenter.unPin(postId: post.id!)
            }else{
                self.presenter.pined(postId: post.id!)
            }
                
        }
        cell.bindData(post: post, isFavorite: isFavorite, isPin: isPin )
        return cell
    }

    private func loadImage(link: String, completed: ((UIImage?) -> Void)?) {
        AF.download(link).responseData { [weak self] response in
            guard let self = self else { return }
            if let data = response.value {
                let image = UIImage(data: data)
                self.cacheImages[link] = image
                completed?(image)
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: HomeDisplay {
    func pined(postId: String) {
        self.pinPost.append(postId)
        self.TableView.reloadData()
    }
    
    func getPinSuccess(postIds: [String]) {
        self.pinPost = postIds
        self.TableView.reloadData()
    }
    
    func getUnPinSuccess(postIds: String) {
        pinPost.removeAll() { id in
            return id == postIds
        }
        self.TableView.reloadData()
    }
    
    func reloadTableView() {
        TableView.reloadData()
    }
    
    func getFavoriteSuccess(postIds: [String]) {
        /// Lưu lại cái mảng pod ids này vào viewcontroller để sử dụng xử lý data
        self.favoritePosts = postIds
        
        /// Reload lại data của tableview để tableview update lại UI
        self.TableView.reloadData()
    }
    
    func getUnFavoriteSuccess(postIds: String) {
        favoritePosts.removeAll{ id in
            return id == postIds
        }
        self.TableView.reloadData()
    }
    
    func getPost(posts: [PostEntity]) {
        DispatchQueue.main.async {
            if posts.isEmpty {
                let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.TableView.bounds.size.width, height: self.TableView.bounds.size.height))
                messageLabel.text = "No data"
                messageLabel.textColor = .black
                messageLabel.numberOfLines = 0;
                messageLabel.textAlignment = .center;
                messageLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
                messageLabel.sizeToFit()
                self.TableView.backgroundView = messageLabel
            } else {
                self.TableView.backgroundView = nil
            }
            self.posts = posts
            
            self.TableView.reloadData()
        }
    }
    
    func favorited(postId: String) {
        self.favoritePosts.append(postId)
        
        /// Reload lại toàn bộ tableview
        self.TableView.reloadData()
       
    }
    

    func displayLoadmorePosts(posts: [PostEntity]) {
        self.posts?.append(contentsOf: posts)
        TableView.reloadData()
    }

    func displayAPIFailure(errorMsg: String?) {
        let alert = UIAlertController(title: "Get Posts Failure", message: errorMsg ?? "Something went wrong", preferredStyle: .alert)
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

    func hideRefreshLoading() {
        refresher.endRefreshing()
    }
}
