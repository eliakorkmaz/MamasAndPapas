//
//  SearchService.swift
//  MamasAndPapas
//
//  Created by ALI KIRAN on 6/27/17.
//  Copyright © 2017 ALI KIRAN. All rights reserved.
//
import Foundation
import Moya
import SwiftyJSON
import UIKit
import Vendors

public enum ProductService {
    case search(searchString: String, page: Int, hitsPerPage: Int)
    case findBy(slug: String)
}

extension ProductService: TargetType {
    public var path: String {
        switch self {
        case let .search(searchString, page, hitsPerPage):
            return "search/full/?searchString=\(searchString)&page=\(page)&hitsPerPage=\(hitsPerPage)"
            
        case let .findBy(slug):
            return "/product/findbyslug/?slug=\(slug)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .search:
            return .post
            
        case .findBy:
            return .get
        }
        
    }
    
    public var parameters: [String: Any]? {
        switch self {
            
        case .search, .findBy:
            return [:]
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        switch self {
        case .search:
            return JSONEncoding.default
            
        case .findBy:
            return URLEncoding.default
        }
    }
    
    public var sampleData: Data {
        switch self {
        case _:
            return Data()
        }
    }
    
    public var task: Task {
        switch self {
        case _:
            return .request
        }
    }
}
