//
//  ProductDetailSizePickCell.swift
//  MamasAndPapas
//
//  Created by ALI KIRAN on 6/28/17.
//  Copyright © 2017 ALI KIRAN. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Vendors
import Kingfisher
class ProductDetailSizePickCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDataSourcePrefetching {
    @available(iOS 10.0, *)
    func collectionView(_: UICollectionView, prefetchItemsAt _: [IndexPath]) {
        
    }
    
    @available(iOS 6.0, *)
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return items.count
    }
    
    @available(iOS 6.0, *)
    func collectionView(_: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: ProductDetailSizeDisplayCell.objectName, for: indexPath) as! ProductDetailSizeDisplayCell
        cell.data = items[indexPath.item]
        return cell
    }
    
    @IBOutlet var collection: UICollectionView!
    
    var items: [JSON] = [] {
        didSet {
            collection.prefetchDataSource = self
            collection.delegate = self
            collection.dataSource = self
            collection.isPagingEnabled = true
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            let numberOfItemInRow = 4
            let spacing: CGFloat = 4.0
            layout.minimumLineSpacing = 4
            layout.minimumInteritemSpacing = 4
            layout.itemSize = CGSize(width: (self.width - spacing * (numberOfItemInRow - 1).g) / numberOfItemInRow.g, height: 44.0)
            collection.setCollectionViewLayout(layout, animated: true)
            collection.reloadData()
        }
    }
}

class ProductDetailSizeDisplayCell: UICollectionViewCell {
    var data: JSON = [:] {
        didSet {
            
        }
    }
}
