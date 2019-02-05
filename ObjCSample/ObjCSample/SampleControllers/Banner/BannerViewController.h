//
//  BannerViewController.h
//  ObjCSample
//
//  Created by Julien GOMEZ on 16/10/18.
//  Copyright © 2019 Smart AdServer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SASDisplayKit/SASDisplayKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
 The purpose of this view controller is to display a simple banner.
 
 This banner should be clickable and will be inserted in a layout defined in the application's
 storyboard (see Main.storyboard).
 */
@interface BannerViewController : UIViewController <SASBannerViewDelegate>

@end

NS_ASSUME_NONNULL_END
