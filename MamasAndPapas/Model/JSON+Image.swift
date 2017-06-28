//
//  JSON+Image.swift
//  MamasAndPapas
//
//  Created by ALI KIRAN on 6/28/17.
//  Copyright © 2017 ALI KIRAN. All rights reserved.
//

import Foundation
import SwiftyJSON
import Vendors
extension JSON {
    var asCDNURL: URL? {
        guard let imagePath = self.string else {
            return nil
        }
        
        return URL(string: "\(AppConfig.cdn)\(imagePath)")
    }
}

