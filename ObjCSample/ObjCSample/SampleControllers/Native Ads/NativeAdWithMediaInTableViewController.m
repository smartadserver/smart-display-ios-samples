//
//  NativeAdWithMediaInTableViewController.m
//  ObjCSample
//
//  Created by Thomas Geley on 11/10/2016.
//  Copyright (c) 2018 Smart AdServer. All rights reserved.
//

#import "NativeAdWithMediaInTableViewController.h"

#define kNativeAdSiteID                             104808
#define kNativeAdWithMediaPageID                    692588
#define kNativeAdFormatID                           15140

@implementation NativeAdWithMediaInTableViewController

- (SASAdPlacement *)adPlacement {
    return [SASAdPlacement adPlacementWithSiteId:kNativeAdSiteID pageId:kNativeAdWithMediaPageID formatId:kNativeAdFormatID];
}

@end
