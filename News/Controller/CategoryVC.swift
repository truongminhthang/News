//
//  CategoryVC.swift
//  News
//
//  Created by Toan on 3/20/19.
//  Copyright © 2019 Toan.IOS. All rights reserved.
//

import UIKit
protocol HandlerSideMenuDelegate {
    var isOpenMenu: Bool {get set}
    
}

class CategoryVC: UITableViewController{  //} ,UpdateContrainst{
//    func update() {
//    }
    
    // MARK: - outlet
    
    
    let json = JSON()
    var titleCategory1: [String] = []
    var titleCategory2: [String] = []
    var titleCategory3: [String] = []
    let categories: [String] = ["Category 1","Category 2","Category 3"]
    
    var delegate: HandlerSideMenuDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 90
        tableView.delegate = self
        tableView.dataSource = self
        
        
        json.delegate = self as? GetDataFromAPI
        json.getData()
        
        let deadline = DispatchTime.now() + .seconds(1)

        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.setUpTitleForCategory()
            
            
        }
        setUpNotify()
    }
    
    func setUpNotify() {
        NotificationCenter.default.addObserver(self, selector: #selector(ShowNew), name: NSNotification.Name("ShowNew"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ShowCategory), name: NSNotification.Name("ShowCategory"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ShowFavourite), name: NSNotification.Name("ShowFavourite"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ShowSettings), name: NSNotification.Name("ShowSettings"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ShowInformation), name: NSNotification.Name("ShowInformation"), object: nil)
        
        
    }
    @objc
    func ShowNew() {
//        let deadline = DispatchTime.now() + .seconds(1)
//        let up = CollectionViewController()
//        up.delegate = self
//        DispatchQueue.main.async {
//            up.collectionView.layoutIfNeeded()
//            up.collectionView.reloadData()
//        }

        performSegue(withIdentifier: "ShowNew", sender: nil)
    }
    @objc
    func ShowCategory() {
//        performSegue(withIdentifier: "ShowCategory", sender: nil)
        navigationController?.popToRootViewController(animated: true)
        
    }
    @objc
    func ShowFavourite() {
        performSegue(withIdentifier: "ShowFavourite", sender: nil)
    }
    @objc
    func ShowSettings() {
        performSegue(withIdentifier: "ShowSettings", sender: nil)
    }
    @objc
    func ShowInformation() {
        performSegue(withIdentifier: "ShowInformation", sender: nil)
    }
    
    
    func setUpTitleForCategory() {
//        var edit1 = json.arrayCategory1
//        var edit2 = json.arrayCategory2.description
//        var edit3 = json.arrayCategory3.description
//
//        edit1 = edit1.replacingOccurrences(of: "\"", with: "")
//        edit2 = edit2.replacingOccurrences(of: "\"", with: "")
//        edit3 = edit3.replacingOccurrences(of: "\"", with: "")
//
//        titleCategory1.append(edit1)
//        titleCategory2.append(edit2)
//        titleCategory3.append(edit3)
        
        titleCategory1 = json.arrayCategory1
        titleCategory2 = json.arrayCategory2
        titleCategory3 = json.arrayCategory3
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CategoryCell

        // Configure the cell...
        cell.categoryLabel?.text = categories[indexPath.row]
        cell.backgroundColor = UIColor.green
        return cell
    }
    @IBAction func toggleSlideMenu(_ sender: Any) {
        
        delegate?.isOpenMenu = true
        
        
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segue = segue.destination as? CollectionViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                switch indexPath.row {
                case 0: segue.feedUrlStrings = titleCategory1
                case 1: segue.feedUrlStrings = titleCategory2
                case 2: segue.feedUrlStrings = titleCategory3
                default: break
                }
            }
            
        }
    }
    
    
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//
//        tableView.deselectRow(at: indexPath, animated: true)
//        let cell = tableView.cellForRow(at: indexPath) as! MainViewCell
//
//        tableView.beginUpdates()
//        cell.descriptionLabel.numberOfLines = (cell.descriptionLabel.numberOfLines == 0) ? 3 : 0
//
//        cellStates?[indexPath.row] = (cell.descriptionLabel.numberOfLines == 0) ? .expanded : .collapsed
//
//        tableView.endUpdates()
//    }

}
