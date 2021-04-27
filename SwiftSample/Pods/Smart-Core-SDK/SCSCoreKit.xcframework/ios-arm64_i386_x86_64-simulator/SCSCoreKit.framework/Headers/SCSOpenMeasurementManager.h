//
//  SCSOpenMeasurementManager.h
//  SCSCoreKit
//
//  Created by Loïc GIRON DIT METAZ on 15/01/2019.
//  Copyright © 2019 Smart AdServer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SCSCoreKit/SCSOpenMeasurementJSLibrary.h>
#import <SCSCoreKit/SCSOpenMeasurementManagerProvider.h>
#import <SCSCoreKit/SCSOpenMeasurementAdSession.h>
#import <SCSCoreKit/SCSOpenMeasurementAdVerificationScript.h>
#import <SCSCoreKit/SCSOpenMeasurementRemoteLoggerProtocol.h>
#import <SCSCoreKit/SCSPixelManager.h>
#import <SCSCoreKit/SCSVASTAdVerification.h>

// The OM JS Library should be inserted in the HTML header if any.
#define kSCSForceEndOfHTMLInjection NO

NS_ASSUME_NONNULL_BEGIN

/**
 Handles the Open Measurement SDK.
 
 This class does not call any third party API directly and rely instead on an abstract
 provider for easier third party library deactivation if needed.
 */
@interface SCSOpenMeasurementManager : NSObject

/// YES if the open measurement manager has fetched the OM JS library, NO otherwise.
///
/// @note Some features of the open measurement manager might still work when isReady is NO.
@property (nonatomic, readonly) BOOL isReady;

/**
 Initialize a new instance of SCSOpenMeasurementManager.
 
 @param provider An object implementing the SCSOpenMeasurementManagerProvider protocol.
 @param remoteLogger A object implementing the SCSOpenMeasurementRemoteLoggerProtocol protocol if remote logging should be supported, nil otherwise.
 @param pixelManager The pixel manager instance that will be used to send tracking pixels related to verification scripts.
 @return An initialized instance of SCSOpenMeasurementManager
 */
- (instancetype)initWithProvider:(id<SCSOpenMeasurementManagerProvider>)provider jsLibrary:(SCSOpenMeasurementJSLibrary *)jsLibrary remoteLogger:(nullable id<SCSOpenMeasurementRemoteLoggerProtocol>)remoteLogger pixelManager:(SCSPixelManager *)pixelManager;

#pragma mark - Native implementations

/**
 Return a new session for a given native view.
 
 @param view The view that should be used to create the session.
 @param scripts An array of scripts that will be executed by the session.
 @param isVideo YES if the tracked ad is a video, NO otherwise.
 @return A new session for the given view if successful, nil otherwise.
 */
- (nullable id<SCSOpenMeasurementAdSession>)sessionWithView:(UIView *)view isVideo:(BOOL)isVideo scripts:(NSArray<SCSOpenMeasurementAdVerificationScript *> *)scripts;

#pragma mark - Web implementations

/**
 Return a new session for a given web view.
 
 @param wkWebView The web view that should be used to create the session.
 @param isImpressionPixelInAdMarkup Whether there is an impression pixel in the admarkup or not.
 @return A new session for the given web view if successful, nil otherwise.
 */
- (nullable id<SCSOpenMeasurementAdSession>)sessionWithWebView:(WKWebView *)wkWebView isImpressionPixelInAdMarkup:(BOOL)isImpressionPixelInAdMarkup;

/**
 Inject the Open Measurement SDK JS library into an HTML script.
 
 The place where the actual injection will take place depends of the HTML itself and the
 value of the kSCSForceEndOfHTMLInjection constant.
 
 @param html The HTML script.
 @return A copy of the HTML script in which the Open Measurement SDK JS library has been added.
 */
- (NSString *)injectLibraryIntoHTML:(NSString *)html;

/**
 Inject the Open Measurement SDK JS library into an HTML script.
 
 @param html The HTML script.
 @param forceEndOfHTMLInjection YES to force the JS library insertion to be done at the end of the HTML file, NO to attempt the insertion in the header instead.
 @return A copy of the HTML script in which the Open Measurement SDK JS library has been added.
 */
- (NSString *)injectLibraryIntoHTML:(NSString *)html forceEndOfHTMLInjection:(BOOL)forceEndOfHTMLInjection;

#pragma mark - Utils

/**
 Download or refresh the OM JS library.
 
 @note This method will not do anything if a refresh is still pending.
 */
- (void)refreshJSLibrary;

/**
 Convert an ad verifications array into an array of validation scripts.

 @param adVerifications An array of ad verifications if any, nil otherwise.
 @return An array of validation scripts (empty if no valid scripts are found).
 */
- (NSArray<SCSOpenMeasurementAdVerificationScript *> *)scriptsFromAdVerifications:(nullable NSArray<SCSVASTAdVerification *> *)adVerifications;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
