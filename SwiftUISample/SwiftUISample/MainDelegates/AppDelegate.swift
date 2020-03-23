//
//  AppDelegate.swift
//  SwiftUISample
//
//  Created by Loïc GIRON DIT METAZ on 02/08/2019.
//  Copyright © 2019 Smart AdServer. All rights reserved.
//

import UIKit
import SASDisplayKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
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
        // SDK - TCF Compliance
        // OPTIONAL
        // By uncommenting the following code, you can set the TCF consent string manually.
        // As per IAB specifications in Transparency And Consent Framework.
        // Smart Display SDK will retrieve the TCF consent string from the NSUserDefaults using the official IAB key "IABTCF_TCString"
        /////////////////////////////////////////
        // If you are using a CMP that is not validated by the IAB or not using the official key:
        // you will have to manually store the computed consent string into the NSUserDefaults for Smart Display SDK to retrieve it and forward it to its partners.
        /////////////////////////////////////////
        // let myTCFConsentString = "yourTCFConsentStringBase64format"
        // UserDefaults.standard.set(myTCFConsentString, forKey: "IABTCF_TCString")
        // UserDefaults.standard.synchronize()
        
        // Some third party mediation SDK are not IAB compliant and don't rely on the TCF consent string. Those SDK use
        // most of the time a binary consent for the advertising purpose.
        // If you are using one or more of those SDK through Smart mediation, you can set this binary consent for
        // all adapters at once by setting the string '1' (if the consent is granted) or '0' (if the consent is denied)
        // in NSUserDefault for the key 'Smart_advertisingConsentStatus'.
        // let advertisingBinaryConsentString = "1" or "0"
        // UserDefaults.standard.set(advertisingBinaryConsentString, forKey: "Smart_advertisingConsentStatus")
        // UserDefaults.standard.synchronize()
        
        /////////////////////////////////////////
        // SDK - CCPA Compliance
        // OPTIONAL
        // By uncommenting the following code, you can set the CCPA consent string manually.
        // As per IAB specifications in CCPA Compliance Framework.
        // Smart Display SDK will retrieve the CCPA consent string from the NSUserDefaults using the official IAB key "IABUSPrivacy_String"
        /////////////////////////////////////////
        // If you are using a CMP that is not validated by the IAB or not using the official key:
        // you will have to manually store the computed consent string into the NSUserDefaults for Smart Display SDK to retrieve it and forward it to its partners.
        /////////////////////////////////////////
        // let myCCPAConsentString = "yourCCPAConsentString";
        // UserDefaults.standard.set(myCCPAConsentString, forKey: "IABUSPrivacy_String")
        // UserDefaults.standard.synchronize()
        
        return true
    }
    
}
