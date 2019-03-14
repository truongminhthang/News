//
//  MainViewController.swift
//  News
//
//  Created by Toan on 3/13/19.
//  Copyright © 2019 Toan.IOS. All rights reserved.
//

import UIKit
protocol HandlerSideMenuDelegate {
    var isOpenMenu: Bool {get set}
    
}

class MainViewController: UIViewController {
    var delegate: HandlerSideMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    @IBAction func openMenu(_ sender: Any) {
        delegate?.isOpenMenu = true
    }
    
    
}
