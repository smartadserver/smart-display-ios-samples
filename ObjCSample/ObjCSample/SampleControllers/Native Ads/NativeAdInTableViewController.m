//
//  NativeAdInTableTableViewController.m
//  ObjCSample
//
//  Created by Julien Gomez on 17/10/2018.
//  Copyright (c) 2018 Smart AdServer. All rights reserved.
//

#import "NativeAdInTableViewController.h"

#define kNativeAdSiteID                             104808
#define kNativeAdPageID                             720265
#define kNativeAdFormatID                           15140

@implementation NativeAdInTableViewController

- (SASAdPlacement *)adPlacement {
    return [SASAdPlacement adPlacementWithSiteId:kNativeAdSiteID pageId:kNativeAdPageID formatId:kNativeAdFormatID];
}

@end
