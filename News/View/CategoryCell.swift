//
//  CategoryCell.swift
//  News
//
//  Created by Toan on 3/20/19.
//  Copyright © 2019 Toan.IOS. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    // MARK: - IBOUTLET
    
//    @IBOutlet weak var newsButton: UIButton!
//    @IBOutlet weak var categoryButton: UIButton!
//    @IBOutlet weak var favouriteButton: UIButton!
//    @IBOutlet weak var settingsButton: UIButton!
//    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
