//
//  VideoFaqCollectionViewCell.swift
//  ecapp
//
//  Created by IT-17426-THANH on 04/04/2024.
//  Copyright © 2024 Concung. All rights reserved.
//

import UIKit

class VideoFaqCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageBorderBG: UIView! {
        didSet {
            imageBorderBG.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var imageBackground: UIImageView! {
        didSet {
            imageBackground.roundTopCorners(radius: 8)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
