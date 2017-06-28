//
//  ProductDetailController.swift
//  MamasAndPapas
//
//  Created by ALI KIRAN on 6/28/17.
//  Copyright © 2017 ALI KIRAN. All rights reserved.
//

import Foundation
import UIKit
import Vendors
import SwiftyJSON

class ProductDetailController: UITableViewController {
    var slug: String? {
        didSet {
            guard let slug = self.slug else {
                return
            }

            if self.isViewLoaded {
                self.refreshUI()
            }
        }
    }
    
    override func viewDidLoad() {
        refreshUI()
    }
    
    func refreshUI() {
        trace()
    }
    
}
