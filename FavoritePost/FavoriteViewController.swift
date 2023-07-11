//
//  FavoriteViewController.swift
//  Ex1
//
//  Created by Trương Duy Tân on 21/06/2023.
//

import UIKit
import MBProgressHUD

protocol FavoriteDisplay {
    func getPosts(posts: [PostEntity])
    func loadmorePosts(posts: [PostEntity])
    func callAPIFailure(errorMsg: String?)
    func showLoading(isShow: Bool)
    func hideRefreshLoading()
}

class FavoriteViewController: UIViewController, FavoriteDisplay, UITableViewDelegate, UITableViewDataSource {
    func getPosts(posts: [PostEntity]) {
        if posts.isEmpty {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            messageLabel.text = "No data"
            messageLabel.textColor = .black
            messageLabel.numberOfLines = 0;
            messageLabel.textAlignment = .center;
            messageLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
            messageLabel.sizeToFit()
            tableView.backgroundView = messageLabel
        } else {
            tableView.backgroundView = nil
        }
        self.posts = posts
        tableView.reloadData()
    }
    
    func loadmorePosts(posts: [PostEntity]) {
        self.posts?.append(contentsOf: posts)
        tableView.reloadData()
    }
    
    
    func callAPIFailure(errorMsg: String?) {
        let alert = UIAlertController(title: "Get posts failure", message: errorMsg ?? "Something went wrong", preferredStyle: .alert)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        let post = posts![indexPath.row]
        
        cell.bindData(post: post, isFavorite: true, isPin: true)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let posts = posts else {
            return
        }
        if indexPath.row == posts.count - 1 {
            self.presenter.loadmorePosts()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    

    private var posts: [PostEntity]?
    private var presenter: FavoritePresenter!
    private var refresher = UIRefreshControl()
        
    
    override func viewDidLoad() {
        let service = FavoriteAPIServivceImpl()
        let repo = FavoritePostRepositoryImpl(apiService: service)
        presenter = FavoritePresenterImpl(repository: repo, favoriteVC: self)
        super.viewDidLoad()
        setupTableView()
        
        presenter.getPosts()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none // Không muốn hiển thị các gạch ngăn cách giữa các cell
        
//        Đăng ký custom UITableViewCell
        let cellID = "HomeTableViewCell"
        let nib = UINib(nibName: cellID, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellID)
        
        tableView.refreshControl = refresher
        refresher.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
    }
    
    @objc func onRefresh() {
        presenter.refreshPosts()
    }
}
