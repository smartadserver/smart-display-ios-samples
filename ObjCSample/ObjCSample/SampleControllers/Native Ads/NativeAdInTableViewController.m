//
//  NativeAdInTableTableViewController.m
//  ObjCSample
//
//  Created by Julien Gomez on 17/10/2018.
//  Copyright © 2019 Smart AdServer. All rights reserved.
//

#import "NativeAdInTableViewController.h"

#define kNativeAdSiteID                             104808
#define kNativeAdPageID                             720265
#define kNativeAdFormatID                           15140

@implementation NativeAdInTableViewController

- (SASAdPlacement *)adPlacement {
    
    // Creating the ad placement
    SASAdPlacement *placement = [SASAdPlacement adPlacementWithSiteId:kNativeAdSiteID pageId:kNativeAdPageID formatId:kNativeAdFormatID];
    
    // You can also use a test placement during development (a placement that will always deliver an ad from a given format).
    // DON'T FORGET TO REVERT TO THE ACTUAL PLACEMENT BEFORE SHIPPING THE APP!
    
    // SASAdPlacement *placement = [SASAdPlacement adPlacementWithTestAd:SASAdPlacementTestNativeAdTextAssets];
    // SASAdPlacement *placement = [SASAdPlacement adPlacementWithTestAd:SASAdPlacementTestNativeAdIconAndTextAssets];
    // SASAdPlacement *placement = [SASAdPlacement adPlacementWithTestAd:SASAdPlacementTestNativeAdCoverAndTextAssets];
    // SASAdPlacement *placement = [SASAdPlacement adPlacementWithTestAd:SASAdPlacementTestNativeAdIconAndCoverAndTextAssets];
    
    // If you are an inventory reseller, you must provide your Supply Chain Object information
    // More info here: https://help.smartadserver.com/s/article/Sellers-json-and-SupplyChain-Object
    // SASAdPlacement *placement = [SASAdPlacement adPlacementWithSiteId:kNativeAdSiteID pageId:kNativeAdPageID formatId:kNativeAdFormatID keywordTargeting:nil supplyChainObjectString:@"1.0,1!exchange1.com,1234,1,publisher,publisher.com"];
    
    return placement;
}

@end
