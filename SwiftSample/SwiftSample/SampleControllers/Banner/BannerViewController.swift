//
//  BannerViewController.swift
//  SwiftSample
//
//  Created by Julien Gomez on 25/10/2018.
//  Copyright © 2019 Smart AdServer. All rights reserved.
//

import UIKit
import SASDisplayKit

/*
 The purpose of this view controller is to display a simple banner.
 
 This banner should be clickable and will be inserted in a layout defined in the application's
 storyboard (see Main.storyboard).
 */
class BannerViewController: UIViewController, SASBannerViewDelegate {
    
	/// Instance of the banner (marked as optional since it is created after the initialization of the controller)
	fileprivate var banner: SASBannerView?
    
	fileprivate var statusBarHidden = false
	
	// MARK: - View controller lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		createBanner()
		createReloadButton()
	}
	
	func createReloadButton() {
        let reloadButton = UIBarButtonItem(title: "Reload", style: .plain, target: self, action: #selector(reload))
        reloadButton.accessibilityLabel = "reloadButton"
		navigationItem.rightBarButtonItem = reloadButton
	}
	
    @objc func reload() {
        if let banner = self.banner {
            banner.refresh()
        }
	}
	
	func createBanner() {
		// The instance of the banner is created with a default frame and an appropriate loader.
        self.banner = SASBannerView(frame: .zero, loader: .activityIndicatorStyleWhite)
		
		if let banner = self.banner {
			// Setting the delegate.
            banner.delegate = self
            
            // Setting the modal parent view controller.
            banner.modalParentViewController = self
			
            // Create a placement
            let adPlacement = SASAdPlacement(siteId: Constants.siteID, pageId: Constants.bannerPageID, formatId: Constants.bannerFormatID)
           
            // You can also use a test placement during development (a placement that will always deliver an ad from a given format).
            // DON'T FORGET TO REVERT TO THE ACTUAL PLACEMENT BEFORE SHIPPING THE APP!
            
            // let adPlacement = SASAdPlacement(testAd: .bannerMRAID)
            // let adPlacement = SASAdPlacement(testAd: .bannerVideoRead)
            // let adPlacement = SASAdPlacement(testAd: .bannerVideoRead360)
            
            // If you are an inventory reseller, you must provide your Supply Chain Object information
            // More info here: https://help.smartadserver.com/s/article/Sellers-json-and-SupplyChain-Object
            // let adPlacement = SASAdPlacement(siteId: Constants.siteID, pageId: Constants.bannerPageID, formatId: Constants.bannerFormatID, keywordTargeting: nil, supplyChainObjectString: "1.0,1!exchange1.com,1234,1,publisher,publisher.com")
                       
			// Loading the ad (using IDs from the Constants class).
			banner.load(with: adPlacement)
			
			// Adding the ad view to the actual view of the controller.
			view.addSubview(banner)
			
            // Setting the banner constraints
            banner.translatesAutoresizingMaskIntoConstraints = false
            banner.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            banner.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            banner.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
            banner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		}
	}
	
	override var prefersStatusBarHidden : Bool {
		let defaultStatusBarStatus = super.prefersStatusBarHidden
		return statusBarHidden || defaultStatusBarStatus
	}
	
	// MARK: - SASAdViewDelegate
	
    func bannerViewDidLoad(_ bannerView: SASBannerView) {
		NSLog("Banner has been loaded")
        // Uncomment this code if you want to adapt the height of the banner to keep the best ratio for the ad
        // For example, if you get a 16/9 video instead of 320x50 classic banner you just need to call optimalAdViewHeightForContainer
        // to get the optimal height of your banner frame
        
        // let height = bannerView.optimalAdViewHeight(forContainer: self.view)
        
        // If you prefer to work with ratio you can directly rely on ratio property
        // let height = self.view.frame.width / bannerView.ratio
        
        // Change banner view frame size
        // bannerView.frame = CGRect(x: bannerView.frame.origin.x, y: bannerView.frame.origin.y, width: bannerView.frame.size.width, height: height)
	}
	
    func bannerView(_ bannerView: SASBannerView, didFailToLoadWithError error: Error) {
		NSLog("Banner has failed to load with error: \(error.localizedDescription)")
	}

}
