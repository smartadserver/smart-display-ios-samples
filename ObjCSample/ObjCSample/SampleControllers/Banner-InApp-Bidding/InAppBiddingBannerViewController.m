//
//  InAppBiddingBannerViewController.m
//  ObjCSample
//
//  Created by Loïc GIRON DIT METAZ on 28/10/2019.
//  Copyright © 2019 Smart AdServer. All rights reserved.
//

#import "InAppBiddingBannerViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface InAppBiddingBannerViewController ()

/// Instance of the banner.
@property (nonatomic, strong) SASBannerView *bannerView;

/// The bidding manager will handle all bidding ad calls.
@property (nonatomic, strong) SASBiddingManager *biddingManager;

/// Current bidding ad response if any.
@property (nonatomic, strong, nullable) SASBiddingAdResponse *biddingAdResponse;

/// Flag to check if the bidding manager is currently loading.
@property (nonatomic, assign) BOOL isBiddingManagerLoading;

@property (weak, nonatomic) IBOutlet UIButton *loadButton;
@property (weak, nonatomic) IBOutlet UIButton *showButton;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation InAppBiddingBannerViewController

#pragma mark - View controller lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureBiddingManager];
    [self configureBanner];
    [self updateUIStatus];
}

- (void)configureBiddingManager {
    SASAdPlacement *placement = [[SASAdPlacement alloc] initWithSiteId:104808 pageId:1160279 formatId:85867 keywordTargeting:@"banner-inapp-bidding"];
    
    /// Creating the bidding manager that will handle all bidding ad calls.
    self.biddingManager = [[SASBiddingManager alloc] initWithAdPlacement:placement
                                                     biddingAdFormatType:SASBiddingAdFormatTypeBanner
                                                                currency:@"USD"
                                                                delegate:self];
    // Note that you must provide a placement, an ad format type, but also the currency you are using
}

- (void)configureBanner {
    /// Creating the instance of the banner.
    self.bannerView = [[SASBannerView alloc] initWithFrame:CGRectZero loader:SASLoaderActivityIndicatorStyleWhite];
    
    // Setting the delegate.
    self.bannerView.delegate = self;
    
    // Contrary to a simple banner integration, we don't load any ad from placement here:
    // We will load a bidding response in it later, for now we simply hide it…
    self.bannerView.hidden = YES;
    
    // Adding the ad view to the actual view of the controller.
    [self.view addSubview:self.bannerView];
    
    // Setting the banner constraints
    self.bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.bannerView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor] setActive:YES];
    [[self.bannerView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor] setActive:YES];
    [[self.bannerView.heightAnchor constraintEqualToConstant:50.0] setActive:YES];
    [[self.bannerView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor] setActive:YES];
}

#pragma mark - Bidding manager

- (IBAction)loadBiddingAd:(id)sender {
    self.isBiddingManagerLoading = YES;
    self.biddingAdResponse = nil;
    
    // Hidding the banner until a ad is actually loaded
    self.bannerView.hidden = YES;
    
    // Loading a bidding ad response using the bidding manager.
    [self.biddingManager load];
    
    [self updateUIStatus];
}

- (IBAction)showBiddingAd:(id)sender {
    if (self.biddingAdResponse != nil) {
        // Showing the banner
        self.bannerView.hidden = NO;
        
        // We use our banner to display the bidding response retrieved earlier.
        //
        // Note: in an actual application, you would load Smart bidding ad response only if it
        // better than responses you got from other third party SDKs.
        //
        // You can check the CPM associated with the bidding ad response by checking:
        // - biddingAdResponse.biddingAdPrice.cpm
        // - biddingAdResponse.biddingAdPrice.currency
        //
        // If you decide not to use the bidding ad response, you can simply discard it.
        [self.bannerView loadBiddingAdResponse:self.biddingAdResponse];
    }
    
    [self updateUIStatus];
}

- (BOOL)hasValidBiddingAdResponse {
    if (self.biddingAdResponse != nil) {
        // A bidding ad response is valid only if it has not been consumed already
        return !self.biddingAdResponse.isConsumed;
    } else {
        return NO;
    }
}

#pragma mark - SASBiddingManagerDelegate

- (void)biddingManager:(SASBiddingManager *)biddingManager didLoadAdResponse:(SASBiddingAdResponse *)biddingAdResponse {
    self.isBiddingManagerLoading = NO;
    self.biddingAdResponse = biddingAdResponse;
    
    // A bidding ad response has been received.
    // You can now load it into an ad view or discard it. See showBiddingAd(_:) for more info.
    
    NSLog(@"A bidding ad response has been loaded: %@", self.biddingAdResponse);
    [self updateUIStatus];
}

- (void)biddingManager:(SASBiddingManager *)biddingManager didFailToLoadWithError:(NSError *)error {
    self.isBiddingManagerLoading = NO;
    self.biddingAdResponse = nil;
    
    NSLog(@"Failed to load bidding ad reponse with error: %@", error);
    [self updateUIStatus];
}

#pragma mark - SASAdViewDelegate

- (void)bannerViewDidLoad:(SASBannerView *)bannerView {
    NSLog(@"Banner has been loaded");
    self.biddingAdResponse = nil;
    [self updateUIStatus];
}

- (void)bannerView:(SASBannerView *)bannerView didFailToLoadWithError:(NSError *)error {
    NSLog(@"Banner has failed to load with error: %@", error);
    self.biddingAdResponse = nil;
    [self updateUIStatus];
}

#pragma mark - Utils

- (void)updateUIStatus {
    // Buttons
    self.loadButton.enabled = !self.isBiddingManagerLoading;
    self.showButton.enabled = [self hasValidBiddingAdResponse];
    
    // Status label
    if (self.isBiddingManagerLoading) {
        self.statusLabel.text = @"loading a bidding ad…";
    } else if (self.biddingAdResponse.biddingAdPrice != nil) {
        self.statusLabel.text = [NSString stringWithFormat:@"bidding response: %.6f %@", self.biddingAdResponse.biddingAdPrice.cpm, self.biddingAdResponse.biddingAdPrice.currency];
    } else {
        self.statusLabel.text = @"(no bidding ad response loaded)";
    }
}

@end

NS_ASSUME_NONNULL_END
