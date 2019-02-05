//
//  NativeAdWithMediaInTableViewController.m
//  ObjCSample
//
//  Created by Thomas Geley on 11/10/2016.
//  Copyright © 2019 Smart AdServer. All rights reserved.
//

#import "NativeAdWithMediaInTableViewController.h"

#define kNativeAdSiteID                             104808
#define kNativeAdWithMediaPageID                    692588
#define kNativeAdFormatID                           15140

@implementation NativeAdWithMediaInTableViewController

- (SASAdPlacement *)adPlacement {
    
    // Creating the ad placement
    SASAdPlacement *placement = [SASAdPlacement adPlacementWithSiteId:kNativeAdSiteID pageId:kNativeAdWithMediaPageID formatId:kNativeAdFormatID];
    
    // You can also use a test placement during development (a placement that will always deliver an ad from a given format).
    // DON'T FORGET TO REVERT TO THE ACTUAL PLACEMENT BEFORE SHIPPING THE APP!
    
    // SASAdPlacement *placement = [SASAdPlacement adPlacementWithTestAd:SASAdPlacementTestNativeAdVideo];
    
    return placement;
}

@end
