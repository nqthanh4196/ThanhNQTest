//
//  VideoShoppingCollectionViewCell.swift
//  ecapp
//
//  Created by Nguyễn Quốc Thanh on 06/04/2024.
//  Copyright © 2024 Concung. All rights reserved.
//

import UIKit

class VideoShoppingCollectionViewCell: UICollectionViewCell {

    // MARK: - Left View Outlet
    //LoveView
    @IBOutlet weak var loveView: UIView!
    @IBOutlet weak var imageLoveIcon: UIImageView!
    @IBOutlet weak var labelLoveCount: UILabel!
     // commentView
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var imageCommentIcon: UIImageView!
    @IBOutlet weak var labelCommentCount: UILabel!
    //shareView
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var imageShareIcon: UIImageView!
    @IBOutlet weak var labelShareCount: UILabel!
      //sameVideoView
    @IBOutlet weak var sameVideoView: UIView!
    @IBOutlet weak var imageSameVideoIcon: UIImageView!
    @IBOutlet weak var labelSameVideo: UILabel!
     // muteView
    @IBOutlet weak var muteView: UIView!
    @IBOutlet weak var imageMuteIcon: UIImageView!
     //MARK: - Center View Outlet
    //HastagView
    @IBOutlet weak var labelHastag: UILabel!
    //Brand Info View
    @IBOutlet weak var viewBrandInfo: UIView!
    @IBOutlet weak var imageBrandLogo: UIImageView!
    @IBOutlet weak var labelBrandName: UILabel!
    @IBOutlet weak var viewFollow: UIView!
    @IBOutlet weak var imageFollowBG: UIImageView!
    @IBOutlet weak var imageFollowPlusIcon: UIImageView!
    @IBOutlet weak var labelFollow: UILabel!
     //Product View
    @IBOutlet weak var productCollectionViewCell: UICollectionView!
    
    
//    private var productsDataSource:
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
     
    
    //MARK: - Variable Left UI
    
    var isLikeVideo: Bool = false {
        didSet {
            imageLoveIcon.image = UIImage(named: isLikeVideo ? "Love_Video_icon" : "UnLove_Video_icon")
        }
    }
    
    var isMute: Bool = true {
        didSet {
            imageMuteIcon.image = UIImage(named: isMute ? "Mute_Video_icon" : "unMute_Video_icon")
        }
    }
    
    
    
    
    
    
    
    
    
  
    //MARK: - Left Action
    @IBAction func likeAction(_ sender: Any) {
        
    }
    
    @IBAction func commentAction(_ sender: Any) {
        
    }
    
    @IBAction func shareAction(_ sender: Any) {
        
    }
    
    @IBAction func sameVideoAction(_ sender: Any) {
        
    }
    
    @IBAction func muteAction(_ sender: Any) {
        
    }
    
}
