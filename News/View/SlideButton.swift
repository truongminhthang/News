//
//  SlideButton.swift
//  News
//
//  Created by Toan on 3/20/19.
//  Copyright © 2019 Toan.IOS. All rights reserved.
//

import UIKit

@IBDesignable
class SlideButton: UIButton {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
    }
    

}
