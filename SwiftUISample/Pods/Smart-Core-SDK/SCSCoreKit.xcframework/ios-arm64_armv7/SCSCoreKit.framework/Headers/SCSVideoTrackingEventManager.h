//
//  SCSVideoTrackingEventManager.h
//  SCSCoreKit
//
//  Created by Loïc GIRON DIT METAZ on 16/05/2017.
//  Copyright © 2017 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>
#if TARGET_OS_IOS || (TARGET_OS_IPHONE && !TARGET_OS_TV)
#import <SCSCoreKit/SCSTrackingEvent.h>
#import <SCSCoreKit/SCSVideoTrackingEvent.h>
#import <SCSCoreKit/SCSTrackingEventManager.h>
#elif TARGET_OS_TV
#import <SCSCoreKitTV/SCSTrackingEvent.h>
#import <SCSCoreKitTV/SCSVideoTrackingEvent.h>
#import <SCSCoreKitTV/SCSTrackingEventManager.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class SCSURLSession;

/**
 Helper class to handle a set of video tracking events.
 
 This class inherits from SCSTrackingEventManager but can track automatically events that implements SCSVideoTrackingEvent
 and define a valid event offset.
 */
@interface SCSVideoTrackingEventManager : SCSTrackingEventManager

/**
 Consider an event as 'tracked'.
 
 The URL corresponding to the event will be called (with replaced macros and variables) and the event will be discarded if needed.
 
 @warning Variables must be expressed as 'variablename={temporary_value}' where the only part that will be replaced is surrounded
 by curly brackets.
 
 @param eventType The type of event that has to be tracked.
 @param variables A dictionary of variables that have to be replaced (and the substitution values).
 */
- (void)trackVideoEvent:(SCSVideoTrackingEventType)eventType variables:(NSDictionary<NSString *, NSString *> *)variables;

/**
 Consider an event as 'tracked'.

 The URL corresponding to the event will be called (with replaced macros and variables) and the event will be discarded if needed.

 @warning Variables must be expressed as 'variablename={temporary_value}' where the only part that will be replaced is surrounded
 by curly brackets.

 @param eventType The type of event that has to be tracked.
 @param variables A dictionary of variables that have to be replaced (and the substitution values).
 @param additionalMacros A dictionary of macros that have to be replaced (and the substitution values) alongside the macros provided in the initializer.
*/
- (void)trackVideoEvent:(SCSVideoTrackingEventType)eventType variables:(NSDictionary<NSString *, NSString *> *)variables additionalMacros:(NSDictionary<NSString *, NSString *> *)additionalMacros;

/**
 Warn the event manager that the playback as reach a given time: all relevant events will be considered as tracked automatically.
 
 Note that only events implementing SCSVideoTrackingEvent and returning a valid event offset will be called by this method. They 
 will only be called once no matter the event 'consumable' status.
 
 @warning Variables must be expressed as 'variablename={temporary_value}' where the only part that will be replaced is surrounded
 by curly brackets.
 
 @param timeInterval The current time of the video playback.
 @param variables A dictionary of variables that have to be replaced (and the substitution values).
 */
- (void)playbackProgressedToTime:(NSTimeInterval)timeInterval withVariables:(NSDictionary<NSString *, NSString *> *)variables;

/**
 Warn the event manager that the playback as reach a given time: all relevant events will be considered as tracked automatically.
 
 Note that only events implementing SCSVideoTrackingEvent and returning a valid event offset will be called by this method. They
 will only be called once no matter the event 'consumable' status.
 
 @warning Variables must be expressed as 'variablename={temporary_value}' where the only part that will be replaced is surrounded
 by curly brackets.
 
 @param timeInterval The current time of the video playback.
 @param variables A dictionary of variables that have to be replaced (and the substitution values).
 @param additionalMacros A dictionary of macros that have to be replaced (and the substitution values) alongside the macros provided in the initializer.
 */
- (void)playbackProgressedToTime:(NSTimeInterval)timeInterval withVariables:(NSDictionary<NSString *, NSString *> *)variables additionalMacros:(NSDictionary<NSString *, NSString *> *)additionalMacros;

@end

NS_ASSUME_NONNULL_END
