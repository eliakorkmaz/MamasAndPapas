//
//  MahallemConfig.swift
//  MAHALLEMKULLANICI
//
//  Created by ALI KIRAN on 5/24/17.
//  Copyright © 2017 Mahallem Bilgi Teknojileri ve İletişim Ticaret A.Ş. All rights reserved.
//

import Foundation
import Vendors
import Signals
// import Fabric
// import Crashlytics
// import OneSignal

struct AppConfig {
    static let updatedSignal: Signal<Void> = Signal<Void>()
    static var backend: String = ""
    static var socket: String = ""
    static var analytic: String = ""
    static var gmsPlaces: String = ""
    static var onesignal: String = ""
    static var appName: String = ""
    static var cdn: String = ""
    static var forceUpdate: Bool = false
    
    static func launch(with _: [AnyHashable: Any]) {
        loadFromPlist()
        
        moyaSharedDomain.baseURL = URL(string: AppConfig.backend)!
        
        launchGeolocation()
        launchFabric()
        launchAnalytics()
        launchOneSignal()
        launchServices()
        updatedSignal.fire()
    }
    
    static func launchGeolocation() {
        #if DEBUG
            
        #else
        #endif
        
        //        GMSPlacesClient.provideAPIKey(gmsPlaces)
    }
    
    static func launchFabric() {
        #if DEBUG
            //            Fabric.sharedSDK().debug = true
        #else
        #endif
    }
    
    static func launchAnalytics() {
        #if DEBUG
            //            GAI.sharedInstance().logger.logLevel = GAILogLevel.verbose
        #else
        #endif
        
        //        GAI.sharedInstance().defaultTracker = GAI.sharedInstance().tracker(withTrackingId: analytic)
    }
    
    static func launchOneSignal() {
        #if DEBUG
            //            OneSignal.setLogLevel(ONE_S_LOG_LEVEL.LL_DEBUG, visualLevel: ONE_S_LOG_LEVEL.LL_NONE)
        #else
            
        #endif
        
        //        OneSignal.inFocusDisplayType = OSNotificationDisplayType.none
        //        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: true,
        //                                     kOSSettingsKeyInAppLaunchURL: true]
        //
        //        let notificationReceivedBlock: OSHandleNotificationReceivedBlock = { notification in
        //            guard notification != nil else {
        //                return
        //            }
        //        }
        //
        //        let notificationOpenedBlock: OSHandleNotificationActionBlock = { result in
        //            guard let notification = result?.notification else {
        //                return
        //            }
        //
        //            PushManager.handleNotification(notification: notification)
        //        }
        
        //        OneSignal.initWithLaunchOptions(options,
        //                                        appId: onesignal,
        //                                        handleNotificationReceived: notificationReceivedBlock,
        //                                        handleNotificationAction: notificationOpenedBlock,
        //                                        settings: onesignalInitSettings)
    }
    
    static func launchServices() {
        MamaAndPapaServiceProvider.launch()
    }
    
    static func loadFromPlist() {
        var resourceName: String = ""
        
        #if DEBUG
            resourceName = "APP_DEBUG_CONFIG"
        #else
            resourceName = "APP_RELEASE_CONFIG"
        #endif
        
        let path = Bundle.main.path(forResource: resourceName, ofType: "plist")!
        let data: Dictionary<String, Any> = NSDictionary(contentsOfFile: path) as! Dictionary<String, Any>
        socket = data["socket"] as! String
        backend = data["backend"] as! String
        analytic = data["analytic"] as! String
        gmsPlaces = data["gmsPlaces"] as! String
        onesignal = data["onesignal"] as! String
        appName = data["appName"] as! String
        forceUpdate = data["forceUpdate"] as! Bool
        cdn = data["cdn"] as! String
    }
}
