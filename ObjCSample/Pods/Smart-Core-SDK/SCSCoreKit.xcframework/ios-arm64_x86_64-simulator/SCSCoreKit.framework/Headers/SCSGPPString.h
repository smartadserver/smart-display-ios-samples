//
//  SCSGPPString.h
//  SCSCoreKit
//
//  Created by Julien Gomez on 08/03/2023.
//  Copyright © 2023 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SCSCoreKit/SCSIABConsentStatus.h>
#import <SCSCoreKit/SCSPropertyCacheManager.h>

NS_ASSUME_NONNULL_BEGIN

/// The version of the GPP consent string.
typedef NS_ENUM(NSInteger, SCSGPPStringVersion) {
    
    /// Unknown string version
    SCSGPPStringVersionUnknown = -1,
    
    /// GPP string version 1
    SCSGPPStringVersionOne = 1
    
};

/**
 Class representing a GPP consent string.
 */
@interface SCSGPPString : NSObject

/// The GPP Consent string.
@property (nonatomic, readonly) NSString *GPPString;

/// The GPP Section ID(s) string.
@property (nonatomic, readonly) NSString *GPPSIDString;

/// The GPP Version.
@property (nonatomic, readonly) SCSGPPStringVersion version;

/// YES if the RAW consent string is valid, NO otherwise.
@property (nonatomic, readonly) BOOL isValid;

/**
 Initialize a new instance of the GPP consent string.
 
 @param rawGPPString The RAW consent string that will be handled by the SCSGPPString instance.
 @param rawGPPSIDString The RAW section id(s) string that will be handled by the SCSGPPString instance.
 @param gppVersion The version integer that will be handled by the SCSGPPString instance.

 @return An initialized instance of the GPP consent string.
 */
- (instancetype)initWithGPPString:(NSString *)rawGPPString
                     GPPSIDString:(NSString *)rawGPPSIDString
                       gppVersion:(NSInteger)gppVersion ;

/**
 Initialize a new instance of the GPP consent string.
 
 @param rawGPPString The RAW consent string that will be handled by the SCSGPPString instance.
 @param rawGPPSIDString The RAW section id(s) string that will be handled by the SCSGPPString instance.
 @param gppVersion The version integer that will be handled by the SCSGPPString instance.
 @param propertyCacheManager A property cache manager instance used to retrieve values cached by the app's CMP.

 @return An initialized instance of the GPP consent string.
 */
- (instancetype)initWithGPPString:(NSString *)rawGPPString
                     GPPSIDString:(NSString *)rawGPPSIDString
                       gppVersion:(NSInteger)gppVersion
             propertyCacheManager:(id<SCSPropertyCacheManager>)propertyCacheManager NS_DESIGNATED_INITIALIZER;

/**
 Read from the CMP GPP values whether the IDs can be shared or not.
 
 @return The consent status for the ID sharing.
 */
- (SCSIABConsentStatus)canSendIDs;

/**
 Read from the CMP GPP values whether the geo location special feature opt-in is granted.
 
 @return The consent status for the geo location.
 */
- (SCSIABConsentStatus)canSendLocation;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
