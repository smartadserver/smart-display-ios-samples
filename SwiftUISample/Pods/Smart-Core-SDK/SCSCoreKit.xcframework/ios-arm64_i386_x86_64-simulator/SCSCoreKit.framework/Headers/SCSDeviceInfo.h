//
//  SCSDeviceInfo.h
//  SCSCoreKit
//
//  Created by Thomas Geley on 23/03/2017.
//  Copyright © 2017 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>

#define SCS_SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SCS_SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SCS_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SCS_SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SCS_SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@protocol SCSDeviceInfoProviderProtocol;

NS_ASSUME_NONNULL_BEGIN

/// Represents the current tracking authorization status.
///
/// @note This enum shares the same underlying values than the Apple's enum but
/// add a new case for devices that run on iOS 13 and lower.
typedef NS_ENUM(NSInteger, SCSDeviceInfoTrackingAuthorizationStatus) {
    /// Not applicable: the OS is too old to retrieve the authorization status.
    SCSDeviceInfoTrackingAuthorizationStatusNotApplicable = -1,
    
    /// Not determined: the app has not requested for tracking yet.
    SCSDeviceInfoTrackingAuthorizationStatusNotDetermined = 0,
    
    /// Restricted.
    SCSDeviceInfoTrackingAuthorizationStatusRestricted,
    
    /// Denied: the app has been denied to track the user.
    SCSDeviceInfoTrackingAuthorizationStatusDenied,
    
    /// Authorized: the app has been authorized to track the user.
    SCSDeviceInfoTrackingAuthorizationStatusAuthorized
};

/**
 Retrieve some informations about the current device.
 */
@interface SCSDeviceInfo : NSObject

/// The shared instance of the SCSDeviceInfo object.
@property (class, nonatomic, readonly) SCSDeviceInfo *sharedInstance NS_SWIFT_NAME(shared);

/// The platform (model name) of the device.
@property (nonatomic, readonly) NSString *platform;

/// The operating system running on the device.
@property (nonatomic, readonly) NSString *systemVersion;

/// true if the device is considered to have low performances.
@property (nonatomic, readonly) BOOL hasLowPerformances;

/// true if the device can play 360° videos.
@property (nonatomic, readonly) BOOL canPlay360Videos;

/// The user agent of the web view.
@property (nonatomic, readonly) NSString *userAgent;

/// The local IP address of the device (Wi-Fi / en0 interface).
///
/// @warning This property does not give your the public IP address of the device!
@property (nonatomic, readonly) NSString *IPAddress;

/// YES if advertising tracking is enabled in the system settings, NO otherwise.
@property (nonatomic, readonly) BOOL advertisingTrackingEnabled;

/// The current tracking authorization status for the device.
@property (nonatomic, readonly) SCSDeviceInfoTrackingAuthorizationStatus trackingAuthorizationStatus;

/// The device system locale.
@property (nonatomic, readonly) NSString *locale;

/**
 Retrieves device informations from the device info provider passed in parameters.

 @param infoProvider the device informations provider used to retrieve platform, system version and other capabilities.
 */
- (instancetype)initWithInfoProvider:(id <SCSDeviceInfoProviderProtocol>)infoProvider NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
