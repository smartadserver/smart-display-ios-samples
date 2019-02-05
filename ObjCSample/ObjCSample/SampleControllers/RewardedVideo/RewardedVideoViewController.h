//
//  RewardedVideoViewController.h
//  ObjCSample
//
//  Created by Julien Gomez on 17/10/2018.
//  Copyright © 2019 Smart AdServer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SASDisplayKit/SASDisplayKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
 The purpose of this view controller is to display a rewarded video.
 
 A rewarded video works like an interstitial but is optimized to display video
 that will yield a reward when watched until the end.
 */
@interface RewardedVideoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *showRewardedVideoAdButton;

@end

NS_ASSUME_NONNULL_END
