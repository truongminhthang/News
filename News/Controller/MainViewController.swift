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

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: HandlerSideMenuDelegate?
    var demoFeed = [String: String]()
    let url = URL(string: "https://www.bisnis.com/rss")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        //        ParseRSS.shared/[
        //        demoFeed = ParseRSS.shared.startParsingWithContentsOfURL(url!, with: (Bool) -> ())
        //        ParseRSS.shared.starParsingWithContentsOfURL(<#T##rssURL: URL##URL#>, with: <#T##(Bool) -> Void#>)
    }
    
    
    
    @IBAction func openMenu(_ sender: Any) {
        delegate?.isOpenMenu = true
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demoFeed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainViewCell
        //TODO: Tao 3 label de in Title, description, pubDate.
        
        return cell
        
    }
    
}
