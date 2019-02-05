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
		self.banner = SASBannerView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50), loader: .activityIndicatorStyleWhite)
		
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
            
			// Loading the ad (using IDs from the Constants class).
			banner.load(with: adPlacement)
			
			// Adding the ad view to the actual view of the controller.
			view.addSubview(banner)
			
			// Since this sample is not defining any autolayout constraints but instead use frame and autoresizing masks, this informations must be
			// translated into constraints.
			// Please note that if you deactivate autoresizing translation (and you create your constraints yourself) on the ad view, it will prevent
			// creatives that resize/reposition the view to work (like toaster or resize banners).
			banner.translatesAutoresizingMaskIntoConstraints = true
		}
	}
	
	override var prefersStatusBarHidden : Bool {
		let defaultStatusBarStatus = super.prefersStatusBarHidden
		return statusBarHidden || defaultStatusBarStatus
	}
	
	// MARK: - SASAdViewDelegate
	
    func bannerViewDidLoad(_ bannerView: SASBannerView) {
		NSLog("Banner has been loaded")
	}
	
    func bannerView(_ bannerView: SASBannerView, didFailToLoadWithError error: Error) {
		NSLog("Banner has failed to load with error: \(error.localizedDescription)")
	}

}
