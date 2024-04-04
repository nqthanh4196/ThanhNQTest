//
//  VideoCollectionViewCell.swift
//  testScrollview
//
//  Created by IT-17426-THANH on 04/04/2024.
//

import UIKit
enum VideoVoucherType {
    case voucherDiscount
    case voucherShip
    case gift
    case noVoucher
    
    var imageVoucher: String {
        var imageString = ""
        switch self {
        case .voucherDiscount:
            imageString = "VideoVoucherDisocuntBG"
        case .voucherShip:
            imageString = "VideoVoucherShip"
        case .gift:
            imageString = "VideoVoucherGiftBG"
        case .noVoucher:
            imageString = ""
        }
        return imageString
    }
    
    
}
class VideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewShowForVideo: UIView!
    @IBOutlet weak var imageThumbnail: UIImageView!
    
    @IBOutlet weak var viewShowProductInfo: UIView!
    @IBOutlet weak var labelVideoTitle: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var viewDiscount: UIView!
    @IBOutlet weak var labelDiscountValue: UILabel!
    @IBOutlet weak var viewPrice: UIView!
    
    @IBOutlet weak var labelOriginalPrice: UILabel!
    @IBOutlet weak var labelPriceAfterDiscount: UILabel!
    
    @IBOutlet weak var viewVoucher: UIView!
    @IBOutlet weak var imageVoucherType: UIImageView!
    @IBOutlet weak var labelVoucherValue: UILabel!
    
    
    var voucherType: VideoVoucherType = .noVoucher {
        didSet {
            viewVoucher.isHidden = voucherType == .noVoucher
            imageVoucherType.image = UIImage(named: voucherType.imageVoucher)
            switch voucherType {
            case .voucherDiscount:
                break
            case .voucherShip:
                break
            case .gift:
                labelVoucherValue.text = "Quà"
                break
            case .noVoucher:
                break
            }
        }
    }
     
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
