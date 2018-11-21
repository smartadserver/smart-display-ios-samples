//
//  MenuItem.h
//  ObjCSample
//
//  Created by Julien GOMEZ on 16/10/18.
//  Copyright (c) 2018 Smart AdServer. All rights reserved.
//

#import <Foundation/Foundation.h>

// Represents an entry in the Main menu.
@interface MenuItem : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *segueIdentifier;

- (id)initWithTitle:(NSString *)title segueIdentifier:(NSString *)segueIdentifier;

@end
