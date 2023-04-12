//
//  SCSRemoteConfigSmartConfig.h
//  SCSCoreKit
//
//  Created by Loïc GIRON DIT METAZ on 20/02/2023.
//  Copyright © 2023 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SCSCoreKit/SCSRemoteConfigSmartConfigAdCallParameters.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Model holding all parameters provided by the remote config service related to Smart.
 */
@interface SCSRemoteConfigSmartConfig : NSObject

/// The current network ID.
@property (readonly) NSUInteger networkID;

/// The base URL to be used for ad calls if any, nil otherwise.
@property (readonly) NSURL *adCallBaseURL;

/// The additional parameters that should be sent in each ad calls.
@property (readonly) SCSRemoteConfigSmartConfigAdCallParameters *adCallParameters;

/// The latest SDK version ID available in production if any, nil otherwise.
@property (nullable, readonly) NSString *latestSDKVersionID;

/// The latest SDK update message if any, nil otherwise.
@property (nullable, readonly) NSString *latestSDKMessage;

/**
 Initialize a new instance of SCSRemoteConfigSmartConfig.
 
 @param networkID The current network ID.
 @param adCallBaseURL The base URL to be used for ad calls if any.
 @param adCallParameters The additional parameters that should be sent in each ad calls.
 @param latestSDKVersionID The latest SDK version ID available in production if any, nil otherwise.
 @param latestSDKMessage The latest SDK update message if any, nil otherwise.
 @return An initialized instance of SCSRemoteConfigSmartConfig.
 */
- (instancetype)initWithNetworkID:(NSUInteger)networkID
                    adCallBaseURL:(NSURL *)adCallBaseURL
                 adCallParameters:(SCSRemoteConfigSmartConfigAdCallParameters *)adCallParameters
               latestSDKVersionID:(nullable NSString *)latestSDKVersionID
                 latestSDKMessage:(nullable NSString *)latestSDKMessage NS_DESIGNATED_INITIALIZER;

/**
 Initialize a new instance of SCSRemoteConfigSmartConfig from a dictionary.
 
 @param dictionary The dictionary which will be used to initialize SCSRemoteConfigSmartConfig.
 @return An initialized instance of SCSRemoteConfigSmartConfig.
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
