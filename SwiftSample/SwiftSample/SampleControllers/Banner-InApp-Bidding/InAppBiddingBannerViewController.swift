//
//  InAppBiddingBannerViewController.swift
//  SwiftSample
//
//  Created by Loïc GIRON DIT METAZ on 18/10/2019.
//  Copyright © 2019 Smart AdServer. All rights reserved.
//

import UIKit
import SASDisplayKit

/*
 The purpose of this view controller is to make an in-app bidding call to retrieve a banner
 ad, and to display it only if we want to.
 
 In an actual application, displaying the bidding response or not would depend of the bidding
 responses received from other third party SDKs.
 */
class InAppBiddingBannerViewController: UIViewController, SASBiddingManagerDelegate, SASBannerViewDelegate {
    
    /// Instance of the banner.
    fileprivate lazy var banner: SASBannerView = {
        // The instance of the banner is created with a default frame and an appropriate loader.
        SASBannerView(frame: .zero, loader: .activityIndicatorStyleWhite)
    }()
    
    /// The bidding manager will handle all bidding ad calls.
    fileprivate lazy var biddingManager = {
        // Note that you must provide a placement, an ad format type, but also the currency you are using
        SASBiddingManager(adPlacement: SASAdPlacement(siteId: 104808, pageId: 1160279, formatId: 85867, keywordTargeting: "banner-inapp-bidding"),
                          biddingAdFormatType: .banner,
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
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBanner()
        updateUIStatus()
    }
    
    func configureBanner() {
        // Setting the delegate.
        banner.delegate = self
        
        // Setting the modal parent view controller.
        banner.modalParentViewController = self
       
        // Contrary to a simple banner integration, we don't load any ad from placement here:
        // We will load a bidding response in it later, for now we simply hide it…
        banner.isHidden = true
        
        // Adding the ad view to the actual view of the controller.
        view.addSubview(banner)
        
        // Setting the banner constraints
        banner.translatesAutoresizingMaskIntoConstraints = false
        banner.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        banner.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        banner.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        banner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    // MARK: - Bidding manager
    
    @IBAction func loadBiddingAd(_ sender: Any) {
        isBiddingManagerLoading = true
        biddingAdResponse = nil
        
        // Hidding the banner until a ad is actually loaded
        banner.isHidden = true
        
        // Loading a bidding ad response using the bidding manager.
        biddingManager.load()
                
        updateUIStatus()
    }
    
    @IBAction func showBiddingAd(_ sender: Any) {
        if let biddingAdResponse = biddingAdResponse {
            // Showing the banner
            banner.isHidden = false
            
            // We use our banner to display the bidding response retrieved earlier.
            //
            // Note: in an actual application, you would load Smart bidding ad response only if it
            // better than responses you got from other third party SDKs.
            //
            // You can check the CPM associated with the bidding ad response by checking:
            // - biddingAdResponse.biddingAdPrice.cpm
            // - biddingAdResponse.biddingAdPrice.currency
            //
            // If you decide not to use the bidding ad response, you can simply discard it.
            banner.load(biddingAdResponse)
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
    
    // MARK: - SASAdViewDelegate
    
    func bannerViewDidLoad(_ bannerView: SASBannerView) {
        NSLog("Banner has been loaded")
        biddingAdResponse = nil
        updateUIStatus()
    }
    
    func bannerView(_ bannerView: SASBannerView, didFailToLoadWithError error: Error) {
        NSLog("Banner has failed to load with error: \(error.localizedDescription)")
        biddingAdResponse = nil
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

