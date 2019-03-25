//
//  MainViewController.swift
//  News
//
//  Created by Toan on 3/13/19.
//  Copyright © 2019 Toan.IOS. All rights reserved.
//

import UIKit
import Alamofire
//protocol HandlerSideMenuDelegate {
//    var isOpenMenu: Bool {get set}
//    
//}

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
//    var delegate: HandlerSideMenuDelegate?
    let url = URL(string: "http://www.wowkeren.com/rss/wk_news.xml")
    private var rssItems: [RSSItem]?
    private var cellStates: [CellState]?
    
    //MARK: Test Get link from Json
    
    
    var category: [String] = []
//    let singleton = JSON.Shared
    let a = JSON()
//    let singleton = JSON()
    //////////////////////////////
    
    var titleCategory1: String?
    var titleCategory2: String?
    var titleCategory3: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 160.0
        tableView.rowHeight = UITableView.automaticDimension
        
        a.delegate = self as? GetDataFromAPI
//        a.getData()
        a.getData()
//        fetchData()
        let deadline = DispatchTime.now() + .seconds(1)
//
//        DispatchQueue.main.asyncAfter(deadline: deadline) {
//            self.fetchData()
//        }
//        DispatchQueue.main.async {
//            self.singleton.getData()
//
//        }
        fetchData()
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.setUpTitleForCategory()
        }
        
    }
    // MARK: - CAN SUA
    func setUpTitleForCategory() {
        titleCategory1 = a.arrayCategory1.description
        titleCategory2 = a.arrayCategory2.description
        titleCategory3 = a.arrayCategory3.description

//        category.append(titleCategory1!)
//        category.append(titleCategory2!)
//        category.append(titleCategory3!)
        
        print(titleCategory1)
//        print(category.description)
    }
    
    private func fetchData() {
        let feedParser = RSSParser()
        feedParser.parseFeed(url: "http://www.wowkeren.com/rss/wk_news.xml") { data in
            self.rssItems = data
            self.cellStates = Array(repeating: .collapsed, count: data.count)
            
            // Phan biet OperationQueue vs DispatchQueue
            
            OperationQueue.main.addOperation {
                self.tableView.reloadSections(IndexSet(integer: 0), with: .right)
                
            }
        
        }

    }
    
    @IBAction func openMenu(_ sender: Any) {
//        delegate?.isOpenMenu = true
        
    }
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rssItems = rssItems else {return 0}
        return rssItems.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainViewCell
        //TODO: Tao 3 label de in Title, description, pubDate.
    
        if let item = rssItems?[indexPath.item] {
            
            cell.item = item
            cell.selectionStyle = .none
            
            if let cellStates = cellStates {
                cell.descriptionLabel.numberOfLines = (cellStates[indexPath.row] == .expanded) ? 0 : 4
                
            }
            
        }
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! MainViewCell

        tableView.beginUpdates()
        cell.descriptionLabel.numberOfLines = (cell.descriptionLabel.numberOfLines == 0) ? 3 : 0

        cellStates?[indexPath.row] = (cell.descriptionLabel.numberOfLines == 0) ? .expanded : .collapsed

        tableView.endUpdates()
    }
    
}
