//
//  ItemSectionCollectionViewCell.swift
//  Ex1
//
//  Created by Trương Duy Tân on 02/06/2023.
//

import UIKit

class ItemSectionCollectionViewCell: UICollectionViewCell {
    var nextCallback: (() -> Void)?
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var desclbl: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tutorialImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nextBtn.setTitle("Skip", for: .normal)
        tutorialImage.image = nil
        lblTitle.text = nil
        desclbl.text = nil
        
        nextBtn.layer.borderWidth = 1
        nextBtn.layer.borderColor = UIColor(red: 0.004, green: 0.69, blue: 0.945, alpha: 1).cgColor
        nextBtn.setTitleColor(UIColor(red: 0.004, green: 0.69, blue: 0.945, alpha: 1), for: .normal)
        nextBtn.layer.cornerRadius = 5
        nextBtn.clipsToBounds = true
    }
    @IBAction func handleButtonAction(_ sender: UIButton) {
        
        nextCallback?()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        tutorialImage.image = nil
        lblTitle.text = nil
        desclbl.text = nil
    }
    func bindData(index: Int, image: String, title: String, desc: String, nextCallback: (() -> Void)?) {
        if index == 2 {
            nextBtn.setTitle("Start", for: .normal)
        } else {
            nextBtn.setTitle("Skip", for: .normal)
        }
        
        self.nextCallback = nextCallback
        tutorialImage.image = UIImage(named: image)
        lblTitle.text = title
        desclbl.text = desc
    }
}
