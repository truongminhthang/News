//
//  CollectionViewLayouts.swift
//  News
//
//  Created by Lê Toàn on 3/24/19.
//  Copyright © 2019 Toan.IOS. All rights reserved.
//

import UIKit

protocol LayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
    
    func collectionView(_ collectionView: UICollectionView, heightForDescriptionAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
    
    func collectionView(_ collectionView: UICollectionView, heightForTitleAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
    
}


class CollectionViewAttributes : UICollectionViewLayoutAttributes {
    
    var imageHeight: CGFloat = 0
    //
    var titleHeight: CGFloat = 0
    var descriptionHeight: CGFloat = 0
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! CollectionViewAttributes
        copy.imageHeight = imageHeight
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? CollectionViewAttributes {
            if attributes.imageHeight == imageHeight {
                return super.isEqual(object)
                
            }
        }
        return false
    }
    
}

class CollectionViewLayout: UICollectionViewLayout {
    
    var delegate: LayoutDelegate!
    var numberOfColumns = 0
    var cellPadding: CGFloat = 0
    
    var cache = [CollectionViewAttributes]()
    fileprivate var contentHeight: CGFloat = 0
    fileprivate var width: CGFloat {
        get {
            let insets = collectionView!.contentInset
            return collectionView!.bounds.width - (insets.left + insets.right)
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: width, height: contentHeight)
    }
    
    override class var layoutAttributesClass: AnyClass {
        return CollectionViewAttributes.self
    }
    
    override func prepare() {
        super.prepare()
//        if cache.isEmpty {
            let columnWidth = width / CGFloat(numberOfColumns)
            
            var xOffsets = [CGFloat]()
            for column in 0..<numberOfColumns {
                xOffsets.append(CGFloat(column) * columnWidth)
            }
            
            
            var yOffsets = [CGFloat](repeating: 0, count: numberOfColumns) // ? yOffsets, repeating
            
            var column = 0
            for item in 0..<collectionView!.numberOfItems(inSection: 0) {
                let indexPath = IndexPath(item: item, section: 0)
                
                let width = columnWidth - (cellPadding * 2)
                let imageHeight = delegate.collectionView(collectionView!, heightForImageAtIndexPath: indexPath, withWidth: width)
                
                let descriptionHeight = delegate.collectionView(collectionView!, heightForImageAtIndexPath: indexPath, withWidth: width)
                
                let titleHeight = delegate.collectionView(collectionView!, heightForTitleAtIndexPath: indexPath, withWidth: width)
                
                let height = cellPadding + imageHeight + titleHeight + descriptionHeight + cellPadding + 20
                
                let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                let attributes = CollectionViewAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                attributes.imageHeight = imageHeight
                attributes.titleHeight = titleHeight
                
                cache.append(attributes)
                contentHeight = max(contentHeight, frame.maxY)
                yOffsets[column] = yOffsets[column] + height
                column = column >= (numberOfColumns - 1) ? 0 : column + 1
            }
//        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) { // Figure out
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
}

