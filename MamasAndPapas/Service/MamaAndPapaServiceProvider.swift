//
//  MamaAndPapaServiceProvider.swift
//  MamasAndPapas
//
//  Created by ALI KIRAN on 6/27/17.
//  Copyright © 2017 ALI KIRAN. All rights reserved.
//

import Foundation
import Moya
import Vendors
import SwiftyJSON
import Signals

fileprivate var _searchProvider: MoyaProvider<ProductService>!
class MamaAndPapaServiceProvider {
    class func launch() {
        _searchProvider = newProvider(headers: { [:] }, plugins: [jsonLogger, HudActivityPlugin()])
    }
}

// restrict services use only with controllers
extension UIViewController {
    var searchProvider: MoyaProvider<ProductService>! {
        return _searchProvider
    }
}

struct HitPaginattor {
    var nextPageSignal: Signal<(page: Int, hitsPerPage: Int)> = Signal<(page: Int, hitsPerPage: Int)>()
    var refreshSignal: Signal<(page: Int, hitsPerPage: Int)> = Signal<(page: Int, hitsPerPage: Int)>()
    var hitsUpdatedSignal: Signal<[JSON]> = Signal<[JSON]>()
    var hasUpdatingResults: Bool = false
    var page: Int = -1
    var hitsPerPage: Int = 10
    var hits: [JSON] = []
    
    mutating func prepend(json: JSON) {
        //paginator should expect new items, call refresh method to prepare paginator for new updates
        guard hasUpdatingResults else {
            return
        }
        
        hasUpdatingResults = false
        
        let items = json["hits"].arrayValue
        
        guard let firstItem = items.first, let firstItemId = firstItem["entityId"].int, self.firstItemId != firstItemId else {
            return
        }
        
        self.firstItemId = firstItemId
        
        //todo: implement possible strategy to keep existing hits
        self.page = 0
        self.hits = items
        hitsUpdatedSignal.fire(hits)
    }
    
    var lastItemId: Int = -1
    var firstItemId: Int = -1
    
    mutating func append(json: JSON) {
        //paginator should expect new items, call next method to prepare paginator for new updates
        guard hasUpdatingResults else {
            return
        }
        
        hasUpdatingResults = false
        let items = json["hits"].arrayValue
        
        if hits.count == 0, let firstItem = items.first, let firstItemId = firstItem["entityId"].int {
            self.firstItemId = firstItemId
        }
        
        guard let lastItem = items.last, let lastItemId = lastItem["entityId"].int, self.lastItemId != lastItemId else {
            return
        }
        
        self.hits = self.hits + items
        self.hasUpdatingResults = false
        hitsUpdatedSignal.fire(hits)
    }
    
    mutating func refresh() {
        guard !hasUpdatingResults else {
            return
        }
        
        hasUpdatingResults = true
        refreshSignal.fire((page: 0, hitsPerPage: hitsPerPage))
    }
    
    mutating func next() {
        guard !hasUpdatingResults else {
            return
        }
        
        hasUpdatingResults = true
        page = page + 1
        nextPageSignal.fire((page: page, hitsPerPage: hitsPerPage))
    }
}
