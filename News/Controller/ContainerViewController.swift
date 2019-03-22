//
//  ContainerViewController.swift
//  News
//
//  Created by Toan on 3/13/19.
//  Copyright © 2019 Toan.IOS. All rights reserved.
//

import UIKit
import AlamofireRSSParser
import Alamofire

class ContainerViewController: UIViewController, HandlerSideMenuDelegate {

    @IBOutlet weak var leadingContainerView: NSLayoutConstraint!
    @IBOutlet weak var slideMenuView: UIView!
    @IBOutlet weak var coverButton: UIButton!
    
    var isOpenMenu = false {
        didSet {
            UIView.animate(withDuration: 0.3) {
                self.leadingContainerView.constant = self.isOpenMenu ? 0 : -self.slideMenuView.bounds.width
                self.coverButton.alpha = self.isOpenMenu ? 1 : 0
                self.view.layoutIfNeeded()
                if self.isOpenMenu == true {
                self.slideMenuView.layer.shadowColor = UIColor.gray.cgColor
                self.slideMenuView.layer.shadowOffset = CGSize(width: 12, height: 0)
                self.slideMenuView.layer.shadowOpacity = 0.3
                } else {
                    self.slideMenuView.layer.shadowColor = UIColor.clear.cgColor

                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(toggleSideMenu), name: NSNotification.Name("ToggleSideMenu"), object: nil)
//        RSSParser.getRSSFeedResponse(path: "https://www.bisnis.com/rss") { (rssFeed: RSSFeed?, status: NetworkResponseStatus) in
//            print(rssFeed) // it will be nil if status == .error
//        }
        isOpenMenu = false
//        setShadow()
    }
    @objc
    func toggleSideMenu() {
        isOpenMenu = !isOpenMenu
//        if isOpenMenu == true {
//            setShadow()
//        }
    
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sender = segue.destination as? UINavigationController
        let categoryVC = sender?.topViewController as? CategoryVC
        categoryVC?.delegate = self
    }
    
    func setShadow() {
        
        slideMenuView.layer.shadowColor = UIColor.gray.cgColor
        slideMenuView.layer.shadowOffset = CGSize(width: 10, height: 0)
        slideMenuView.layer.shadowOpacity = 0.35
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        isOpenMenu = false
//        setShadow()

    }

    
    // TODO : 1.
    @IBAction func clickCoverButton(_ sender: UIButton) {
        isOpenMenu = !isOpenMenu
//        if isOpenMenu == true {
//            setShadow()
//        }
        
    }

    

}
