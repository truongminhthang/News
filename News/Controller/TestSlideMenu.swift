//
//  TestSlideMenu.swift
//  News
//
//  Created by Toan on 3/20/19.
//  Copyright © 2019 Toan.IOS. All rights reserved.
//

import UIKit
let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)

class TestSlideMenu: UITableViewController {

    @IBOutlet weak var imageLogo: UIImageView!

    
    let slideArr = ["Last News","Category","Favourite","Settings","Information"]
    var slideImage : [UIImage] = [
        UIImage(named: "icons8-news-1")!,
        UIImage(named: "icons8-elective-1")!,
        UIImage(named: "icons8-bookmark_ribbon_filled")!,
        UIImage(named: "icons8-settings_filled")!,
        UIImage(named: "icons8-info_filled")!
    ]
    var slideSelectedImage: [UIImage] = [
        UIImage(named: "icons8-news")!,
        UIImage(named: "icons8-elective")!,
        UIImage(named: "icons8-bookmark_ribbon")!,
        UIImage(named: "icons8-settings")!,
        UIImage(named: "icons8-info")!
    ]
    
    var arrIndexPaths: [NSIndexPath] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        imageLogo.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 200)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return slideArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! SlideMenuCell
        if indexPath.row == 2 {
            cell.separatedView.backgroundColor = UIColor.black
        }
        cell.textLabel?.text = slideArr[indexPath.row]

        cell.imageView?.image = slideImage[indexPath.row]
        // cell.slideMenuButton.setImage(slideImage[indexPath.row], for: .normal)
        
//        cell.slideMenuButton.tag = indexPath.row
//        cell.slideMenuButton?.setImage(slideImage[indexPath.row], for: .normal)
 
        return cell
    }
//    @objc func btnTapped(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath) as! SlideMenuCell
//            cell.slideMenuButton.imageView?.image = slideSelectedImage[indexPath.row]
        cell.imageView?.image = slideSelectedImage[indexPath.row]
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
        switch indexPath.row {
        case 0: NotificationCenter.default.post(name: NSNotification.Name("ShowNew"), object: nil)
        case 1: NotificationCenter.default.post(name: NSNotification.Name("ShowCategory"), object: nil)
        case 2: NotificationCenter.default.post(name: NSNotification.Name("ShowFavourite"), object: nil)
        case 3: NotificationCenter.default.post(name: NSNotification.Name("ShowSettings"), object: nil)
        case 4: NotificationCenter.default.post(name: NSNotification.Name("ShowInformation"), object: nil)

        default: break
        }

    }

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath) as! SlideMenuCell

        cell.imageView?.image = slideImage[indexPath.row]
    }
    
    
        
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let indexPath = tableView.indexPathForSelectedRow {
            if indexPath.row == 0 {
                let SlideMenuVC = storyBoard.instantiateViewController(withIdentifier: "SlideMenuVC")
                
                navigationController?.pushViewController(SlideMenuVC, animated: true)
                
            }
        }
        
    }
    

}
