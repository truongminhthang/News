//
//  CollectionViewCell.swift
//  News
//
//  Created by Toan on 3/21/19.
//  Copyright © 2019 Toan.IOS. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel:UILabel!
    
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var descriptionLabel:UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 0
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
            self.descriptionLabel.backgroundColor = UIColor.blue
        
        }
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true
    }
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? CollectionViewAttributes {
            imageViewHeightConstraint.constant = attributes.imageHeight
        } else {
            return
        }
    }
    
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        setNeedsLayout()
//        layoutIfNeeded()
//        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
//        var frame = layoutAttributes.frame
//        frame.size.height = ceil(size.height)
//        layoutAttributes.frame = frame
//        return layoutAttributes
//    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageContent.image = nil
        titleLabel.text = ""
        descriptionLabel.text = ""
        dateLabel.text = ""
    }
    
}


