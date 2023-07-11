////
////  PinPostTableViewCell.swift
////  Ex1
////
////  Created by Trương Duy Tân on 19/06/2023.
////
//
import UIKit
//
class PinPostTableViewCell: UITableViewCell {
    //
    @IBOutlet weak var contentLb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none}
    func bindData(post: PostEntity) {
        contentLb.text = post.content
    }
}
