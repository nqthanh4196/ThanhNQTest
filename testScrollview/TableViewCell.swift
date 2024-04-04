//
//  TableViewCell.swift
//  testScrollview
//
//  Created by IT-17426-THANH on 23/02/2024.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    
    @IBOutlet weak var tf: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
