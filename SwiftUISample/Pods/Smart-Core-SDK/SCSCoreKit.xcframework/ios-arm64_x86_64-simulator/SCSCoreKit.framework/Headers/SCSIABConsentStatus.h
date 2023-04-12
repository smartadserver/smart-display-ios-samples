//
//  SCSIABConsentStatus.h
//  SCSCoreKit
//
//  Created by Loïc GIRON DIT METAZ on 21/03/2023.
//  Copyright © 2023 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Defines is a consent is given for a particular purpose.
///
/// Can be invalid if the string is invalid or if the CMP is improperly implemented.
typedef NS_ENUM(NSInteger, SCSIABConsentStatus) {
    
    /// The consent is allowed.
    SCSIABConsentStatusAllowed,
    
    /// The consent is disallowed.
    SCSIABConsentStatusDisallowed,
    
    /// The string is invalid or some shared data are missing: consent in invalid.
    SCSIABConsentStatusInvalid,
    
};

NS_ASSUME_NONNULL_END
