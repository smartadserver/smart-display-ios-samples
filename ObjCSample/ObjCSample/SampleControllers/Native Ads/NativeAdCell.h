//
//  NativeAdCell.h
//  ObjCSample
//
//  Created by Julien Gomez on 08/09/2015.
//  Copyright (c) 2018 Smart AdServer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SASDisplayKit/SASDisplayKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NativeAdCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *subtitleLabel;
@property (nonatomic, weak) IBOutlet UIButton *callToActionButton;

@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;
@property (nonatomic, weak) IBOutlet UIImageView *coverImageView;

@property (nonatomic, weak) IBOutlet SASAdChoicesView *adChoicesButton;
@property (nonatomic, weak) IBOutlet SASNativeAdMediaView *mediaView;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *titleLeadingSpaceConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *subtitleLeadingSpaceConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *iconTopSpaceConstraint;

- (void)setup;
- (void)setIconViewHidden:(BOOL)hidden;
- (void)updateConstraintsWhenCoverAndMediaAreHidden:(BOOL)hidden;

@end

NS_ASSUME_NONNULL_END
