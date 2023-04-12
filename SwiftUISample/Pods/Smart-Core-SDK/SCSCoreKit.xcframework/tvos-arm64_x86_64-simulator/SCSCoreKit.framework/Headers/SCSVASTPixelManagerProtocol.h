//
//  SCSVASTPixelManagerProtocol.h
//  SCSCoreKit
//
//  Created by Loïc GIRON DIT METAZ on 13/02/2023.
//  Copyright © 2023 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SCSVASTURL;

NS_ASSUME_NONNULL_BEGIN

/**
 Manage VAST related pixels.
 */
@protocol SCSVASTPixelManagerProtocol <NSObject>

/**
 Call an array of error pixels corresponding to a given VAST error.
 
 If pixel URL contain an 'ERRORCODE' macro, this macro will be automatically replaced by
 the VAST error code.
 
 @param pixels An array of VAST URLs.
 @param errorCode The VAST error code.
 */
- (void)callVASTErrorPixels:(NSArray<SCSVASTURL *> *)pixels withErrorCode:(NSInteger)errorCode;

@end

NS_ASSUME_NONNULL_END
