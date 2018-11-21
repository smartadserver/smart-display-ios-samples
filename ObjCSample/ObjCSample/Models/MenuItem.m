//
//  MenuItem.m
//  ObjCSample
//
//  Created by Julien GOMEZ on 16/10/18.
//  Copyright (c) 2018 Smart AdServer. All rights reserved.
//

#import "MenuItem.h"
#import "BannerViewController.h"

@implementation MenuItem

- (id)initWithTitle:(NSString *)title segueIdentifier:(NSString *)segueIdentifier {
	self = [super init];
	
	if (self) {
		self.title = title;
        self.segueIdentifier = segueIdentifier;
	}
	return self;
}

@end
