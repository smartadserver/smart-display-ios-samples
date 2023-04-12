//
//  SCSRemoteConfig.h
//  SCSCoreKit
//
//  Created by Loïc GIRON DIT METAZ on 20/02/2023.
//  Copyright © 2023 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SCSCoreKit/SCSRemoteConfigLoggerConfig.h>
#import <SCSCoreKit/SCSRemoteConfigSmartConfig.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Model holding all parameters provided by the remote config service.
 */
@interface SCSRemoteConfig : NSObject

/// The TTL before remote configuration expiration.
@property (readonly) NSTimeInterval TTL;

/// The remote logger configuration.
@property (readonly) SCSRemoteConfigLoggerConfig *loggerConfig;

/// The configuration of the Smart SDK.
@property (readonly) SCSRemoteConfigSmartConfig *smartConfig;

/// The status of the remote config refresh.
@property (readonly) NSInteger statusCode;

/// The version of the remote config service.
@property (nullable, readonly) NSString *version;

/**
 Initialize a new instance of SCSRemoteConfig.
 
 @param TTL The TTL before remote configuration expiration.
 @param loggerConfig The remote logger configuration.
 @param smartConfig The configuration of the Smart SDK.
 @param statusCode The status of the remote config refresh.
 @param version The version of the remote config service.
 @return An initialized instance of SCSRemoteConfig.
 */
- (instancetype)initWithTTL:(NSTimeInterval)TTL
               loggerConfig:(SCSRemoteConfigLoggerConfig *)loggerConfig
                smartConfig:(SCSRemoteConfigSmartConfig *)smartConfig
                 statusCode:(NSInteger)statusCode
                    version:(nullable NSString *)version NS_DESIGNATED_INITIALIZER;

/**
 Initialize a new instance of SCSRemoteConfig from a dictionary.
 
 @note This method will return nil if the dictionary does not contains required information like the
 TTL or the smartConfig sub dictionary.
 
 @param dictionary The dictionary which will be used to initialize SCSRemoteConfig if possible, nil otherwise.
 @return An initialized instance of SCSRemoteConfig.
 */
- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
