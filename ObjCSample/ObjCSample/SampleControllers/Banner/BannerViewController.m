//
//  BannerViewController.m
//  ObjCSample
//
//  Created by Julien GOMEZ on 16/10/18.
//  Copyright © 2019 Smart AdServer. All rights reserved.
//

#import "BannerViewController.h"

#define kBannerSiteID          104808
#define kBannerPageID          663262
#define kBannerFormatID        15140

@interface BannerViewController ()

@property SASBannerView *banner;

@end

@implementation BannerViewController

#pragma mark - View controller lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	[self createBanner];
	[self createReloadButton];
}

- (void)createReloadButton {
	UIBarButtonItem *reloadButton = [[UIBarButtonItem alloc] initWithTitle:@"Reload" style:UIBarButtonItemStylePlain target:self action:@selector(reload)];
    reloadButton.accessibilityLabel = @"reloadButton";
	self.navigationItem.rightBarButtonItem = reloadButton;
}

- (void)reload {
    [self.banner refresh];
}

- (void)createBanner {
    // Banner creation and configuration
	self.banner = [[SASBannerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 50) loader:SASLoaderActivityIndicatorStyleWhite];
	self.banner.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	self.banner.delegate = self;
    // Setting the modal parent view controller.
    self.banner.modalParentViewController = self;
    
    // Create a placement
    SASAdPlacement *placement = [SASAdPlacement adPlacementWithSiteId:kBannerSiteID pageId:kBannerPageID formatId:kBannerFormatID];
    
    // You can also use a test placement during development (a placement that will always deliver an ad from a given format).
    // DON'T FORGET TO REVERT TO THE ACTUAL PLACEMENT BEFORE SHIPPING THE APP!
    
    // SASAdPlacement *placement = [SASAdPlacement adPlacementWithTestAd:SASAdPlacementTestBannerMRAID];
    // SASAdPlacement *placement = [SASAdPlacement adPlacementWithTestAd:SASAdPlacementTestBannerVideoRead];
    // SASAdPlacement *placement = [SASAdPlacement adPlacementWithTestAd:SASAdPlacementTestBannerVideoRead360];

    [self.banner loadWithPlacement:placement];	
	[self.view addSubview:self.banner];
}

#pragma mark - SASBannerView delegate

//  Uncomment this code if you want to adapt the height of the banner to keep the best ratio for the ad
//  For example, if you get a 16/9 video instead of 320x50 classic banner you just need to call optimalAdViewHeightForContainer
// to get the optimal height of your banner frame

// - (void)bannerView:(SASBannerView *)bannerView didDownloadAd:(SASAd *)ad {
//    float optimalHeight =  [bannerView optimalAdViewHeightForContainer:self.view];
//    CGRect frame = CGRectMake(bannerView.frame.origin.x, bannerView.frame.origin.y, bannerView.frame.size.width, optimalHeight);
//    self.banner.frame = frame;
// }

- (void)bannerViewDidLoad:(SASBannerView *)bannerView {
    NSLog(@"Banner has been loaded");
}

- (void)bannerView:(SASBannerView *)bannerView didFailToLoadWithError:(NSError *)error {
    NSLog(@"Banner has failed to load with error: %@", [error localizedDescription]);
}

@end
