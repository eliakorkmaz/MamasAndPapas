//
//  JSON+Product.swift
//  MamasAndPapas
//
//  Created by ALI KIRAN on 6/28/17.
//  Copyright © 2017 ALI KIRAN. All rights reserved.
//

import Foundation
import SwiftyJSON
import Vendors

var AssociatedDescriptionHandle: UInt8 = 0
extension JSON {
    var strippedHTML: String {
        if let descTemp = objc_getAssociatedObject(self.rawValue, &AssociatedDescriptionHandle) as? String {
            return descTemp
        }
        
        let descTemp = self.stringValue.stripHTML()
        objc_setAssociatedObject(self.rawValue, &AssociatedDescriptionHandle, descTemp, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        return descTemp ?? ""
    }
}
