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
import Moya
import SwiftyJSON

class ProductDetailController: UITableViewController {
    @IBOutlet weak var btnMyBag: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cellGallery: ProductDetailGalleryCell!
    @IBOutlet weak var cellInfo: ProductDetailInfoCell!
    @IBOutlet weak var cellSize: ProductDetailSizePickCell!
    
    var detail: JSON = [:] {
        didSet {
            self.cellGallery.items = self.detail["media"].arrayValue
             self.cellSize.prepare()
            self.cellSize.items = self.detail["configurableAttributes"].arrayValue.first?["options"].arrayValue ?? []
        }
    }
    var slug: String? {
        didSet {
            guard self.slug != nil else {
                self.detail = [:]
                return
            }
            
            if self.isViewLoaded {
                self.reload()
            }
        }
    }
    
    override func viewDidLoad() {
        reload()
        navigationController?.view.addSubview(addButton)
        addButton.addLeadingConstraint(toView: addButton.superview, constant: 0)
        addButton.addBottomConstraint(toView: addButton.superview, constant: 0)
        addButton.addTrailingConstraint(toView: addButton.superview, constant: 0)
    }
    
    override func viewWillDisappear(_: Bool) {
        addButton.removeFromSuperview()
    }
    
    func reload() {
        updateAddButton()
        updateBag()
        searchProvider.request(.findBy(slug: slug!)) { [weak self] result in
            guard let `self` = self else {
                return
            }
            
            guard case let .success(response) = result else {
                return
            }
            
            self.detail = response.mapSwiftyJSON()
        }
    }
    
    @IBOutlet weak var lblQuantity: UILabel!
    @IBAction func actionDecreaseQuantity(_: Any) {
        let quantity = lblQuantity.text?.intValue ?? 0
        guard quantity > 0 else {
            return
        }
        lblQuantity.text = "\(quantity - 1)"
        updateAddButton()
    }
    
    @IBAction func actionIncreaseQuantity(_: Any) {
        let quantity = lblQuantity.text?.intValue ?? 0
        
        lblQuantity.text = "\(quantity + 1)"
        self.updateAddButton()
    }
    
    func updateBag() {
        btnMyBag.setTitle("My Bag(\(pickedProducts.count))", for: .normal)
    }
    
    func updateAddButton() {
        let quantity = lblQuantity.text?.intValue ?? 0
        addButton.isEnabled = quantity > 0
        addButton.alpha = addButton.isEnabled ? 1.0 : 0.5
    }
    
    @IBAction func actionAddToBag(_: Any) {
        pickedProducts.append([
            "product": self.detail,
            "quantity": lblQuantity.text!.intValue,
            "size": ""
        ])
        updateBag()
    }
}

var pickedProducts: [JSON] = []

class ProductDetailInfoCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblOldPrice: UILabel!
    @IBOutlet weak var lblId: UILabel!
}
