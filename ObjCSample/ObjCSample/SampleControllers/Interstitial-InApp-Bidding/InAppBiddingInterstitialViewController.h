//
//  InAppBiddingInterstitialViewController.h
//  ObjCSample
//
//  Created by Loïc GIRON DIT METAZ on 28/10/2019.
//  Copyright © 2019 Smart AdServer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SASDisplayKit/SASDisplayKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
 The purpose of this view controller is to make an in-app bidding call to retrieve an interstitial
 ad, and to display it only if we want to.

 In an actual application, displaying the bidding response or not would depend of the bidding
 responses received from other third party SDKs.
 */
@interface InAppBiddingInterstitialViewController : UIViewController <SASInterstitialManagerDelegate, SASBiddingManagerDelegate>

@end

NS_ASSUME_NONNULL_END
