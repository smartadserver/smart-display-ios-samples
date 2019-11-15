//
//  BannerInTableViewController.swift
//  SwiftSample
//
//  Created by Julien Gomez on 17/10/2018.
//  Copyright © 2019 Smart AdServer. All rights reserved.
//

import AVFoundation
import UIKit
import SASDisplayKit

/*
 The purpose of this view controller is to display multiple banners in a table view.
 
 Displaying banners with various format and size in a table view that can hide its navigation
 bar can be tricky, this is an example on how it can be done.
 */
class BannerInTableViewController: UITableViewController, SASBannerViewDelegate {
    
    fileprivate let banner1Row = 6
    fileprivate let banner2Row = 12
    fileprivate let banner3Row = 18
    fileprivate let numberOfCells = 40
    
    fileprivate let defaultCellHeight: CGFloat = 80.0
    
    // Instances of banners (marked as optional since it is created after the initialization of the controller)
    fileprivate var banner1: SASBannerView?
    fileprivate var banner2: SASBannerView?
    fileprivate var banner3: SASBannerView?
    
    fileprivate var statusBarHidden = false
    
    fileprivate var stickyAdView: UIView?
    fileprivate var navigationBarTopOffset: CGFloat = 0.0
    
    fileprivate var isObserverRegistered: Bool = false
    
    // MARK: - View controller lifecycle
    
    deinit {
        removeBanners()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(BannerInTableViewController.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        self.refreshControl = refreshControl
        
        createBanners()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let navigationController = self.navigationController {
            // Hide navigation bar on swipe gesture
            navigationController.hidesBarsOnSwipe = true
            // Add observer for hidden state changed
            navigationController.navigationBar.addObserver(self, forKeyPath: "hidden", options: [], context: nil)
            isObserverRegistered = true
            // Get initial top offset of the navigation bar
            navigationBarTopOffset = navigationController.navigationBar.frame.origin.y;
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let navigationController = self.navigationController {
            navigationController.hidesBarsOnSwipe = false
            navigationController.setNavigationBarHidden(false, animated: true)
            if isObserverRegistered == true {
                navigationController.navigationBar.removeObserver(self, forKeyPath: "hidden")
                isObserverRegistered = false
            }
        }
    }
    
    override var prefersStatusBarHidden : Bool {
        // The status bar can be hidden by an ad (for instance when the ad is expanded in fullscreen)
        return statusBarHidden || super.prefersStatusBarHidden
    }
    
    // MARK: - Ad management
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.banner1?.refresh()
        self.banner2?.refresh()
        self.banner3?.refresh()
        self.refreshControl?.endRefreshing()
    }
    
    func createBanners() {
        self.banner1 = createBanner(Constants.banner1InTableViewPageID)
        self.banner2 = createBanner(Constants.banner2InTableViewPageID)
        self.banner3 = createBanner(Constants.banner3InTableViewPageID)
    }
    
    func removeBanners() {
        removeBanner(self.banner1)
        removeBanner(self.banner2)
        removeBanner(self.banner3)
    }
    
    func createBanner(_ pageId: Int) -> SASBannerView {
        // The instance of the banner is created with a default frame and an appropriate loader.
        let banner = SASBannerView(frame: bannerFrameForView(self.view, height: defaultCellHeight), loader: .activityIndicatorStyleWhite)
        
        // Setting the delegate.
        banner.delegate = self
        
        // Setting the modal parent view controller.
        banner.modalParentViewController = self
        
        // Loading the ad (using IDs from the Constants class).
        banner.load(with: SASAdPlacement(siteId: Constants.siteID, pageId: pageId, formatId: Constants.bannerFormatID))
        
        return banner
    }
    
    func removeBanner(_ banner: SASBannerView?) {
        if (banner != nil) {
            banner?.modalParentViewController = nil
            banner?.delegate = nil
            banner?.removeFromSuperview()
        }
    }
    
    func bannerFrameForView(_ view: UIView, height: CGFloat) -> CGRect {
        // Convenient method to reset the frame of a banner
        return CGRect(x: 0, y: 0, width: view.frame.width, height: height)
    }
    
    // MARK: - Table View data source & delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = defaultCellHeight
        
        // If the cell is an ad cell, the actual cell height can be computed easily using the optimalAdViewHeightForContainer: method
        if (indexPath as NSIndexPath).row == banner1Row, let banner1Height = banner1?.optimalAdViewHeight(forContainer: tableView) {
            height = banner1Height
        } else if (indexPath as NSIndexPath).row == banner2Row, let banner2Height = banner2?.optimalAdViewHeight(forContainer: tableView) {
            height = banner2Height
        } else if (indexPath as NSIndexPath).row == banner3Row, let banner3Height = banner3?.optimalAdViewHeight(forContainer: tableView) {
            height = banner3Height
        }
        
        return height
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isAdCell(indexPath) {
            // Attach relevant banner to the container cell
            switch ((indexPath as NSIndexPath).row) {
            case banner1Row:
                return SASAdViewContainerCell(for: banner1!, in: tableView)
            case banner2Row:
                return SASAdViewContainerCell(for: banner2!, in: tableView)
            case banner3Row:
                return SASAdViewContainerCell(for: banner3!, in: tableView)
            default:
                NSLog("Error: cell should not be an AdCell")
                return tableView.dequeueReusableCell(withIdentifier: "ContentCell")!
            }
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
            // Configure regular cells
            let reuseIdentifier = "ContentCell";
            var cell = tableView.dequeueReusableCell(withIdentifier:reuseIdentifier)
            if (cell == nil) {
                cell = UITableViewCell(style: UITableViewCell.CellStyle.default,
                                       reuseIdentifier: reuseIdentifier)
            }
            let index:UILabel = cell?.viewWithTag(1) as! UILabel
            index.text = String(format: "%d", indexPath.row)
            index.layer.masksToBounds = true
            index.layer.cornerRadius = 15
            cell?.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            return cell!
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Deselect the cell if it's an ad to avoid messing with the ad creative.
        if (indexPath as NSIndexPath).row == banner1Row || banner2Row == (indexPath as NSIndexPath).row || banner3Row == (indexPath as NSIndexPath).row {
            //Ad Cell was selected, nothing to do here.
        } else {
            //Your normal behavior on cell click like pushing a new VC
            pushViewController()
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func pushViewController() {
        let controller = UIViewController()
        controller.navigationItem.title = "Details"
        controller.view.backgroundColor = view.backgroundColor
        let label = UILabel(frame: controller.view.bounds)
        label.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        label.textAlignment = NSTextAlignment.center
        label.text = "Detail view controller"
        controller.view.addSubview(label)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func isAdCell(_ indexPath: IndexPath) -> Bool {
        // In this sample, ad cells are in fixed positions
        return (indexPath as NSIndexPath).row == banner1Row || (indexPath as NSIndexPath).row == banner2Row || banner3Row == (indexPath as NSIndexPath).row
    }
    
    func refreshAdCell(_ bannerView: SASBannerView?) {
        // Refresh the ad cell (or the whole table view if no ad cell is given in parameter)
        if bannerView == banner1 {
            tableView.reloadRows(at: [IndexPath(row: banner1Row, section: 0)], with: .automatic)
        } else if bannerView == banner2 {
            tableView.reloadRows(at: [IndexPath(row: banner2Row, section: 0)], with: .automatic)
        } else if bannerView == banner3 {
            tableView.reloadRows(at: [IndexPath(row: banner3Row, section: 0)], with: .automatic)
        } else {
            tableView.reloadData()
        }
    }
    
    // MARK: - Observe navigation bar hidden state to animate sticky view if needed
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "hidden" && stickyAdView != nil {
            if let navigationBar = self.navigationController?.navigationBar {
                if navigationBar.isHidden == false {
                    UIView.animate(withDuration: 0.3) {
                        if var newFrame = self.stickyAdView?.frame {
                            newFrame.origin.y = self.navigationBarTopOffset + navigationBar.frame.height
                            self.stickyAdView?.frame = newFrame
                        }
                    }
                } else {
                    UIView.animate(withDuration: 0.3) {
                        if var newFrame = self.stickyAdView?.frame {
                            newFrame.origin.y = self.navigationBarTopOffset
                            self.stickyAdView?.frame = newFrame
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - SASBannerView delegate
    
    func bannerView(_ bannerView: SASBannerView, didDownloadAd ad: SASAd) {
        NSLog("An ad object has been loaded")
        
        // Refresh the table view when an ad is loaded
        refreshAdCell(bannerView)
    }
    
    func bannerViewDidLoad(_ bannerView: SASBannerView) {
        NSLog("Banner has been loaded")
    }
    
    func bannerView(_ bannerView: SASBannerView, didFailToLoadWithError error: Error) {
        NSLog("Banner has failed to load with error: \(error.localizedDescription)")
    }
    
    func bannerView(_ bannerView: SASBannerView, didSend videoEvent: SASVideoEvent) {
        // This delegate can be used to listen for events if the ad is a video.
        
        // For instance, you can use these events to check if the video has been played until the end
        // by listening to the event 'SASVideoEvent.Complete'
        if videoEvent == .complete {
            NSLog("The video has been played until the end")
        }
    }
    
    func bannerView(_ bannerView: SASBannerView, withStickyView stickyView: UIView, didStick stuck: Bool, withFrame stickyFrame: CGRect) {
        // This delegate can be used to be notified when a video read banner did stick or unstick, in this implementation as the navigation bar appears / disappears during vertical swipe we need to animate the sticky view
        
        if stuck {
            // keep a reference to the view to animate it if necessary
            self.stickyAdView = stickyView
        } else {
            self.stickyAdView = nil
        }
    }
    
}
