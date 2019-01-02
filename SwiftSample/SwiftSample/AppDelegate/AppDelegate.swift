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
        // Smart Display SDK will retrieve the consent string from the NSUserDefaults using the
        // official IAB key "IABConsent_ConsentString" as per IAB recommandations.
        /////////////////////////////////////////
        
        // let myConsentString = "yourCMPComputedConsentStringBase64format"
        // UserDefaults.standard.set(myConsentString, forKey: "IABConsent_ConsentString")
        // UserDefaults.standard.synchronize()
        
        // Some third party mediation SDK are not IAB compliant and don't rely on the consent string. Those SDK use
        // most of the time a binary consent for the advertising purpose.
        // If you are using one or more of those SDK through Smart mediation, you can set this binary consent for
        // all adapters at once by setting the string '1' (if the consent is granted) or '0' (if the consent is denied)
        // in NSUserDefault for the key 'Smart_advertisingConsentStatus'.
        // let advertisingBinaryConsentString = "1" or "0"
        // UserDefaults.standard.set(advertisingBinaryConsentString, forKey: "Smart_advertisingConsentStatus")
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

