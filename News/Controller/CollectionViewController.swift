//
//  CollectionViewController.swift
//  News
//
//  Created by Toan on 3/17/19.
//  Copyright © 2019 Toan.IOS. All rights reserved.
//

import UIKit
import AVFoundation

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {

    private var rssItems: [RSSItem]?
    private var cellStates: [CellState]?
    var feedUrlStrings = [String]()

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 10, bottom: 10, right: 10)
        if let layout = collectionView?.collectionViewLayout as? Layout {
            layout.delegate = self
        }
        collectionView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        fetchData()
        print(feedUrlStrings)
    }

    private func fetchData() {
        let feedParser = RSSParser()
//        if feedUrlStrings != nil {
        feedUrlStrings.forEach { (string) in
            
            feedParser.parseFeed(url: string) { data in
                self.rssItems = data
                self.cellStates = Array(repeating: .collapsed, count: data.count)
                
                // Phan biet OperationQueue vs DispatchQueue
                
                OperationQueue.main.addOperation {
                    self.collectionView.reloadSections(IndexSet(integer: 0))
                }
                
                
            }
        }
//        }
//        else {
//            feedParser.parseFeed(url: "http://www.wowkeren.com/rss/wk_news.xml") { data in
//                self.rssItems = data
//                self.cellStates = Array(repeating: .collapsed, count: data.count)
//
//                // Phan biet OperationQueue vs DispatchQueue
//
//                OperationQueue.main.addOperation {
//                    self.collectionView.reloadSections(IndexSet(integer: 0))
//                }
//
//
//            }
//        }
    }
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        guard let rssItems = rssItems else {return 0}
        return rssItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        if let item = rssItems?[indexPath.item] {
            
            cell.item = item
            if cell.item.img == nil {
                // Image constraint
//                cell.imageContent.topAnchor.constraint(equalToSystemSpacingBelow: cell.containerView.topAnchor, multiplier: 1).isActive = true
//                cell.imageContent.leadingAnchor.constraint(equalToSystemSpacingAfter: cell.containerView.leadingAnchor, multiplier: 1).isActive = true
//                cell.imageContent.trailingAnchor.constraint(equalToSystemSpacingAfter: cell.containerView.trailingAnchor, multiplier: 1).isActive = true
                
                cell.imageContent.isHidden = true
                
//                cell.imageContent.bottomAnchor.constraint(equalToSystemSpacingBelow: cell.containerView.topAnchor, multiplier: 1).isActive = true
//                cell.imageContent.heightAnchor.constraint(equalToConstant: 0)
                
                // Title constraint
                
//                cell.titleLabel.topAnchor.constraint(equalTo: cell.containerView.topAnchor, constant: 10).isActive = true
//                cell.titleLabel.leadingAnchor.constraint(equalTo: cell.containerView.leadingAnchor, constant: 4).isActive = true
//                cell.titleLabel.trailingAnchor.constraint(equalTo: cell.containerView.trailingAnchor, constant: 4).isActive = true
//                
//                
////                cell.titleLabel.topAnchor.constraint(equalTo: cell.containerView.topAnchor, constant: 4).isActive = true
//                
//                // Description constraint
//                cell.descriptionLabel.topAnchor.constraint(equalTo: cell.titleLabel.bottomAnchor, constant: 10).isActive = true
//                cell.descriptionLabel.leadingAnchor.constraint(equalTo: cell.containerView.leadingAnchor, constant: 4).isActive = true
//                cell.descriptionLabel.trailingAnchor.constraint(equalTo: cell.containerView.trailingAnchor, constant: 4).isActive = true
////                cell.descriptionLabel.topAnchor.constraint(equalTo: cell.dateLabel.topAnchor, constant: 10).isActive = true
//
//                // Date constraint
////                cell.dateLabel.trailingAnchor.constraint(equalTo: cell.descriptionLabel.bottomAnchor, constant: 10).isActive = true
//                
//                cell.dateLabel.leadingAnchor.constraint(equalTo: cell.containerView.leadingAnchor, constant: 4).isActive = true
//                cell.dateLabel.trailingAnchor.constraint(equalTo: cell.containerView.trailingAnchor, constant: 4).isActive = true
//                cell.dateLabel.bottomAnchor.constraint(equalTo: cell.containerView.bottomAnchor, constant: 2).isActive = true
//                cell.dateLabel.heightAnchor.constraint(equalToConstant: 20)
                if let cellStates = cellStates {
                    cell.descriptionLabel.numberOfLines = 0

                }

            } else {
            
            if let cellStates = cellStates {
                cell.descriptionLabel.numberOfLines = (cellStates[indexPath.row] == .expanded) ? 0 : 4
                
            }
            }
            print(cell.descriptionLabel.text)
        }
        // Configure the cell
    
        return cell
    }
    @IBAction func slideMeunu(sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }

//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
//        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
////        collectionView.
////        collectionView.beginUpdates()
//        cell.descriptionLabel.numberOfLines = (cell.descriptionLabel.numberOfLines == 0) ? 3 : 0
//
//        cellStates?[indexPath.row] = (cell.descriptionLabel.numberOfLines == 0) ? .expanded : .collapsed
//
////        collectionView.endUpdates()
//    }
    // MARK: Navigation
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    

}


extension CollectionViewController : LayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        guard let imgHeight = rssItems![indexPath.item].img?.size.height  else {return 0}
        return imgHeight
    }
}
//extension CollectionViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 100, height: 100)
//    }
//}
