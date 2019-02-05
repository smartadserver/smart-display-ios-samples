//
//  NativeAdInTableBaseViewController.m
//  ObjCSample
//
//  Created by Loïc GIRON DIT METAZ on 25/10/2018.
//  Copyright © 2019 Julien Gomez. All rights reserved.
//

#import "NativeAdInTableBaseViewController.h"

// Custom cell
#import "NativeAdCell.h"

// Constants
#define kAdPosition                                 8
#define kDefaultCellHeight                          80.0
#define kDefaultAdCellWithoutMediaHeight            80.0
#define kDefaultAdCellWithMediaIncompressibleHeight 120.0

#define kDescriptionCellIdentifier                  @"DescriptionCell"
#define kContentCellIdentifier                      @"ContentCell"

#define kNativeAdCellNibName                        @"NativeAdCell"
#define kNativeAdCellIdentifier                     @"NativeAdCell"

@interface NativeAdInTableBaseViewController ()

@property (nonatomic, strong) SASNativeAdManager *nativeAdManager;
@property (nonatomic, strong) SASNativeAd *nativeAd;

@end

@implementation NativeAdInTableBaseViewController

- (void)dealloc {
    // Don't forget to unregister all native ads before leaving the controller or you might encounter some memory leak
    [self resetAd];
}

#pragma mark - Overriden method

- (SASAdPlacement *)adPlacement {
    // This method is overriden by NativeAdInTableViewController & NativeAdWithMediaInTableViewController
    // to return the relevant placement.
    return nil;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register Native Ad Cell nib
    [self.tableView registerNib:[UINib nibWithNibName:kNativeAdCellNibName bundle:nil] forCellReuseIdentifier:kNativeAdCellIdentifier];
    
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor colorWithRed:114./255 green:172./255 blue:145./255 alpha:0.8];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    
    // Load the ads
    [self refresh];
}

- (void)refresh {
    [self.refreshControl beginRefreshing];
    [self loadAd];
}

#pragma mark - Loading a Native Ad

- (void)loadAd {
    
    // If an ad exist, remove its delegate and unregister its views
    if (self.nativeAd) {
        self.nativeAd.delegate = nil;
        [self.nativeAd unregisterViews];
    }
    
    // Reset the manager
    if (self.nativeAdManager) {
        self.nativeAdManager = nil;
    }
    
    // Create a SASNativeAdManager with a given ad placement
    // (ad placement creation is done in the chosen subclass)
    self.nativeAdManager = [[SASNativeAdManager alloc] initWithPlacement:self.adPlacement];
    
    // Now, request an ad
    [self.nativeAdManager requestAd:^(SASNativeAd * _Nullable ad, NSError * _Nullable error) {
        [self.refreshControl endRefreshing];
        
        // If Ad Call has been successful, you'll get a brand new and shiny SASNativeAd object
        if (ad) {
            self.nativeAd = ad;
        } else { // If the call failed, handle the error any way you want. Here its a log. You could also request another ad...
            NSLog(@"Unable to load native ad: %@", [error description]);
        }
        
        // Reload your ad(s) row(s);
        [self reloadAdRows];
        
    }];
    
}

- (void)resetAd {
    if (self.nativeAd) {
        [self.nativeAd unregisterViews];
    }
    
    self.nativeAd.delegate = nil;
    self.nativeAd = nil;
    
    self.nativeAdManager = nil;
}

#pragma mark - Table View DataSource

- (BOOL)isAdLoaded {
    return self.nativeAd != nil;
}

- (void)reloadAdRows {
    NSIndexPath *adIndexPath = [NSIndexPath indexPathForRow:kAdPosition inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:adIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (BOOL)isAdCellAtIndexPath:(NSIndexPath *)indexPath {
    
    if (![self isAdLoaded]) {
        return NO;
    } else if (indexPath.row == kAdPosition) {
        return YES;
    } else {
        return NO;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // It's an ad cell!
    if ([self isAdCellAtIndexPath:indexPath]) {
        
        // Calculate the proper height for the cell according to the content of the Native Ad
        if ([self.nativeAd hasMedia]) {
            // With media
            return kDefaultAdCellWithMediaIncompressibleHeight + [self.nativeAd optimalMediaViewHeightForWidth:self.tableView.frame.size.width];
        } else if (self.nativeAd.coverImage) {
            // With cover
            return kDefaultAdCellWithMediaIncompressibleHeight + [self.nativeAd optimalCoverViewHeightForWidth:self.tableView.frame.size.width];
        } else {
            return kDefaultAdCellWithoutMediaHeight;
        }
        
    }
    
    // Default height
    return kDefaultCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Not an ad cell or no ad for the moment
    if (![self isAdCellAtIndexPath:indexPath]) {
        if (indexPath.row == 0) {
            // Configure description cell
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDescriptionCellIdentifier];
            UILabel *titleLabel = (UILabel *)[cell viewWithTag:2];
            titleLabel.text = @"Simple NativeAd integration";
            UILabel *subtitleLabel = (UILabel *)[cell viewWithTag:3];
            subtitleLabel.text = @"See implementation in NativeAdInTableViewController. Please scroll down to see th ad.";
            
            return cell;
        } else {
            // Configure content cell
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kContentCellIdentifier];
            
            UILabel *indexLabel = (UILabel *)[cell viewWithTag:1];
            indexLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
            indexLabel.layer.masksToBounds = true;
            indexLabel.layer.cornerRadius = 15;
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
    }
    
    // Ad Cell
    NativeAdCell *adCell = [tableView dequeueReusableCellWithIdentifier:kNativeAdCellIdentifier];
    
    // Register your cell with the native ad
    [self.nativeAd registerView:adCell modalParentViewController:self];
    
    // Populate Cell Content
    adCell.titleLabel.text = self.nativeAd.title;
    adCell.subtitleLabel.text = self.nativeAd.subtitle;
    [adCell.callToActionButton setTitle:self.nativeAd.callToAction forState:UIControlStateNormal];
    
    // Register AdChoices Button
    [adCell.adChoicesButton registerNativeAd:self.nativeAd modalParentViewController:self];
    
    // Check if native ad has icon and act accordingly
    if (self.nativeAd.icon) {
        [adCell setIconViewHidden:NO];
        [self downloadImageAtURL:self.nativeAd.icon.URL forImageView:adCell.iconImageView];
    } else {
        [adCell setIconViewHidden:YES];
        adCell.iconImageView.image = nil;
    }
    
    // Check if native ad has cover and act accordingly
    if (self.nativeAd.coverImage) {
        adCell.coverImageView.hidden = NO;
        [self downloadImageAtURL:self.nativeAd.coverImage.URL forImageView:adCell.coverImageView];
    } else {
        adCell.coverImageView.hidden = YES;
        adCell.coverImageView.image = nil;
    }
    
    // Check if native ad has media and act accordingly
    if ([self.nativeAd hasMedia]) {
        adCell.mediaView.hidden = NO;
        [adCell.mediaView registerNativeAd:self.nativeAd];
        adCell.mediaView.delegate = self;
    } else {
        adCell.mediaView.hidden = YES;
        adCell.mediaView.delegate = nil;
    }
    
    // If there is neither media nor cover, some constraints must be modified
    if (![self.nativeAd hasMedia] && self.nativeAd.coverImage == nil) {
        [adCell updateConstraintsWhenCoverAndMediaAreHidden:YES];
    } else {
        [adCell updateConstraintsWhenCoverAndMediaAreHidden:NO];
    }
    
    return adCell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - Native Ad Media view delegate

- (void)nativeAdMediaView:(SASNativeAdMediaView *)mediaView didFailToLoadMediaWithError:(NSError *)error {
    NSLog(@"SASNativeAdMediaView failed to load its media");
    
    [self resetAd];
    [self.tableView reloadData];
    [self loadAd];
}

- (void)nativeAdMediaViewDidLoadMedia:(SASNativeAdMediaView *)mediaView {
    NSLog(@"SASNativeAdMediaView did load its media.");
}

- (void)nativeAdMediaViewWillPresentFullscreenModalMedia:(SASNativeAdMediaView *)mediaView {
    NSLog(@"SASNativeAdMediaView will present a fullscreen modal view");
}

- (void)nativeAdMediaViewDidPresentFullscreenModalMedia:(SASNativeAdMediaView *)mediaView {
    NSLog(@"SASNativeAdMediaView did present a fullscreen modal view");
}

- (void)nativeAdMediaViewWillCloseFullscreenModalMedia:(SASNativeAdMediaView *)mediaView {
    NSLog(@"SASNativeAdMediaView will close a fullscreen modal view");
}

- (void)nativeAdMediaViewDidCloseFullscreenModalMedia:(SASNativeAdMediaView *)mediaView {
    NSLog(@"SASNativeAdMediaView did close a fullscreen modal view");
}

- (BOOL)nativeAdMediaViewShouldHandleAudioSession:(SASNativeAdMediaView *)mediaView {
    return YES;
}

- (void)nativeAdMediaViewWillPlayAudio:(SASNativeAdMediaView *)mediaView {
    NSLog(@"SASNativeAdMediaView will play audio");
    
}

- (void)nativeAdMediaViewDidFinishPlayingAudio:(SASNativeAdMediaView *)mediaView {
    NSLog(@"SASNativeAdMediaView did finish to play audio");
}

- (void)nativeAdMediaView:(SASNativeAdMediaView *)mediaView didSendVideoEvent:(SASVideoEvent)videoEvent {
    // This delegate can be used to listen for video events.
    
    // For instance, you can use these events to check if the video has been played until the end
    // by listening to the event 'SASVideoEventComplete'
    
    if (videoEvent == SASVideoEventComplete) {
        NSLog(@"The media has been played until the end");
    }
}

#pragma mark - Helper methods

- (void)downloadImageAtURL:(NSURL *)url forImageView:(UIImageView *)imageView {
    imageView.image = nil;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^(void) {
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [[UIImage alloc] initWithData:imageData];
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                imageView.image = image;
                [imageView setNeedsLayout];
            });
        }
    });
}

@end
