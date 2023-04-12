//
//  SCSVASTPixelManager.h
//  SCSCoreKit
//
//  Created by Loïc GIRON DIT METAZ on 06/08/2019.
//  Copyright © 2019 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SCSCoreKit/SCSVASTPixelManagerProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@class SCSPixelManager;

/**
 Default implementation of SCSVASTPixelManagerProtocol.
 */
@interface SCSVASTPixelManager : NSObject <SCSVASTPixelManagerProtocol>

/**
 Initialize a new instance of SCSVASTPixelManager.
 
 @param pixelManager The pixel manager instance that will be used to call all pixels.
 @return An initialized instance of SCSVASTPixelManager.
 */
- (instancetype)initWithPixelManager:(SCSPixelManager *)pixelManager;

@end

NS_ASSUME_NONNULL_END
