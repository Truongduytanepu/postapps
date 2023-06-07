//
//  TutorialViewController.swift
//  Ex1
//
//  Created by Trương Duy Tân on 02/06/2023.
//

import UIKit

class TutorialViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    struct Tutorial {
            var imageName: String
            var title: String
            var desc: String
        }
        
        private var dataSource = [Tutorial]()
        private var currentPage = 0
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            collectionView.dataSource = self
            collectionView.delegate = self
            
            if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.scrollDirection = .horizontal
                flowLayout.estimatedItemSize = .zero
            }
            
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.isPagingEnabled = true
            
            collectionView.register(UINib(nibName: "ItemSectionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemSectionCollectionViewCell")
            
            dataSource = [
                Tutorial(imageName: "tutorial1",
                         title: "Welcome to Techmaster",
                         desc: "Học là có việc"),
                Tutorial(imageName: "tutorial2",
                         title: "Lớp iOS nâng cao - iOS 08",
                         desc: "Học vì đam mê"),
                Tutorial(imageName: "tutorial3",
                         title: "Nâng cao giá trị bản thân",
                         desc: "Hãy làm những gì mình thích"),
            ]
            
            collectionView.reloadData()
        }
        
        private func routeToAuthNavigation() {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true)
        }
        
        // MARK: UICollectionViewDataSource
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return dataSource.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemSectionCollectionViewCell", for: indexPath) as! ItemSectionCollectionViewCell
            let tutorialModel = dataSource[indexPath.row]
            
            cell.bindData(index: indexPath.row,
                          image: tutorialModel.imageName,
                          title: tutorialModel.title,
                          desc: tutorialModel.desc) { [weak self] in
                guard let self = self else { return }
                if indexPath.row + 1 == 3 {
                    // go to login
                    self.routeToAuthNavigation()
                } else {
                    self.currentPage = indexPath.row + 1
                    self.collectionView.isPagingEnabled = false
                    self.collectionView.scrollToItem(at: IndexPath(row: self.currentPage, section: 0), at: .centeredHorizontally, animated: true)
                    self.collectionView.isPagingEnabled = true
                }
            }
            return cell
        }
        
        // MARK: UICollectionViewDelegateFlowLayout
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
        
}
