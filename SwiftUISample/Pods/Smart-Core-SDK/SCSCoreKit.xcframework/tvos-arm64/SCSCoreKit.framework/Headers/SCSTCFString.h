//
//  SCSTCFString.h
//  SCSCoreKit
//
//  Created by glaubier on 03/02/2020.
//  Copyright © 2020 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SCSCoreKit/SCSIABConsentStatus.h>
#import <SCSCoreKit/SCSPropertyCacheManager.h>

NS_ASSUME_NONNULL_BEGIN

/// The version of the IAB TCF consent string.
typedef NS_ENUM(NSInteger, SCSTCFStringTCFVersion) {
    
    /// Unknown string version
    SCSTCFStringTCFVersionUnknown = -1,
    
    /// TCF string version 1
    SCSTCFStringTCFVersionOne = 1,
    
    /// TCF string version 2
    SCSTCFStringTCFVersionTwo = 2
    
};

/**
 Class representing a IAB TCF consent string.
 */
@interface SCSTCFString : NSObject

/// The consent string. It will be URL encoded or empty if invalid.
@property (nonatomic, readonly) NSString *TCFString;

/// YES if the RAW consent string is valid, NO otherwise.
@property (nonatomic, readonly) BOOL isValid;

/// The version of the TCF consent string.
@property (nonatomic, readonly) SCSTCFStringTCFVersion version;

/**
 Initialize a new instance of the TCF consent string.
 
 @param rawTCFString The RAW consent string that will be handled by the SCSTCFString instance.
 @return An initialized instance of the TCF consent string.
 */
- (instancetype)initWithTCFString:(NSString *)rawTCFString;

/**
 Initialize a new instance of the TCF consent string.
 
 @param rawTCFString The RAW consent string that will be handled by the SCSTCFString instance.
 @param isComingFromGPP YES if the string has been allocated as part of a GPP string, NO if the string is standalone.
 @return An initialized instance of the TCF consent string.
 */
- (instancetype)initWithTCFString:(NSString *)rawTCFString
                  isComingFromGPP:(BOOL)isComingFromGPP;

/**
 Initialize a new instance of the TCF consent string.
 
 @param rawTCFString The RAW consent string that will be handled by the SCSTCFString instance.
 @param isComingFromGPP YES if the string has been allocated as part of a GPP string, NO if the string is standalone.
 @param propertyCacheManager A property cache manager instance used to retrieve values cached by the app's CMP.
 @return An initialized instance of the TCF consent string.
 */
- (instancetype)initWithTCFString:(NSString *)rawTCFString
                  isComingFromGPP:(BOOL)isComingFromGPP
             propertyCacheManager:(id<SCSPropertyCacheManager>)propertyCacheManager NS_DESIGNATED_INITIALIZER;

/**
 Read from the CMP TCF Values whether we can share the IDs or not.
 
 @return The consent status for the ID sharing.
 */
- (SCSIABConsentStatus)canSendIDs;

/**
 Read from the CMP TCF values whether the geo location special feature opt-in is granted.
 
 @return The consent status for the geo location.
 */
- (SCSIABConsentStatus)canSendLocation;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
