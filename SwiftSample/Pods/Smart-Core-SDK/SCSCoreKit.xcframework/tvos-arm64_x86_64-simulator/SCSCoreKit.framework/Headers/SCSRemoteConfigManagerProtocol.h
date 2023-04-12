//
//  SCSRemoteConfigManagerProtocol.h
//  SCSCoreKit
//
//  Created by Loïc GIRON DIT METAZ on 22/02/2023.
//  Copyright © 2023 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SCSRemoteConfigManagerDelegate;

/**
 Fetch the SDK configuration from the remote config service.
 */
@protocol SCSRemoteConfigManagerProtocol <NSObject>

/// The delegate of the remote config manager if any, nil otherwise.
@property (nullable, nonatomic, weak) id <SCSRemoteConfigManagerDelegate> delegate;

/**
 Ask the SCSRemoteConfigManager to fetch the configuration for the given siteID.
 
 @note The remote config manager will cache one configuration per site id.
 
 @param siteId The site id associated with this fetch request.
 @param forced Whether or not the SCSRemoteConfigManager should take the expiration into account. YES to ignore expiration.
 */
- (void)fetchRemoteConfigurationWithSiteId:(NSUInteger)siteId
                                    forced:(BOOL)forced;

/**
 Ask the SCSRemoteConfigManager to fetch the configuration.
 
 @warning This method is deprecated because it will use a single cache for all site ids.
 
 @param forced Whether or not the SCSRemoteConfigManager should take the expiration into account. YES to ignore expiration.
 */
- (void)fetchRemoteConfiguration:(BOOL)forced __deprecated_msg("Use 'fetchRemoteConfigurationWithSiteId:forced:' instead");

@end

NS_ASSUME_NONNULL_END
