//
//  CDNProvider.swift
//  MamasAndPapas
//
//  Created by ALI KIRAN on 6/28/17.
//  Copyright © 2017 ALI KIRAN. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import SwiftyJSON

extension UIImageView {
    func setCDNImage(json: JSON) {
        guard let url = json.asCDNURL else {
            image = Asset.imageMissing.image
            return
        }
        
        kf.setImage(with: ImageResource(downloadURL: url), placeholder: nil, options: [.transition(.fade(0.3))], progressBlock: nil) { image, _, _, _ in
            if image == nil {
                self.image = Asset.imageMissing.image
            }
        }
    }
}
