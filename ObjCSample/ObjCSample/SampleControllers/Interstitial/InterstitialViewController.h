//
//  InterstitialViewController.h
//  ObjCSample
//
//  Created by Julien Gomez on 17/10/2018.
//  Copyright (c) 2018 Smart AdServer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SASDisplayKit/SASDisplayKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
 The purpose of this view controller is to display a simple interstitial.
 
 This interstitial is now loaded and displayed separately. It automatically covers the whole
 app screen when displayed.
 */
@interface InterstitialViewController : UIViewController <SASInterstitialManagerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *showInterstitialAdButton;

@end

NS_ASSUME_NONNULL_END
