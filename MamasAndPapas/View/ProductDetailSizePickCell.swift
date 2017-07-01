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
import ObjectiveC
import Kingfisher
import Signals
class ProductDetailSizePickCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var selectedSignal:Signal<JSON> = Signal<JSON>()
    func numberOfSections(in _: UICollectionView) -> Int {
        return 1
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
    
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var data = items[indexPath.item]
    
        items = items.map({ (json) -> JSON in
            var data_ = json
            data_["isSelected"].bool = json["optionId"].intValue == data["optionId"].intValue
            return data_
        })
        
        self.selectedSignal.fire(data)
    }
    
    @IBOutlet var collection: UICollectionView!
    
    override func awakeFromNib() {
        
    }
    
    func prepare() {
        collection.delegate = self
        collection.dataSource = self
        collection.isPagingEnabled = false
    }
    
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 44)
    }

    var items: [JSON] = [] {
        didSet {
        
            self.collection.reloadData()
            
        }
    }
}

class ProductDetailSizeDisplayCell: UICollectionViewCell {
    
    @IBOutlet weak var lblSize: UILabel!
    
    override func prepareForReuse() {
    }
    
    var data: JSON = [:] {
        didSet {
            self.lblSize.text = data["label"].stringValue
            
            if data["isSelected"].boolValue {
                self.lblSize.textColor = UIColor.white
                self.backgroundColor = UIColor.black
            } else {
                self.lblSize.textColor = UIColor.black
                self.backgroundColor = UIColor.white
                 self.borderColor = UIColor.black
            }
            
            self.layoutAndWait { 
                
            }
        }
    }
}
