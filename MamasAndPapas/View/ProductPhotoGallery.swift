//
//  ProductPhotoGallery.swift
//  MamasAndPapas
//
//  Created by ALI KIRAN on 6/28/17.
//  Copyright © 2017 ALI KIRAN. All rights reserved.
//

import Foundation
import UIKit
import Vendors
import SwiftyJSON
import Kingfisher

class ProductDetailGalleryCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDataSourcePrefetching {
    @available(iOS 10.0, *)
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let urls = indexPaths.flatMap { self.items[$0.row]["src"].asCDNURL }
        ImagePrefetcher(urls: urls).start()
    }
    
    @available(iOS 6.0, *)
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return items.count
    }
    
    @available(iOS 6.0, *)
    func collectionView(_: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: ProductPhotoGalleryCell.objectName, for: indexPath) as! ProductPhotoGalleryCell
        cell.data = items[indexPath.item]
        return cell
    }
    
    @IBOutlet var collection: UICollectionView!
    
    var items: [JSON] = [] {
        didSet {
            collection.prefetchDataSource = self
            collection.delegate = self
            collection.dataSource = self
            collection.isPagingEnabled  = true
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.itemSize = self.size
            collection.setCollectionViewLayout(layout, animated: true)
            collection.reloadData()
        }
    }
}
