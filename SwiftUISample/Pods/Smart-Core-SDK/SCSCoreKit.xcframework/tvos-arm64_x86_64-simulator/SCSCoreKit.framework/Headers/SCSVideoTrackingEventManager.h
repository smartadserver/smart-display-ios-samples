//
//  SCSVideoTrackingEventManager.h
//  SCSCoreKit
//
//  Created by Loïc GIRON DIT METAZ on 16/05/2017.
//  Copyright © 2017 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SCSCoreKit/SCSTrackingEventManagerProtocol.h>
#import <SCSCoreKit/SCSTrackingEventManager.h>
#import <SCSCoreKit/SCSVideoTrackingEventManagerProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@class SCSURLSession;

/**
 Default SCSVideoTrackingEventManager protocol implementation.
 */
@interface SCSVideoTrackingEventManager : SCSTrackingEventManager <SCSVideoTrackingEventManager>

@end

NS_ASSUME_NONNULL_END
