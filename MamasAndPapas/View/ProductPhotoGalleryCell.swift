//
//  ProductPhotoGalleryCell.swift
//  MamasAndPapas
//
//  Created by ALI KIRAN on 6/28/17.
//  Copyright © 2017 ALI KIRAN. All rights reserved.
//

import Foundation
import UIKit
import Vendors
import SwiftyJSON

class ProductPhotoGalleryCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    var data: JSON = [:] {
        didSet {
            image.layer.cornerRadius = 15
            image.setCDNImage(json: data["src"])
        }
    }
}
