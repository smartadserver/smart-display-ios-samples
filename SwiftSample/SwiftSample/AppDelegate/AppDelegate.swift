//
//  AppDelegate.swift
//  SwiftSample
//
//  Created by Julien Gomez on 25/10/2018.
//  Copyright © 2018 Smart AdServer. All rights reserved.
//

import UIKit
import SASDisplayKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        /////////////////////////////////////////
        // Smart Display SDK Configuration
        /////////////////////////////////////////
        
        // The site ID and the base URL must be set before using the SDK, otherwise no ad will be retrieved.
        SASConfiguration.shared.configure(siteId: Constants.siteID, baseURL: Constants.baseURL)
        
        // Enabling logging can be useful to get informations if ads are not displayed properly.
        // Don't forget to turn logging OFF before submitting to the App Store.
        // SASConfiguration.shared.loggingEnabled = true
        
        
        /////////////////////////////////////////
        // GDPR Consent String - Manual setting
        /////////////////////////////////////////
        // By uncommenting the following code, you can set the GDPR consent string manually.
        // Smart Display SDK will retrieve the consent string from the NSUserDefaults using the official IAB key "IABConsent_ConsentString" as per IAB recommandations.
        // If you are using SmartCMP SDK, this step is not required since SmartCMP already complies with IAB specifications and stores the consent string using the official key.
        // If you are using any other CMP that is not validated by the IAB and not using the official key, you will have to manually store the computed consent string into the NSUserDefaults for Smart Display SDK to retrieve it and pass it to its partners.
        /////////////////////////////////////////
        
        // let myConsentString = "yourCMPComputedConsentStringBase64format"
        // UserDefaults.standard.set(myConsentString, forKey: "IABConsent_ConsentString")
        // UserDefaults.standard.synchronize()
        
        return true
    }

    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        // Activating Live Preview:
        // -> Add the corresponding URL Type in your Info.plist
        // -> Check the documentation for more information about this feature
        
        let sasSchemeWithSiteID = "sas\(Constants.siteID)"
        if sasSchemeWithSiteID == url.scheme {
            return SASConfiguration.shared.handleLivePreviewURL(url)
        }
        
        // Add your own logic here…
        
        return false
    }

}

