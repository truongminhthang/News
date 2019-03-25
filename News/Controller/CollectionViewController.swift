//
//  CollectionViewController.swift
//  News
//
//  Created by Toan on 3/17/19.
//  Copyright © 2019 Toan.IOS. All rights reserved.
//

import UIKit
import AVFoundation
//protocol UpdateContrainst: class {
//    func update()
//}

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
//    weak var delegate: UpdateContrainst?
    private var isFinishDownloading = false
    private var rssItems: [RSSItem]?//{
//        didSet {
//            self.collectionView?.reloadData()
//            self.collectionViewLayout.invalidateLayout()
//        }
//    }
    private var cellStates: [CellState]?
    var feedUrlStrings = [String]()

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        collectionView.dataSource = self
        collectionView?.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 10, right: 5)

        let layout = collectionViewLayout as! CollectionViewLayout
        layout.delegate = self as? LayoutDelegate
        layout.numberOfColumns = 2
        layout.cellPadding = 5
         
        
//        layout.cache.removeAll()
        
        DispatchQueue.main.async {
            self.collectionView.setNeedsDisplay()
            self.collectionView.reloadData()
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
//                DispatchQueue.main.async {
                self.rssItems = data
                self.cellStates = Array(repeating: .collapsed, count: data.count)
                
                // Phan biet OperationQueue vs DispatchQueue
                
//                OperationQueue.main.addOperation {
//                    self.collectionView.reloadSections(IndexSet(integer: 0))
//                }
                let deadline = DispatchTime.now() + .seconds(2)
                
                DispatchQueue.main.asyncAfter(deadline: deadline) {
                    self.collectionView.reloadSections(IndexSet(integer: 0))
                }
            
//                }
                self.isFinishDownloading = true
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
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.collectionView.layoutIfNeeded()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        guard let rssItems = rssItems else {return 0}
        return rssItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
//        cell.containerView.sys
        if isFinishDownloading == true {
        if let item = rssItems?[indexPath.item] {
            
            cell.item = item
            
            if let cellStates = cellStates {
                cell.descriptionLabel.numberOfLines = (cellStates[indexPath.row] == .expanded) ? 0 : 4
                
            }
//            }
//            print(cell.descriptionLabel.text)
        }
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
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    

}

//MARK: UICollectionViewDataSource
extension CollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    
}

// MARK: UICollectionViewDelegate
extension CollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = rssItems?[indexPath.item] else { return }
//        performSegue(withIdentifier: "<#T##String#>", sender: <#T##Any?#>)
    }

}

// MARK: - LayoutDelegate
extension CollectionViewController: LayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        
        guard let item = rssItems?[indexPath.item] else { return 0}
        guard let image = item.img else {return 0}
//        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
//        let rect = AVMakeRect(aspectRatio: image.size, insideRect: boundingRect)
        
        
//        return rect.height
        return image.size.height
    }
    func collectionView(_ collectionView: UICollectionView, heightForTitleAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
//        guard let item = rssItems?[indexPath.item] else { return 0}
        let item = rssItems![indexPath.item]
        let titleHeight = heightForTitleText(item.title, width: width - 8)
        let height = 4 + 4 + titleHeight
        
        return height
    }
    func collectionView(_ collectionView: UICollectionView, heightForDescriptionAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        guard let item = rssItems?[indexPath.item] else { return 0}
        
        let descriptionHeight = heightForText(item.description, width: width - 8)
        let height = 4 + 17 + 4 + descriptionHeight + 12
        return height
    }
    
    
    func heightForText(_ text: String, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 10)
        let rect = NSString(string: text).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)
    }
    func heightForTitleText(_ text: String, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 14)
        let rect = NSString(string: text).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)
    }
}


// MARK: - Pre-fetching API: to preload data

extension CollectionViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        <#code#>
    }
}
