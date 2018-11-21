 //
//  NativeAdCell.m
//  ObjCSample
//
//  Created by Julien Gomez on 08/09/2015.
//  Copyright (c) 2018 Smart AdServer. All rights reserved.
//

#import "NativeAdCell.h"

@implementation NativeAdCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    self.callToActionButton.titleLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setIconViewHidden:(BOOL)hidden {
    self.iconImageView.hidden = hidden;
    _titleLeadingSpaceConstraint.constant = hidden ? 2 : 52;
}

- (void)updateConstraintsWhenCoverAndMediaAreHidden:(BOOL)hidden {
    _iconTopSpaceConstraint.constant = hidden ? 12 : 2;
    _subtitleLeadingSpaceConstraint.constant = hidden ? _titleLeadingSpaceConstraint.constant : 2;
    _subtitleLabel.numberOfLines = hidden ? 1:3;
}

@end
