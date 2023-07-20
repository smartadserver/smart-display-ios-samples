//
//  SASSellerDefinedSegment.h
//  SASDisplayKit
//
//  Created by Guillaume Laubier on 30/05/2023.
//  Copyright © 2023 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Object representing a Segment of both Seller Defined Audience and Seller Defined Content.
 */
@interface SASSellerDefinedSegment : NSObject <NSCoding, NSCopying>

/// The ID of the Segment if any, nil otherwise.
@property (nonatomic, readonly, nullable) NSString *ID;

/// The name of the Segment if any, nil otherwise.
@property (nonatomic, readonly, nullable) NSString *name;

/// The value of the Segment if any, nil otherwise.
@property (nonatomic, readonly, nullable) NSString *value;

/**
 Initialize a new instance of SASSellerDefinedSegment.
 
 @param ID The ID of the Segment if any, nil otherwise.
 @param name The name of the Segment if any, nil otherwise.
 @param value The value of the Segment if any, nil otherwise.
 
 @return An initialized instance of SASSellerDefinedSegment.
 */
- (instancetype)initWithID:(nullable NSString *)ID name:(nullable NSString *)name value:(nullable NSString *)value NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
