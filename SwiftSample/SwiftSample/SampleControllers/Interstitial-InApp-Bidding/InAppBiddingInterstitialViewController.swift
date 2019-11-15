//
//  InAppBiddingInterstitialViewController.swift
//  SwiftSample
//
//  Created by Loïc GIRON DIT METAZ on 22/10/2019.
//  Copyright © 2019 Smart AdServer. All rights reserved.
//

import UIKit
import SASDisplayKit

/*
 The purpose of this view controller is to make an in-app bidding call to retrieve an interstitial
 ad, and to display it only if we want to.

 In an actual application, displaying the bidding response or not would depend of the bidding
 responses received from other third party SDKs.
 */
class InAppBiddingInterstitialViewController: UIViewController, SASBiddingManagerDelegate, SASInterstitialManagerDelegate {
    
    /// The interstitial manager used to display the current interstitial if any.
    ///
    /// Note: contrary to the regular integration where an unique interstitial manager is created (associated to a placement) and
    /// reused, in-app bidding integration requires to use a different interstitial manager for each call.
    /// That is why we do not initialize it now and we declare it as variable.
    var interstitialManager: SASInterstitialManager?
    
    /// The bidding manager will handle all bidding ad calls.
    fileprivate lazy var biddingManager = {
        // Note that you must provide a placement, an ad format type, but also the currency you are using
        SASBiddingManager(adPlacement: SASAdPlacement(siteId: 104808, pageId: 1160279, formatId: 85867, keywordTargeting: "interstitial-inapp-bidding"),
                          biddingAdFormatType: .interstitial,
                          currency: "USD",
                          delegate: self)
    }()
    
    /// Current bidding ad response if any.
    fileprivate var biddingAdResponse: SASBiddingAdResponse?
    
    /// Flag to check if the bidding manager is currently loading.
    fileprivate var isBiddingManagerLoading: Bool = false
    
    @IBOutlet weak var loadButton: UIButton!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    // MARK: - Bidding manager
    
    @IBAction func loadBiddingAd(_ sender: Any) {
        isBiddingManagerLoading = true
        biddingAdResponse = nil
        
        // Loading a bidding ad response using the bidding manager.
        biddingManager.load()
                
        updateUIStatus()
    }
    
    @IBAction func showBiddingAd(_ sender: Any) {
        if let biddingAdResponse = biddingAdResponse {
            // We use an interstitial manager to display the bidding response retrieved earlier.
            //
            // Note: in an actual application, you would load Smart bidding ad response only if it
            // better than responses you got from other third party SDKs.
            //
            // You can check the CPM associated with the bidding ad response by checking:
            // - biddingAdResponse.biddingAdPrice.cpm
            // - biddingAdResponse.biddingAdPrice.currency
            //
            // If you decide not to use the bidding ad response, you can simply discard it.
            interstitialManager = SASInterstitialManager(biddingAdResponse: biddingAdResponse, delegate: self)
            interstitialManager?.load()
        }
        
        updateUIStatus()
    }
    
    fileprivate func hasValidBiddingAdResponse() -> Bool {
        if let biddingAdResponse = biddingAdResponse {
            // A bidding ad response is valid only if it has not been consumed already
            return !biddingAdResponse.isConsumed
        } else {
            return false
        }
    }
    
    // MARK: - SASBiddingManagerDelegate
    
    func biddingManager(_ biddingManager: SASBiddingManager, didLoad biddingAdResponse: SASBiddingAdResponse) {
        isBiddingManagerLoading = false
        self.biddingAdResponse = biddingAdResponse
        
        // A bidding ad response has been received.
        // You can now load it into an ad view or discard it. See showBiddingAd(_:) for more info.
        
        NSLog("A bidding ad response has been loaded: \(biddingAdResponse)")
        updateUIStatus()
    }
    
    func biddingManager(_ biddingManager: SASBiddingManager, didFailToLoadWithError error: Error) {
        isBiddingManagerLoading = false
        biddingAdResponse = nil
        
        NSLog("Failed to load bidding ad reponse with error: \(error)")
        updateUIStatus()
    }

    // MARK: - SASInterstitialDelegate
    
    func interstitialManager(_ manager: SASInterstitialManager, didLoad ad: SASAd) {
        biddingAdResponse = nil
        
        // In this sample, we display the interstitial as soon as it is loaded.
        // But it is possible to display it later, like on regular integrations.
        interstitialManager?.show(from: self)
        
        NSLog("Interstitial has been loaded")
        updateUIStatus()
    }
    
    func interstitialManager(_ manager: SASInterstitialManager, didFailToLoadWithError error: Error) {
        biddingAdResponse = nil
        
        NSLog("Interstitial has failed to load with error: \(error.localizedDescription)")
        updateUIStatus()
    }
    
    func interstitialManager(_ manager: SASInterstitialManager, didAppearFrom controller: UIViewController) {
        NSLog("Interstitial did appear")
        updateUIStatus()
    }
    
    func interstitialManager(_ manager: SASInterstitialManager, didFailToShowWithError error: Error) {
        NSLog("Interstitial has failed to show with error: \(error.localizedDescription))")
        updateUIStatus()
    }
    
    // MARK: - Utils
    
    fileprivate func updateUIStatus() {
        // Buttons
        loadButton.isEnabled = !isBiddingManagerLoading
        showButton.isEnabled = hasValidBiddingAdResponse()
        
        // Status label
        if isBiddingManagerLoading {
            statusLabel.text = "loading a bidding ad…"
        } else if let biddingAdPrice = biddingAdResponse?.biddingAdPrice {
            statusLabel.text = "bidding response: \(String(format: "%.6f", biddingAdPrice.cpm)) \(biddingAdPrice.currency)"
        } else {
            statusLabel.text = "(no bidding ad response loaded)"
        }
    }
    
}
