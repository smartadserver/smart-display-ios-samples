//
//  InAppBiddingInterstitialViewController.m
//  ObjCSample
//
//  Created by Loïc GIRON DIT METAZ on 28/10/2019.
//  Copyright © 2019 Smart AdServer. All rights reserved.
//

#import "InAppBiddingInterstitialViewController.h"

@interface InAppBiddingInterstitialViewController ()

/// The interstitial manager used to display the current interstitial if any.
///
/// Note: contrary to the regular integration where an unique interstitial manager is created (associated to a placement) and
/// reused, in-app bidding integration requires to use a different interstitial manager for each call.
/// That is why we do not initialize it now and we declare it as nullable.
@property (nonatomic, strong, nullable) SASInterstitialManager *interstitialManager;

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

@implementation InAppBiddingInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureBiddingManager];
    [self updateUIStatus];
}

- (void)configureBiddingManager {
    SASAdPlacement *placement = [[SASAdPlacement alloc] initWithSiteId:104808 pageId:1160279 formatId:85867 keywordTargeting:@"interstitial-inapp-bidding"];
    
    /// Creating the bidding manager that will handle all bidding ad calls.
    self.biddingManager = [[SASBiddingManager alloc] initWithAdPlacement:placement
                                                     biddingAdFormatType:SASBiddingAdFormatTypeInterstitial
                                                                currency:@"USD"
                                                                delegate:self];
    // Note that you must provide a placement, an ad format type, but also the currency you are using
}

#pragma mark - Bidding manager

- (IBAction)loadBiddingAd:(id)sender {
    self.isBiddingManagerLoading = YES;
    self.biddingAdResponse = nil;
    
    // Loading a bidding ad response using the bidding manager.
    [self.biddingManager load];
    
    [self updateUIStatus];
}

- (IBAction)showBiddingAd:(id)sender {
    if (self.biddingAdResponse != nil) {
        // We use an interstitial manager to display the bidding response retrieved earlier.
        //
        // Note: in an actual application, you would load Smart bidding ad response only if it
        // better than responses you got from other third party SDKs.
        //
        // You can check the CPM associated with the bidding ad response by checking:
        // - biddingAdResponse.biddingAdPrice.cpm
        // - biddingAdResponse.biddingAdPrice.currency
        //
        // If you decide not to use the bidding ad response, you can simply discard it.
        self.interstitialManager = [[SASInterstitialManager alloc] initWithBiddingAdResponse:self.biddingAdResponse delegate:self];
        [self.interstitialManager load];
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

#pragma mark - SASInterstitialDelegate

- (void)interstitialManager:(SASInterstitialManager *)manager didLoadAd:(SASAd *)ad {
    self.biddingAdResponse = nil;
    
    // In this sample, we display the interstitial as soon as it is loaded.
    // But it is possible to display it later, like on regular integrations.
    [self.interstitialManager showFromViewController:self];
    
    NSLog(@"Interstitial has been loaded");
    [self updateUIStatus];
}

- (void)interstitialManager:(SASInterstitialManager *)manager didFailToLoadWithError:(NSError *)error {
    self.biddingAdResponse = nil;
    
    NSLog(@"Interstitial has failed to load with error: %@", error.localizedDescription);
    [self updateUIStatus];
    
}

- (void)interstitialManager:(SASInterstitialManager *)manager didAppearFromViewController:(UIViewController *)viewController {
    NSLog(@"Interstitial did appear");
    [self updateUIStatus];
}

- (void)interstitialManager:(SASInterstitialManager *)manager didFailToShowWithError:(NSError *)error {
    NSLog(@"Interstitial has failed to show with error: %@", error.localizedDescription);
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
