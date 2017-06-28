//
//  SearchProductTableCell.swift
//  MamasAndPapas
//
//  Created by ALI KIRAN on 6/28/17.
//  Copyright © 2017 ALI KIRAN. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Kingfisher
class SearchProductTableCell: UITableViewCell {
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    var data: JSON = [:] {
        didSet {
            self.lblTitle.text = self.data["name"].stringValue
            self.lblDetail.text = self.data["description"].strippedHTML
            self.lblPrice.text = self.data["price"].stringValue + " " + (self.data["priceType"].string ?? "AED")
            
            self.imgProduct.setCDNImage(json: self.data["image"])
        }
    }
}
