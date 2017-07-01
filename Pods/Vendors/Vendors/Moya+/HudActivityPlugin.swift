//
//  HudActivityPlugin.swift
//  Vendors
//
//  Created by ALI KIRAN on 6/27/17.
//

import Foundation
import Moya
import Result

/// Notify a request's network activity changes (request begins or ends).
public final class HudActivityPlugin: PluginType {
    public init() {
        
    }
    /// Called by the provider as soon as the request is about to start
    public func willSend(_: RequestType, target _: TargetType) {
        HudManager.instance().show(withTitle: "", status: "", afterDelay: 0.5)
    }
    
    /// Called by the provider as soon as a response arrives, even if the request is cancelled.
    public func didReceive(_: Result<Moya.Response, MoyaError>, target _: TargetType) {
        HudManager.instance().dismiss(afterDelay: 0.5)
    }
}
