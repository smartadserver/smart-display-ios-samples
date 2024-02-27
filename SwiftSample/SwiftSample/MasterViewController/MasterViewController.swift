//
//  MasterViewController.swift
//  SwiftSample
//
//  Created by Julien Gomez on 25/10/2018.
//  Copyright © 2019 Smart AdServer. All rights reserved.
//

import UIKit
import SASDisplayKit
import AppTrackingTransparency

/*
 This view controller acts as a main menu and redirects the user on the various sample view controllers.
 
 Most of the UI behavior is now in the storyboard (Main.storyboard).
 */
class MasterViewController: UITableViewController {
    
    fileprivate var items: Array<MenuItem> = Array()
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeItems()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Note that requesting for ATT authorization must be made when the application is active (otherwise
        // the ATT popup will not be displayed and the ATT status will stay '.notDetermined').
        // You can for instance perform this request in the 'viewDidAppear' method or register for the
        // 'didBecomeActiveNotification' notification.
        requestTrackingAuthorization()
    }
    
    func requestTrackingAuthorization() {
        // Starting with iOS 14, you must ask the user for consent before being able to track it.
        // If you do not ask consent (or if the user decline), the SDK will not use the device IDFA.
        if #available(iOS 14.0, *) {
            // Check if the tracking authorization status is not determined…
            if ATTrackingManager.trackingAuthorizationStatus == .notDetermined {
                
                // Ask the user for tracking permission.
                //
                // Note:
                // In order to get a good user experience, choose the right time to display this
                // authorization request, and customize the autorization request description in the
                // app Info.plist file.
                ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                    if status == .authorized {
                        NSLog("[ATT] The tracking authorization has been granted by the user!")
                        
                        // The tracking authorization has been granted!
                        // The SDK will be able to use the device IDFA during ad calls.
                    } else {
                        NSLog("[ATT] The tracking authorization is not granted!")
                        
                        // The tracking authorization has not been granted!
                        // The SDK will not track the user.
                    }
                })
                
            }
        }
    }
    
    // MARK: - Items initialization
    
    func initializeItems() {
        addItemInItemsArray("Banner", segueIdentifier: "BannerViewControllerSegue")
        addItemInItemsArray("Banner (in-app bidding)", segueIdentifier: "InAppBiddingBannerViewControllerSegue")
        addItemInItemsArray("Interstitial", segueIdentifier: "InterstitialViewControllerSegue")
        addItemInItemsArray("Interstitial (in-app bidding)", segueIdentifier: "InAppBiddingInterstitialViewControllerSegue")
        addItemInItemsArray("Rewarded Video", segueIdentifier: "RewardedVideoViewControllerSegue")
        addItemInItemsArray("Multiple Banners and Medias in news feed", segueIdentifier: "MultipleBannersViewControllerSegue")
        addItemInItemsArray("Native Ad in news feed", segueIdentifier: "NativeAdInTableViewControllerSegue")
        addItemInItemsArray("Native Ad With Media in news feed", segueIdentifier: "NativeAdWithMediaInTableViewControllerSegue")
        tableView.reloadData()
    }
    
    func addItemInItemsArray(_ title: String, segueIdentifier:String) {
        let item = MenuItem(title: title, segueIdentifier: segueIdentifier)
        items.append(item)
    }
    
    // MARK: - Table view delegate & data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sampleCell") as UITableViewCell?
        cell?.textLabel?.text? = items[(indexPath as NSIndexPath).row].title
        return cell!
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int  {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String {
        return "Choose a sample:";
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String {
        return "\nThis sample demonstrates how to implement the Smart AdServer SDK in Swift application."
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: items[(indexPath as NSIndexPath).row].segueIdentifier, sender: nil)
    }
    
}


