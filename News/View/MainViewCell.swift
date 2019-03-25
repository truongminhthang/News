//
//  MainViewCell.swift
//  News
//
//  Created by Toan on 3/14/19.
//  Copyright © 2019 Toan.IOS. All rights reserved.
//

import UIKit

enum CellState {
    case expanded
    case collapsed
}

enum ImageState{
    case expanded
    case collapsed
}

class MainViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var descriptionLabel:UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 3
        }
    }
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageContent: UIImageView!

    var item: RSSItem! {
        didSet {
            titleLabel.text = item.title
            descriptionLabel.text = item.description
            dateLabel.text = item.pubDate
            imageContent.image = item.img
            
//            imageContent.images = item.img
        }
        
        
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        titleLabel.text = ""
//        descriptionLabel.text = ""
//        dateLabel.text = ""
//    }

}
