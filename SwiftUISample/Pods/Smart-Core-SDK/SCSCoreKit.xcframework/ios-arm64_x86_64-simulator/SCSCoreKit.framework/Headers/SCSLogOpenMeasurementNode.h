//
//  SCSLogOpenMeasurementNode.h
//  SCSCoreKit
//
//  Created by Loïc GIRON DIT METAZ on 26/08/2020.
//  Copyright © 2020 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SCSCoreKit/SCSLogNode.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SCSLogOpenMeasurementNodeImplementationType) {
    SCSLogOpenMeasurementNodeImplementationTypeNative = 0,
    SCSLogOpenMeasurementNodeImplementationTypeWebview = 1
};

@interface SCSLogOpenMeasurementNode : SCSLogNode

/**
 Initialize a new instance of SCSLogOpenMeasurementNode.
 
 @param vendorName The name of the vendor if available, nil otherwise.
 @param JSLibraryURLString The URL of the JS library.
 @param implementationType The type of implementation.
 @return An initialized instance of SCSLogOpenMeasurementNode.
 */
- (instancetype)initWithVendorName:(nullable NSString *)vendorName
                JSLibraryURLString:(NSString *)JSLibraryURLString
                implementationType:(SCSLogOpenMeasurementNodeImplementationType)implementationType;

@end

NS_ASSUME_NONNULL_END
