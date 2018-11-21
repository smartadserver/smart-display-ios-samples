//
//  BannerInTableViewController.h
//  ObjCSample
//
//  Created by Julien Gomez on 17/10/2018.
//  Copyright (c) 2018 Smart AdServer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SASDisplayKit/SASDisplayKit.h>
#import "CustomBannerView.h"

NS_ASSUME_NONNULL_BEGIN

/*
 The purpose of this view controller is to display multiple banners in a table view.
 
 Displaying banners with various format and size in a table view that can hide its navigation
 bar can be tricky, this is an example on how it can be done.
 */
@interface BannerInTableViewController : UITableViewController <SASBannerViewDelegate>

@end

NS_ASSUME_NONNULL_END
