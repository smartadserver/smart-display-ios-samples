//
//  SASSecondaryImplementationInfo.h
//  SASDisplayKit
//
//  Created by Loic GIRON DIT METAZ on 25/03/2024.
//  Copyright © 2024 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Additional implementation information that can be provided to the SDK when integrated as secondary SDK.
 */
@interface SASSecondaryImplementationInfo : NSObject

/// Name of the primary SDK calling the Equativ SDK.
@property (readonly) NSString *primarySDKName;

/// Version of the primary SDK calling the Equativ SDK.
@property (readonly) NSString *primarySDKVersion;

/// The mediation adapter version.
@property (readonly) NSString *mediationAdapterVersion;

/**
 Initialize a new instance of SASSecondaryImplementationInfo.
 
 @param primarySDKName Name of the primary SDK calling the Equativ SDK.
 @param primarySDKVersion Version of the primary SDK calling the Equativ SDK.
 @param mediationAdapterVersion The mediation adapter version.
 @return An initialized instance of SASSecondaryImplementationInfo.
 */
- (instancetype)initWithPrimarySDKName:(NSString *)primarySDKName
                     primarySDKVersion:(NSString *)primarySDKVersion
               mediationAdapterVersion:(NSString *)mediationAdapterVersion;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
