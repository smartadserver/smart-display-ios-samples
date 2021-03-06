//
//  SASReward.h
//  SmartAdServer
//
//  Created by Thomas Geley on 10/11/2016.
//  Copyright © 2018 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 
 Class that represents a reward object collected after an ad event.
 */
@interface SASReward : NSObject

/// The amount of currency to be rewarded.
///
/// Let you know the amount to reward for a given currency.
@property (nonatomic, readonly) NSNumber *amount;

/// The currency of the reward (e.g coins, lives, points…).
///
/// Let you know which currency should be rewarded. Different currencies can lead to different
/// behavior in your app…
@property (nonatomic, readonly) NSString *currency;

/// The secured transaction token associated with the reward. Base64 encoded.
///
/// Decrypt this token with your Private Key (RSA-1024) to ensure the ad was delivered from Smart Ad Server.
/// Return format of the token is: "{uniquetokenprovidedwhenloadingthead}|iid:{deliveredinsertionid}"
/// 
/// Check the documentation: https://documentation.smartadserver.com/DisplaySDK for more information.
@property (nonatomic, readonly, nullable) NSString *securedTransactionToken;

/// The duration of the video ad that has been played to deliver this reward, in seconds. -1 if this duration is unknown.
@property (nonatomic, readonly) NSTimeInterval rewardedVideoDuration;

/**
 Instantiates a new reward using an amount and a currency.
 
 @note The instantiation might fail if the currency's length is equal to 0.
 
 @param amount The amount of currency to be rewarded.
 @param currency The currency of the reward (e.g coins, lives, points…).
 @return The instantiated reward if the parameters are valid, nil otherwise.
 */
- (nullable instancetype)initWithAmount:(NSNumber *)amount currency:(NSString *)currency;

@end

NS_ASSUME_NONNULL_END
