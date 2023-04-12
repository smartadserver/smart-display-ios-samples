//
//  SCSRemoteConfigManagerDelegate.h
//  SCSCoreKit
//
//  Created by Thomas Geley on 27/09/2017.
//  Copyright © 2017 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SCSRemoteConfigManager, SCSRemoteConfig;

/**
 SCSRemoteConfigManager delegate.
 */
@protocol SCSRemoteConfigManagerDelegate <NSObject>

/**
 Called when the remote config manager successfully a remote config.
 
 @param remoteConfigManager The remote config manager instances calling the delegate.
 @param remoteConfig The remote config retrieved by the remote config manager.
 */
- (void)remoteConfigManager:(SCSRemoteConfigManager *)remoteConfigManager didFetchRemoteConfig:(SCSRemoteConfig *)remoteConfig;

/**
 Called when the remote config manager fails to provide a configuration.
 
 @param remoteConfigManager The remote config manager instances calling the delegate.
 @param error The error preventing the remote config to be fetch if any, nil otherwise.
 */
- (void)remoteConfigManager:(nullable SCSRemoteConfigManager *)remoteConfigManager didFailToFetchConfigWithError:(nullable NSError *)error;

@optional

/**
 Called when the remote config manager successfully a remote config. The result is given as dictionaries
 
 @warning This methods can be implemented for compatibility reasons, but `remoteConfigManager:didFetchRemoteConfig`
 should be used for all new implementation.
 
 @param remoteConfigManager The remote config manager instances calling the delegate.
 @param smartDict A dictionary that contains information to configure the main features of the SDKs (like ad calls).
 @param dictionaries A dictionary that contains additional information to configure the SDK (like the logging).
 */
- (void)remoteConfigManager:(nullable SCSRemoteConfigManager *)remoteConfigManager didSucceedToFetchConfigWithSmartDictionary:(NSDictionary *)smartDict additionnalDictionaries:(nullable NSArray <NSDictionary *> *)dictionaries;

@end

NS_ASSUME_NONNULL_END
