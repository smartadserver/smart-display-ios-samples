//
//  SASSellerDefinedAudience.h
//  SASDisplayKit
//
//  Created by Guillaume Laubier on 30/05/2023.
//  Copyright © 2023 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SASSellerDefinedSegment;

/**
 Object representing a Seller Defined Audience. More info here: http://documentation.smartadserver.com/displaySDK/sellerdefinedaudience.html
 */
@interface SASSellerDefinedAudience : NSObject <NSCoding, NSCopying>

/// The ID of the Seller Defined Audience if any, nil otherwise.
@property (nonatomic, readonly, nullable) NSString *ID;

/// The name of the Seller Defined Audience if any, nil otherwise.
@property (nonatomic, readonly, nullable) NSString *name;

/// An array of SASSellerDefinedSegment related to this Seller Defined Audience if any, nil otherwise.
@property (nonatomic, readonly, nullable) NSArray<SASSellerDefinedSegment *> *segments;

/**
 Initialize a new instance of SASSellerDefinedAudience.
 
 @param ID The ID of the Seller Defined Audience if any, nil otherwise.
 @param name The name of the Seller Defined Audience if any, nil otherwise.
 @param segments An array of SASSellerDefinedSegment related to this Seller Defined Audience if any, nil otherwise.
 
 @return An initialized instance of SASSellerDefinedAudience.
 */
- (instancetype)initWithID:(nullable NSString *)ID name:(nullable NSString *)name segments:(nullable NSArray<SASSellerDefinedSegment *> *)segments NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
