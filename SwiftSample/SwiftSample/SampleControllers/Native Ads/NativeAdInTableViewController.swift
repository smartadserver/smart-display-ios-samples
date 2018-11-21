//
//  NativeAdInTableViewController.swift
//  SwiftSample
//
//  Created by Julien Gomez on 17/10/2018.
//  Copyright (c) 2018 Smart AdServer. All rights reserved.
//

import UIKit
import SASDisplayKit

/*
 The purpose of this view controller is to display a simple native ad.
 
 Native ads are fetched as an ad object and the app is reponsible to display them. This example shows
 how to display a native ad using mostly texts & images assets.
 */
class NativeAdInTableViewController: UITableViewController, SASNativeAdMediaViewDelegate {
    
    fileprivate let DEFAULT_AD_CELL_WITH_MEDIA_HEIGHT: CGFloat = 120.0
    fileprivate let DEFAULT_AD_CELL_WITHOUT_MEDIA_HEIGHT: CGFloat = 80.0
    fileprivate let DEFAULT_CONTENT_CELL_HEIGHT: CGFloat = 80.0
    
    // MARK: - Native Ad Declaration
    
    // The interval between native ads in the table view
    fileprivate let NATIVE_AD_ROW_INDEX = 8
    
    // The native ad object
    var nativeAd: SASNativeAd?
    
    // The native ad manager
    var nativeAdManager: SASNativeAdManager?
    
    // MARK: - View controller lifecycle
    
    deinit {
        // Don't forget to unregister all native ads before leaving the controller or you might encounter some memory leak
        resetAd()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Title
        updateViewControllerTitle()
        
        // Create UI Reload button
        createReloadButton()
        
        // Register UITableViewCell class for placeholder view
        self.tableView.register(UINib(nibName: "NativeAdCell", bundle: nil), forCellReuseIdentifier: "NativeAdCell")
        
        // Load the ad
        reload()
    }
    
    func updateViewControllerTitle() {
        self.title = "Native Ad in news feed";
    }

    @objc func reload() {
        // Reset ad
        resetAd();
        
        // Init ads
        initAd()
        
        // Reload tableView
        self.tableView.reloadData()
    }
    
    
    // MARK: - Ad functions
    
    func resetAd() {
        // Do not forget to unregister your native ad
        if nativeAd != nil {
            nativeAd?.unregisterViews()
            nativeAd = nil
        }
        
        if nativeAdManager != nil {
            nativeAdManager = nil;
        }
    }
    
    func initAd() {
        
        // The ad placement is configured in another view controller (in the same group as this one), depending
        // of the native ad format you have chosen in the main menu.
        let adPlacement = currentAdPlacement()
        
        // Note: Smart AdServer SDK also offers different native ads tests placements for testing purpose
        // DO NOT FORGET TO REMOVE THEM FROM YOUR CODE BEFORE SUBMITTING TO THE APP STORE.
        // let adPlacement = SASAdPlacement(testAd: .nativeAdCoverAndTextAssets)
        // let adPlacement = SASAdPlacement(testAd: .coverAndTextAssets)
        // let adPlacement = SASAdPlacement(testAd: .iconAndCoverAndTextAssets)
        // let adPlacement = SASAdPlacement(testAd: .textAssets)
        // let adPlacement = SASAdPlacement(testAd: .video)
        
        // Init the native ad manager
        self.nativeAdManager = SASNativeAdManager(placement: adPlacement)
    
        // Request Ad
        requestAd()
    }
    
    func currentAdPlacement() -> SASAdPlacement {
        // The config object is used to represent the placement of the banner.
        // The information provided are almost the same than the information you need to provide to a classic display banner,
        // except for the 'master' parameter that does not exist for native ads.
        return SASAdPlacement(siteId: Constants.siteID, pageId: Constants.nativeAdInTableViewPageID, formatId: Constants.nativeAdFormatID)
    }
    
    func requestAd() {
        // A native ad can be requested using the ad manager:
        // the ad call will be asynchronous and the result given in a block
        nativeAdManager?.requestAd({ (ad: SASNativeAd?, error: Error?) in
            
            if let ad = ad {
                // If the ad parameter is defined, it means that a valid native ad as been retrieved
                self.nativeAd = ad
                
                // Reload table view
                self.tableView.reloadData()
            } else {
                self.resetAd()
                if let error = error {
                    // If the calls fails, it is possible to log/print the exact reason of the error
                    NSLog("Unable to load ad: \(error.localizedDescription)")
                }
            }
        })
    }
    
    func cellAtIndexIsAdCell(_ indexPath: IndexPath) -> Bool {
        
        if !isAdLoaded() {
            // false if ad is not loaded
            return false
        } else if (indexPath as NSIndexPath).row == NATIVE_AD_ROW_INDEX {
            return true
        } else {
            return false
        }
        
    }
    
    func isAdLoaded() -> Bool {
        return self.nativeAd != nil;
    }
    
    // MARK: - UI Functions
    
    func createReloadButton() {
        let loadButton = UIBarButtonItem(title: "Reload", style: .plain, target: self, action: #selector(NativeAdInTableViewController.reload))
        navigationItem.rightBarButtonItem = loadButton
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if cellAtIndexIsAdCell(indexPath), let nativeAd = nativeAd {
            // Calculate appropriate height for AdCell
            if nativeAd.hasMedia {
                // With media
                return DEFAULT_AD_CELL_WITH_MEDIA_HEIGHT + nativeAd.optimalMediaViewHeight(forWidth: self.tableView.frame.width)
            } else if let _ = nativeAd.coverImage {
                // With cover
                return DEFAULT_AD_CELL_WITH_MEDIA_HEIGHT + nativeAd.optimalCoverViewHeight(forWidth: self.tableView.frame.width)
            } else {
                // Without any media or cover
                return DEFAULT_AD_CELL_WITHOUT_MEDIA_HEIGHT;
            }
        } else {
            // Default Item Height
            return DEFAULT_CONTENT_CELL_HEIGHT
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Return adCell with Subview
        if cellAtIndexIsAdCell(indexPath) {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "NativeAdCell", for: indexPath) as! NativeAdCell
            
            if let nativeAd = self.nativeAd {
                // Unregister your native to any previous view
                nativeAd.unregisterViews()
                
                // Then register it to the current cell
                nativeAd.register(cell, modalParentViewController:self)
                
                // Displaying native ad text content
                // The call to action button logic does not need to be implemented: click are handled by the SDK automatically
                cell.titleLabel?.text = nativeAd.title
                cell.subtitleLabel?.text = nativeAd.subtitle;
                cell.callToActionButton?.setTitle(nativeAd.callToAction, for: UIControl.State())
                
                // Displaying the icon image if applicable
                if let icon = nativeAd.icon, let iconImageView = cell.iconImageView {
                    cell.setIconViewHidden(false)
                    self.downloadImage(icon.url, forImageView: iconImageView)
                } else {
                    cell.setIconViewHidden(true)
                    cell.iconImageView?.image = nil;
                }
                
                // Displaying the cover image if applicable
                if let coverImage = nativeAd.coverImage, let coverImageView = cell.coverImageView {
                    coverImageView.isHidden = false
                    self.downloadImage(coverImage.url, forImageView: coverImageView)
                } else {
                    cell.coverImageView?.isHidden = true
                    cell.iconImageView?.image = nil;
                }
                
                // Native media can be played automatically using the media view by simply registering it with the native ad.
                // You can't register a native ad to a media view if this native ad isn't already registered to a view!
                if nativeAd.hasMedia {
                    cell.mediaView?.isHidden = false
                    cell.mediaView?.registerNativeAd(nativeAd)
                    cell.mediaView?.delegate = self
                } else {
                    cell.mediaView?.isHidden = true
                }
                
                // If there is neither media nor cover, some constraints must be modified to shrink the cell
                if !nativeAd.hasMedia && nativeAd.coverImage == nil {
                    cell.updateConstraintsWhenCoverAndMediaAreHidden(true)
                } else {
                    cell.updateConstraintsWhenCoverAndMediaAreHidden(false)
                }
                
                // Ad choices button must be registered to the native ad so it can display the right Ad Choices page depending
                // on the provider of the ad (Smart AdServer, third party mediation SDK, …)
                cell.adChoicesButton.register(nativeAd, modalParentViewController: self)
            }
            
            return cell
        } else if indexPath.row == 0 {
            // Configure description cell
            let reuseIdentifier = "DescriptionCell";
            var cell = tableView.dequeueReusableCell(withIdentifier:reuseIdentifier)
            if (cell == nil) {
                cell = UITableViewCell(style: UITableViewCell.CellStyle.default,
                                       reuseIdentifier: reuseIdentifier)
            }
            return cell!
        } else {
            
            // Regular app cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as UITableViewCell
            let index = cell.viewWithTag(1) as! UILabel
            index.text = String(format: "%d", indexPath.row)
            index.layer.masksToBounds = true
            index.layer.cornerRadius = 15
            return cell;
        }
        
    }
    
    // MARK: - TableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - SASNativeAdMediaView Delegate Protocol
    
    func nativeAdMediaViewDidLoadMedia(_ mediaView: SASNativeAdMediaView) {
        NSLog("Native ad media view did load media")
    }
    
    func nativeAdMediaView(_ mediaView: SASNativeAdMediaView, didFailToLoadMediaWithError error: Error) {
        NSLog("Native ad media view failed to load media")
        
        resetAd()
        self.tableView.reloadData()
        initAd()
    }
    
    func nativeAdMediaViewWillPresentFullscreenModalMedia(_ mediaView: SASNativeAdMediaView) {
        NSLog("Native ad media view will present fullscreen modal")
    }
    
    func nativeAdMediaViewDidPresentFullscreenModalMedia(_ mediaView: SASNativeAdMediaView) {
        NSLog("Native ad media view did present fullscreen modal")
    }
    
    func nativeAdMediaViewWillCloseFullscreenModalMedia(_ mediaView: SASNativeAdMediaView) {
        NSLog("Native ad media view will close fullscreen modal")
    }
    
    func nativeAdMediaViewDidCloseFullscreenModalMedia(_ mediaView: SASNativeAdMediaView) {
        NSLog("Native ad media view did close fullscreen modal")
    }
    
    func nativeAdMediaViewShouldHandleAudioSession(_ mediaView: SASNativeAdMediaView) -> Bool {
        return true
    }
    
    func nativeAdMediaViewWillPlayAudio(_ mediaView: SASNativeAdMediaView) {
        NSLog("Native ad media view will play audio")
    }
    
    func nativeAdMediaViewDidFinishPlayingAudio(_ mediaView: SASNativeAdMediaView) {
        NSLog("Native ad media view finished playing audio")
    }
    
    func nativeAdMediaView(_ mediaView: SASNativeAdMediaView, didSend videoEvent: SASVideoEvent) {
        // This delegate can be used to listen for video events.
        
        // For instance, you can use these events to check if the video has been played until the end
        // by listening to the event 'SASVideoEvent.Complete'
        if videoEvent == .complete {
            NSLog("The media has been played until the end")
        }
    }
    
    // MARK: - Helper Methods
    
    func downloadImage(_ imageURL: URL, forImageView imageView: UIImageView) {
        imageView.image = nil
        
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: imageURL), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageView.image = image
                    imageView.setNeedsLayout()
                }
            }
        }
    }
    
}
