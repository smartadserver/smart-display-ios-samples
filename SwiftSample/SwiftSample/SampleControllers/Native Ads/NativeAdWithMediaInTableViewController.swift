//
//  NativeAdWithMediaInTableViewController.swift
//  SwiftSample
//
//  Created by Julien Gomez on 17/10/2018.
//  Copyright (c) 2018 Smart AdServer. All rights reserved.
//

import UIKit
import SASDisplayKit

/*
 The purpose of this view controller is to display a native ad with media.
 
 Native ads are fetched as an ad object and the app is reponsible to display them. This example shows
 how to display a native ad using a media view.
 
 Most of the code can be found in NativeAdInTableViewController, this class is only used to configure
 the controller differently.
 */
class NativeAdWithMediaInTableViewController: NativeAdInTableViewController {
    
    // You will find the whole native ad implementation in NativeAdViewController
    
    override func currentAdPlacement() -> SASAdPlacement {
        // The config object is used to represent the placement of the banner.
        // The information provided are almost the same than the information you need to provide to a classic display banner,
        // except for the 'master' parameter that does not exist for native ads.
        return SASAdPlacement(siteId: Constants.siteID, pageId: Constants.nativeAdWithMediaInTableViewPageID, formatId: Constants.nativeAdFormatID)
    }
    
    override func updateViewControllerTitle() {
        self.title = "Native Ad with Media";
    }
    
}
