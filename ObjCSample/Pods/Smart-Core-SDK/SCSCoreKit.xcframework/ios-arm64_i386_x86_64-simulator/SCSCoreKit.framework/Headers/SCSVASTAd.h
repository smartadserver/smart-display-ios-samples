//
//  SCSVASTAd.h
//  SCSCoreKit
//
//  Created by Thomas Geley on 21/03/2017.
//  Copyright © 2017 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SCSVASTURL, SCSVASTCreativeLinear, SCSVASTCreativeCompanion, SCSVASTCreativeNonLinear, SCSVASTAdExtension, SCSVASTError, SCSVASTAdVerification, SCSVASTViewabilityEvent;

@interface SCSVASTAd : NSObject

/// The ID of this Ad.
@property (nullable, nonatomic, readonly) NSString *adID;

/// The Sequence of this Ad aka position in AdPod.
@property (nullable, nonatomic, readonly) NSString *adSequence;

/// The AdSystem delivering this Ad.
@property (nullable, nonatomic, strong) NSString *adSystem;

/// The AdTitle of this Ad.
@property (nullable, nonatomic, strong) NSString *adTitle;

/// The error pixels to be called if this ad fails somehow.
@property (nonatomic, strong) NSMutableArray <SCSVASTURL *> *errorPixels;

/// The impression pixels to be called when this ad is played.
@property (nonatomic, strong) NSMutableArray <SCSVASTURL *> *impressions;

/// The viewability events to be called as per VAST & MRC specification. Contains Viewable, NotViewable and ViewUndetermined events.
@property (nonatomic, strong) NSMutableArray <SCSVASTViewabilityEvent *> *viewabilityEvents;

/// The linear creatives shipped with this ad.
@property (nonatomic, strong) NSMutableArray <SCSVASTCreativeLinear *> *linearCreatives;

/// The companion creative shipped with this ad.
@property (nonatomic, strong) NSMutableArray <SCSVASTCreativeCompanion *> *companionCreatives;

/// The non linear creatives shipped with this ad.
@property (nonatomic, strong) NSMutableArray <SCSVASTCreativeNonLinear *> *nonLinearCreatives;

/// The AdVerifications shipped with this ad.
@property (nonatomic, strong) NSMutableArray <SCSVASTAdVerification *> *adVerifications;

/// The extensions shipped with this ad.
@property (nullable, nonatomic, strong) SCSVASTAdExtension *extensions;

/// An error has occured during the parsing of this ad, it should be considered as invalid.
@property (nonatomic, assign) BOOL hasTriggeredAParsingError;

- (instancetype)init NS_UNAVAILABLE;

/** 
 Initialize a SCSVASTAd object from an XML Dictionary.
 
 @param dictionary A dictionary extracted from an XML Ad Tag.
 @return An initialized instance of SCSVASTAd or nil if an error occurred during parsing.
 */
- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary __deprecated;

/**
 Initialize a SCSVASTAd object from an XML Dictionary.

 @param dictionary A dictionary extracted from an XML Ad Tag.
 @param error A reference to an error that will be set if the VAST ad cannot be initialized.
 @param errorHandler A block called when an error is encountered if any (blocking or not). If the error prevent the model from being initialized, it will also be set in the 'error' reference.
 @return An initialized instance of SCSVASTAd or nil if an error occurred during parsing.
*/
- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary error:(NSError *__nullable *__nullable)error errorHandler:(void(^)(SCSVASTError *, NSMutableArray <SCSVASTURL *> *))errorHandler NS_DESIGNATED_INITIALIZER;

/**
 Indicates whether or not this Ad is valid and can be consumed.
 
 @return Whether or not this Ad is valid and can be consumed.
 */
- (BOOL)isValid;

/**
 Indicates whether or not this Ad is inline.
 
 @return Whether or not this Ad is inline.
 */
- (BOOL)isInline;

/**
 Indicates whether or not this Ad is a wrapper.
 
 @return Whether or not this Ad is a wrapper.
 */
- (BOOL)isWrapper;

/**
 Indicates whether or not this Ad has a sequence (belongs to an AdPod).
 
 @return Whether or not this Ad has a sequence.
 */
- (BOOL)hasSequence;

/**
 Indicates whether or not this Ad has been consumed.
 
 @return Whether or not this Ad has been consumed.
 */
- (BOOL)hasBeenConsumed;

/**
 Indicates the Action URL to be called by this Ad. MediaFile URL for Inline / WrapperURL for Wrappers.
 
 @return The Action URL to be called by this Ad.
 */
- (nullable NSURL *)nextActionURL;

/**
 Consumes an Ad. It will not be reused by the VAST Manager component.
 */
- (void)consume;

/**
 Merges this ad with another Ad. Usefull in case of Wrappers ad where trackingEvents and ErrorPixels for the wrapper needs to be reported into a new ad.
 
 @param ad The ad from which the properties will be merged into the current ad.
 */
- (void)merge:(SCSVASTAd *)ad;

@end

NS_ASSUME_NONNULL_END
