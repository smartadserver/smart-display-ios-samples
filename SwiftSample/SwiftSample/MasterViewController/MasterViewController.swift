//
//  MasterViewController.swift
//  SwiftSample
//
//  Created by Julien Gomez on 25/10/2018.
//  Copyright © 2019 Smart AdServer. All rights reserved.
//

import UIKit

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


