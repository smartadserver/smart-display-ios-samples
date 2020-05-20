//
//  InterstitialViewController.swift
//  SwiftSample
//
//  Created by Julien Gomez on 25/10/2018.
//  Copyright © 2019 Smart AdServer. All rights reserved.
//

import UIKit
import SASDisplayKit

/*
 The purpose of this view controller is to display a simple interstitial.
 
 This interstitial is now loaded and displayed separately. It automatically covers the whole
 app screen when displayed.
 */
class InterstitialViewController: UIViewController, SASInterstitialManagerDelegate {
	
    fileprivate lazy var interstitialManager: SASInterstitialManager = {
        // Create a placement
        let adPlacement = SASAdPlacement(siteId: Constants.siteID, pageId: Constants.interstitialPageID, formatId: Constants.interstitialFormatID)
        
        // You can also use a test placement during development (a placement that will always deliver an ad from a given format).
        // DON'T FORGET TO REVERT TO THE ACTUAL PLACEMENT BEFORE SHIPPING THE APP!
        
        // let adPlacement = SASAdPlacement(testAd: .interstitialMRAID)
        // let adPlacement = SASAdPlacement(testAd: .interstitialVideo)
        // let adPlacement = SASAdPlacement(testAd: .interstitialVideo360)
        
        // If you are an inventory reseller, you must provide your Supply Chain Object information
        // More info here: https://help.smartadserver.com/s/article/Sellers-json-and-SupplyChain-Object
        // let adPlacement = SASAdPlacement(siteId: Constants.siteID, pageId: Constants.interstitialPageID, formatId: Constants.interstitialFormatID, keywordTargeting: nil, supplyChainObjectString: "1.0,1!exchange1.com,1234,1,publisher,publisher.com")
        
        return SASInterstitialManager(placement: adPlacement, delegate: self)  // Instance of the interstitial manager (marked as optional since it is created after the initialization of the controller)
    }()

    @IBOutlet weak var showInterstitialAdButton: UIButton!
    
    // MARK: - View controller actions
    
    @IBAction func loadInterstitialAd(_ sender: UIButton) {
        // Disable show button during load phase
        self.showInterstitialAdButton.isEnabled = false;
        
        self.interstitialManager.load()
	}
	
    @IBAction func showInterstitialAd(_ sender: UIButton) {
        // Check if interstitial is ready
        if self.interstitialManager.adStatus == .ready {
            self.interstitialManager.show(from: self)
        } else if self.interstitialManager.adStatus == .expired {
            // If not, one of the reason could be that it's expired
            NSLog("Interstitial has expired and cannot be shown anymore.")
        }
    }

	// MARK: - SASInterstitial delegate
	
    func interstitialManager(_ manager: SASInterstitialManager, didLoad ad: SASAd) {
        NSLog("Interstitial has been loaded")
        // Enable show button
        self.showInterstitialAdButton.isEnabled = true;
    }
    
    func interstitialManager(_ manager: SASInterstitialManager, didAppearFrom controller: UIViewController) {
        // Interstial is shown so we disable the show button
        self.showInterstitialAdButton.isEnabled = false;
    }
	
    func interstitialManager(_ manager: SASInterstitialManager, didFailToLoadWithError error: Error) {
        NSLog("Interstitial has failed to load with error: \(error.localizedDescription)")
    }
    
    func interstitialManager(_ manager: SASInterstitialManager, didFailToShowWithError error: Error) {
        NSLog("Interstitial has failed to show with error: \(error.localizedDescription))")
    }

}
