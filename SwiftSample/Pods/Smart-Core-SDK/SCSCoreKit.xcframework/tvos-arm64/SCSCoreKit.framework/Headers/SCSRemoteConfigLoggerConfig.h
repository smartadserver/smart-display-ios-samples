//
//  SCSRemoteConfigLoggerConfig.h
//  SCSCoreKit
//
//  Created by Loïc GIRON DIT METAZ on 20/02/2023.
//  Copyright © 2023 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SCSCoreKit/SCSRemoteLog.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Model holding all parameters provided by the remote config service related to the remote logger.
 */
@interface SCSRemoteConfigLoggerConfig : NSObject

/// The URL where the remote logs should be posted.
@property (nullable, readonly) NSURL *endPointURL;

/// The minimum log level.
@property (readonly) SCSRemoteLogLevel minimumLogLevel;

/// Sampling rate for Debug Level.
@property (readonly) NSUInteger debugSamplingRate;

/// Sampling rate for Info Level.
@property (readonly) NSUInteger infoSamplingRate;

/// Sampling rate for Warning Level.
@property (readonly) NSUInteger warningSamplingRate;

/// Sampling rate for Error Level.
@property (readonly) NSUInteger errorSamplingRate;

/**
 Initialize a new instance of SCSRemoteConfigLoggerConfig.
 
 @param endPointURL The URL where the remote logs should be posted.
 @param minimumLogLevel The minimum log level.
 @param debugSamplingRate Sampling rate for Debug Level.
 @param infoSamplingRate Sampling rate for Info Level.
 @param warningSamplingRate Sampling rate for Warning Level.
 @param errorSamplingRate Sampling rate for Error Level.
 @return An initialized instance of SCSRemoteConfigLoggerConfig.
 */
- (instancetype)initWithEndPointURL:(nullable NSURL *)endPointURL
                    minimumLogLevel:(SCSRemoteLogLevel)minimumLogLevel
                  debugSamplingRate:(NSUInteger)debugSamplingRate
                   infoSamplingRate:(NSUInteger)infoSamplingRate
                warningSamplingRate:(NSUInteger)warningSamplingRate
                  errorSamplingRate:(NSUInteger)errorSamplingRate NS_DESIGNATED_INITIALIZER;

/**
 Initialize a new instance of SCSRemoteConfigLoggerConfig from a dictionary.
 
 @param dictionary The dictionary which will be used to initialize SCSRemoteConfigLoggerConfig.
 @return An initialized instance of SCSRemoteConfigLoggerConfig.
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
