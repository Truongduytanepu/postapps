//
//  FavoriteTableViewCell.swift
//  Ex1
//
//  Created by Trương Duy Tân on 21/06/2023.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var contentLb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    func bindData(post: PostEntity) {
        contentLb.text = post.content
    }
    
}
