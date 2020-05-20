//
//  RewardedVideoViewController.swift
//  SwiftSample
//
//  Created by Julien Gomez on 17/10/2018.
//  Copyright © 2019 Smart AdServer. All rights reserved.
//

import UIKit
import SASDisplayKit

/*
 The purpose of this view controller is to display a rewarded video.
 
 A rewarded video works like an interstitial but is optimized to display video
 that will yield a reward when watched until the end.
 */
class RewardedVideoViewController: UIViewController, SASRewardedVideoManagerDelegate {
    
    fileprivate lazy var rewardedVideoManager: SASRewardedVideoManager = {
        // Create a placement
        let adPlacement = SASAdPlacement(siteId: Constants.siteID, pageId: Constants.rewardedVideoPageID, formatId: Constants.rewardedVideoFormatID)
    
        // You can also use a test placement during development (a placement that will always deliver an ad from a given format).
        // DON'T FORGET TO REVERT TO THE ACTUAL PLACEMENT BEFORE SHIPPING THE APP!
    
        // let adPlacement = SASAdPlacement(testAd: .interstitialMRAID)
        // let adPlacement = SASAdPlacement(testAd: .interstitialVideo)
        // let adPlacement = SASAdPlacement(testAd: .interstitialVideo360)
    
        // If you are an inventory reseller, you must provide your Supply Chain Object information
        // More info here: https://help.smartadserver.com/s/article/Sellers-json-and-SupplyChain-Object
        // let adPlacement = SASAdPlacement(siteId: Constants.siteID, pageId: Constants.rewardedVideoPageID, formatId: Constants.rewardedVideoFormatID, keywordTargeting: nil, supplyChainObjectString: "1.0,1!exchange1.com,1234,1,publisher,publisher.com")
        
        return SASRewardedVideoManager(placement: adPlacement, delegate: self)  // Instance of the rewarded video manager (marked as optional since it is created after the initialization of the controller)
    }()

    
    @IBOutlet weak var showRewardedVideoAdButton: UIButton!
   
    // MARK: - View controller actions
    
    @IBAction func loadRewardedVideoAd(_ sender: UIButton) {
        self.rewardedVideoManager.load()
    }
    
    @IBAction func showRewardedVideoAd(_ sender: UIButton) {
        // Check if the rewarded video is ready
        if self.rewardedVideoManager.adStatus == .ready {
            self.rewardedVideoManager.show(from: self)
        } else if self.rewardedVideoManager.adStatus == .expired {
            // If not, one of the reason could be that it's expired
            NSLog("Rewarded video has expired and cannot be shown anymore.")
        }
    }
    
    // MARK: - SASRewardedVideoManagerDelegate methods

    func rewardedVideoManager(_ manager: SASRewardedVideoManager, didLoad ad: SASAd) {
        NSLog("RewardedVideo has been loaded and is ready to be shown");
        self.showRewardedVideoAdButton.isEnabled = true;

    }
    
    func rewardedVideoManager(_ manager: SASRewardedVideoManager, didAppearFrom controller: UIViewController) {
        // Rewarded video is shown so we disable the show button
        self.showRewardedVideoAdButton.isEnabled = false;
    }
    
    func rewardedVideoManager(_ manager: SASRewardedVideoManager, didFailToLoadWithError error: Error) {
        NSLog("RewardedVideo did fail to load with error \(String(describing: error.localizedDescription))")
    }
    
    func rewardedVideoManager(_ manager: SASRewardedVideoManager, didFailToShowWithError error: Error) {
        NSLog("RewardedVideo did fail to show with error \(String(describing: error.localizedDescription))")
    }
    
    func rewardedVideoManager(_ manager: SASRewardedVideoManager, didSend videoEvent: SASVideoEvent) {
        NSLog("RewardedVideo did send video event: \(videoEvent.rawValue)");
    }
    
    func rewardedVideoManager(_ manager: SASRewardedVideoManager, didCollect reward: SASReward) {
        NSLog("Rewarded did collect reward with currency: \(reward.currency) and amount: \(reward.amount)");
        
        //Here you should reward your user with the amount of the given currency.
    }
   
}
