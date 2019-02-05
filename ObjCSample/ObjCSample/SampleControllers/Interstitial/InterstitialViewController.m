//
//  InterstitialViewController.m
//  ObjCSample
//
//  Created by Julien Gomez on 17/10/2018.
//  Copyright © 2019 Smart AdServer. All rights reserved.
//

#import "InterstitialViewController.h"

#define kInterstitialSiteID          104808
#define kInterstitialPageID          663264
#define kInterstitialFormatID        12167

@interface InterstitialViewController ()

@property SASInterstitialManager *interstitialManager;

@end

@implementation InterstitialViewController

#pragma mark - View controller lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createInterstitialManager];
}

- (void)createInterstitialManager {
    // Create a placement
    SASAdPlacement *placement = [SASAdPlacement adPlacementWithSiteId:kInterstitialSiteID pageId:kInterstitialPageID formatId:kInterstitialFormatID];
    
    // You can also use a test placement during development (a placement that will always deliver an ad from a given format).
    // DON'T FORGET TO REVERT TO THE ACTUAL PLACEMENT BEFORE SHIPPING THE APP!
    
    // SASAdPlacement *placement = [SASAdPlacement adPlacementWithTestAd:SASAdPlacementTestInterstitialMRAID];
    // SASAdPlacement *placement = [SASAdPlacement adPlacementWithTestAd:SASAdPlacementTestInterstitialVideo];
    // SASAdPlacement *placement = [SASAdPlacement adPlacementWithTestAd:SASAdPlacementTestInterstitialVideo360];
    
    // Initialize the interstitial manager with a placement
    self.interstitialManager = [[SASInterstitialManager alloc] initWithPlacement:placement delegate:self];
}

#pragma mark - View controller actions

- (IBAction)loadInterstitialAd:(id)sender {
    // Disable show button during load phase
    self.showInterstitialAdButton.enabled = NO;
    
    [self.interstitialManager load];
}

- (IBAction)showInterstitialAd:(id)sender {
    // Check if interstitial is ready
    if (self.interstitialManager.adStatus == SASAdStatusReady) {
        [self.interstitialManager showFromViewController:self];
    } else if (self.interstitialManager.adStatus == SASAdStatusExpired) {
        // If not, one of the reason could be that it's expired
        NSLog(@"Interstitial has expired and cannot be shown anymore.");
    }
}

#pragma mark - SASInterstitialManager delegate

- (void)interstitialManager:(SASInterstitialManager *)manager didLoadAd:(SASAd *)ad {
    NSLog(@"Interstitial has been loaded and is ready to be shown");
    // Enable show button
    self.showInterstitialAdButton.enabled = YES;
}

- (void)interstitialManager:(SASInterstitialManager *)manager didAppearFromViewController:(nonnull UIViewController *)controller {
    // Interstial is shown so we disable the show button
    self.showInterstitialAdButton.enabled = NO;
}

- (void)interstitialManager:(SASInterstitialManager *)manager didFailToLoadWithError:(NSError *)error {
    NSLog(@"Interstitial did fail to load with error: %@", [error localizedDescription]);
}

- (void)interstitialManager:(SASInterstitialManager *)manager didFailToShowWithError:(NSError *)error {
    NSLog(@"Interstitial did fail to show with error: %@", [error localizedDescription]);
}

@end
