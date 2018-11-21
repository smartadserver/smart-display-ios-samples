//
//  MasterViewController.m
//  ObjCSample
//
//  Created by Julien GOMEZ on 16/10/18.
//  Copyright (c) 2018 Smart AdServer. All rights reserved.
//

#import "MasterViewController.h"
#import "MenuItem.h"

@interface MasterViewController ()

@property NSMutableArray *items;

@end

@implementation MasterViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeItems];
}

#pragma mark - Items initialization

- (void)initializeItems {
    self.items = [[NSMutableArray alloc] init];
    
    [self addItemInItemsArray:@"Banner" segueIdentifier:@"BannerViewControllerSegue"];
    [self addItemInItemsArray:@"Interstitial" segueIdentifier:@"InterstitialViewControllerSegue"];
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
