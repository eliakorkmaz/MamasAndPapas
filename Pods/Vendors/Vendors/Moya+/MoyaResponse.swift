//
//  MoyaResponse.swift
//  Vendors
//
//  Created by ALI KIRAN on 6/27/17.
//

import Foundation
import Moya
import SwiftyJSON

public extension Moya.Response {
    public func mapSwiftyJSON() -> JSON {
        return JSON(data: data)
    }
    
    public func mapBridgeJSON() -> JSONBridge {
        return JSONBridge(mapSwiftyJSON())
    }
}
