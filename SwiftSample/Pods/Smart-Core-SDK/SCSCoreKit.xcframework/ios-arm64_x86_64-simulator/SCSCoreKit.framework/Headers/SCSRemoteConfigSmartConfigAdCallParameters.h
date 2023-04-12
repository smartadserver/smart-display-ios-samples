//
//  SCSRemoteConfigSmartConfigAdCallParameters.h
//  SCSCoreKit
//
//  Created by Loïc GIRON DIT METAZ on 21/02/2023.
//  Copyright © 2023 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Model holding all parameters that should be provided in each ad calls.
 */
@interface SCSRemoteConfigSmartConfigAdCallParameters : NSObject

/// An arbitrary dictionary of parameters that should be sent in the POST.
@property (readonly) NSDictionary<NSString *, NSObject *> *postParameters;

/// An arbitrary dictionary of parameters that should be sent in the GET.
@property (readonly) NSDictionary<NSString *, NSObject *> *getParameters;

/**
 Initialize a new instance of SCSRemoteConfigSmartConfigAdCallParameters.
 
 @param postParameters An arbitrary dictionary of parameters that should be sent in the POST.
 @return An initialized instance of SCSRemoteConfigSmartConfigAdCallParameters.
 */
- (instancetype)initWithPostParameters:(NSDictionary<NSString *, NSObject *> *)postParameters
                         getParameters:(NSDictionary<NSString *, NSObject *> *)getParameters NS_DESIGNATED_INITIALIZER;

/**
 Initialize a new instance of SCSRemoteConfigSmartConfigAdCallParameters from a dictionary.
 
 @param dictionary The dictionary which will be used to initialize SCSRemoteConfigSmartConfigAdCallParameters.
 @return An initialized instance of SCSRemoteConfigSmartConfigAdCallParameters.
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
