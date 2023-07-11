//
//  HomeTableViewCell.swift
//  Ex1
//
//  Created by Trương Duy Tân on 14/06/2023.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pinbtn: UIButton!
    @IBOutlet weak var favoritebtn: UIButton!
    @IBOutlet weak var lblCreatedAt: UILabel!
    @IBOutlet weak var authorAvatarImg: UIImageView!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAuthorName: UILabel!
    var favoriteHandleCallback: (() -> Void)?
    var pinHandleCallBack: (() -> Void)?
    override func awakeFromNib() {
            super.awakeFromNib()
            selectionStyle = .none
            authorAvatarImg.layer.cornerRadius = authorAvatarImg.bounds.width / 2
        }
        
        
    @IBAction func handleFavorite(_ sender: Any) {
        favoriteHandleCallback?()
        print("abc")
    }
    @IBAction func handlePin(_ sender: Any) {
        pinHandleCallBack?()
        print("bcd")
        
    }
    
    func bindData(post: PostEntity, isFavorite: Bool, isPin: Bool) {
            lblContent.text = post.content
            
            if let createdAt = post.createdAt {
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                
                if let date = dateFormatter.date(from: createdAt) {
                    let formatter2 = DateFormatter()
                    formatter2.locale = Locale(identifier: "en_US_POSIX")
                    formatter2.dateFormat = "dd-MMM-yyyy HH:mm:ss"
                    lblCreatedAt.text = formatter2.string(from: date)
                }
            }
            
            lblTitle.text = post.title
            lblAuthorName.text = post.author?.username ?? "Unknown"
            favoritebtn.tintColor = isFavorite ? .red : .black
            pinbtn.tintColor = isPin ? .red :.black
        }
        
        func authorAvatar(image: UIImage?) {
            if let uwImage = image {
                authorAvatarImg.image = uwImage
            } else {
                authorAvatarImg.image = UIImage(named: "user_default")
            }
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            // Xử lý việc lựa chọn cell (nếu cần)
        }
    }
