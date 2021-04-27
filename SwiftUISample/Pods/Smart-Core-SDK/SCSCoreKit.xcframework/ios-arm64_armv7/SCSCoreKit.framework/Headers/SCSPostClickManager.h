//
//  SCSPostClickManager.h
//  SCSCoreKit
//
//  Created by Thomas Geley on 06/09/2017.
//  Copyright © 2017 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SCSPostClickManagerDelegate;

/**
 Config class that can be used to customize the behavior of the post click manager.
 */
@interface SCSPostClickManagerConfig : NSObject

/// YES if the post click manager should force the URL opening outside of the app, NO otherwise (default).
@property (assign) BOOL forceRedirectToThirdParty;

@end

/**
 A class to handle clicks.
 
 Depending on the format of the URL the SCSPostClickManager instance will trigger the right post click behavior:
 - Opening in SFSafariViewController (>= iOS 9)
 - Opening in SKStoreKitViewController
 - Opening outside the application for deeplinks or HTTP links on version < iOS 9.
 
 Once the URL is opened, the click pixels will be triggered by the SCSPostClickManager instance.
 */
@interface SCSPostClickManager : NSObject

/// The delegate that should be warned if the view status changes
@property (nullable, nonatomic, weak) id<SCSPostClickManagerDelegate> delegate;

- (instancetype)init NS_UNAVAILABLE;

/**
 Public Initializer
 
 @param delegate the Delegate for the SCSPostClickManager instance.
 
 @return an initialized SCSPostClickManager instance.
 */
- (instancetype)initWithDelegate:(id <SCSPostClickManagerDelegate>)delegate;

/**
 Indicates whether or not an URL can be opened by the SCSPostClickManager.
 Use this method to decide which URL of an Ad Object to open.
 
 @param url The NSURL to be tested.
 
 @return whether or not this URL can be opened by the SCSPostClickManager.
 */
- (BOOL)canOpenURL:(NSURL *)url;

/**
 Call this method to open an URL in the most appropriate target. Click trackings pixels will be triggered if the URL opens successfully.
 
 @param url The URL to open.
 @param clickPixels The pixels to be called if URL opening is successful.
 */
- (void)openURL:(NSURL *)url clickPixels:(nullable NSArray <NSURL *> *)clickPixels;

/**
 Open a deep link URL if possible or fallback on a regular URL otherwise.
 
 @param url The web URL that will be used if the deep link URL cannot be open.
 @param deepLinkUrl The deep link URL if any, nil otherwise.
 @param config A config instance to customize the post click manager behavior, or nil to request default behavior.
 @param clickPixels The pixels to be called if URL opening is successful.
 */
- (void)openURL:(NSURL *)url deepLinkURL:(nullable NSURL *)deepLinkUrl config:(nullable SCSPostClickManagerConfig *)config clickPixels:(nullable NSArray <NSURL *> *)clickPixels;

@end

NS_ASSUME_NONNULL_END
