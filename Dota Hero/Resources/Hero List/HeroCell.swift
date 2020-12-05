//
//  HeroCell.swift
//  Dota Hero
//
//  Created by Dwi Putra on 05/12/20.
//

import UIKit
import Kingfisher

class HeroCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAttackType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.systemGray3.cgColor
    }
    
    func setImage(_ url:String){
        img.backgroundColor = .skeletonDefault
        let processor = DownsamplingImageProcessor(size: img.bounds.size)
        img.kf.setImage(
            with: URL(string: url),
            placeholder: nil,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ],
            progressBlock:  nil)
    }

}
