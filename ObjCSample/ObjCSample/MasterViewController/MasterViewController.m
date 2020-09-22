//
//  MasterViewController.m
//  ObjCSample
//
//  Created by Julien GOMEZ on 16/10/18.
//  Copyright © 2019 Smart AdServer. All rights reserved.
//

#import "MasterViewController.h"
#import "MenuItem.h"

#import <AppTrackingTransparency/AppTrackingTransparency.h>

@interface MasterViewController ()

@property NSMutableArray *items;

@end

@implementation MasterViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestTrackingAuthorization];
    [self initializeItems];
}

- (void)requestTrackingAuthorization {
    
    // Starting with iOS 14, you must ask the user for consent before being able to track it.
    // If you do not ask consent (or if the user decline), the SDK will not use the device IDFA.
    if (@available(iOS 14, *)) {
        // Check if the tracking authorization status is not determined…
        if (ATTrackingManager.trackingAuthorizationStatus == ATTrackingManagerAuthorizationStatusNotDetermined) {
            
            // Ask the user for tracking permission.
            //
            // Note:
            // In order to get a good user experience, choose the right time to display this
            // authorization request, and customize the autorization request description in the
            // app Info.plist file.
            [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
                if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
                    NSLog(@"[ATT] The tracking authorization has been granted by the user!");
                    
                    // The tracking authorization has been granted!
                    // The SDK will be able to use the device IDFA during ad calls.
                } else {
                    NSLog(@"[ATT] The tracking authorization is not granted!");
                    
                    // The tracking authorization has not been granted!
                    //
                    // The SDK will only uses a technical randomly generated ID that will not be
                    // shared cross apps and will be reset every 24 hours.
                    // This 'transient ID' will only be used for technical purposes (ad fraud
                    // detection, capping, …).
                    //
                    // You can disable it completely by using the following configuration flag:
                    // SASConfiguration.shared.transientIDEnabled = false
                }
            }];
        }
    }

}

#pragma mark - Items initialization

- (void)initializeItems {
    self.items = [[NSMutableArray alloc] init];
    [self addItemInItemsArray:@"Banner" segueIdentifier:@"BannerViewControllerSegue"];
    [self addItemInItemsArray:@"Banner (in-app bidding)" segueIdentifier:@"InAppBiddingBannerViewControllerSegue"];
    [self addItemInItemsArray:@"Interstitial" segueIdentifier:@"InterstitialViewControllerSegue"];
    [self addItemInItemsArray:@"Interstitial (in-app bidding)" segueIdentifier:@"InAppBiddingInterstitialViewControllerSegue"];
    [self addItemInItemsArray:@"RewardedVideo" segueIdentifier:@"RewardedVideoViewControllerSegue"];
    [self addItemInItemsArray:@"Multiple Banners and Medias in news feed" segueIdentifier:@"MultipleBannersViewControllerSegue"];
    [self addItemInItemsArray:@"Native Ad in news feed" segueIdentifier:@"NativeAdInTableViewControllerSegue"];
    [self addItemInItemsArray:@"Native Ad With Media in news feed" segueIdentifier:@"NativeAdWithMediaInTableViewControllerSegue"];
}

- (void)addItemInItemsArray:(NSString *)title segueIdentifier:(NSString *)segueIdentifier {
    MenuItem *item = [[MenuItem alloc] initWithTitle:title segueIdentifier:segueIdentifier];
    [self.items addObject:item];
}

#pragma mark - Table view delegate & data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    [cell.textLabel setText:[[self.items objectAtIndex:indexPath.row] title]];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Choose a sample:";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @"\nThis sample demonstrates how to implement the Smart AdServer SDK in applications that use ObjC.\n\nFor applications that use Swift, check the SwiftSample";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:[[self.items objectAtIndex:indexPath.row] segueIdentifier] sender:self];
    
}

@end
