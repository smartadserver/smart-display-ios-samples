//
//  BannerInTableViewController.m
//  ObjCSample
//
//  Created by Julien Gomez on 17/10/2018.
//  Copyright © 2019 Smart AdServer. All rights reserved.
//

#import "BannerInTableViewController.h"

#define kSiteID             104808
#define kBanner1PageID      663262
#define kBanner2PageID      663531
#define kBanner3PageID      663530
#define kFormatID           15140

#define kBanner1Position    6
#define kBanner2Position    12
#define kBanner3Position    18
#define kNumberOfCells      40

#define kDefaultCellHeight  80

#define kDescriptionCellIdentifier  @"DescriptionCell"
#define kContentCellIdentifier      @"ContentCell"

@interface BannerInTableViewController ()

@property (nonatomic, strong) CustomBannerView *banner1;
@property (nonatomic, strong) CustomBannerView *banner2;
@property (nonatomic, strong) CustomBannerView *banner3;

@property (nonatomic, strong) UIView *stickyAdView;

@property (nonatomic, assign) CGFloat navigationBarTopOffset;
@property (nonatomic, assign) BOOL isObservingKeyPathHidden;

@end

@implementation BannerInTableViewController

/* WARNING:
 * Note that in this class, a lot of code in the following methods…
 * - (void)viewWillAppear:(BOOL)animated
 * - (void)viewWillDisappear:(BOOL)animated
 * - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
 *
 * …is only here to demonstrate how to handle "Stick to top" ads. You can skip this part if you don't plan to display such ads.
 */

#pragma mark - Object lifecycle

- (void)dealloc {
    [self removeBanners];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(createBanners) forControlEvents:UIControlEventValueChanged];
    
    // Create the banners
    [self createBanners];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Hide navigation bar on swipe gesture
    self.navigationController.hidesBarsOnSwipe = YES;
    
    // Add observer for hidden state changed. This will be usefull to animate "StickToTop" Adviews.
    if (!self.isObservingKeyPathHidden) {
        [self.navigationController.navigationBar addObserver:self forKeyPath:@"hidden" options:NSKeyValueObservingOptionNew context:NULL];
        self.isObservingKeyPathHidden = YES;
    }
    
    // Get initial top offset of the navigation bar
    self.navigationBarTopOffset = self.navigationController.navigationBar.frame.origin.y;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.hidesBarsOnSwipe = NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    // Remove key value observing
    if (self.isObservingKeyPathHidden) {
        [self.navigationController.navigationBar removeObserver:self forKeyPath:@"hidden"];
        self.isObservingKeyPathHidden = NO;
    }
}

- (void)createBanners {
    self.banner1 = [self createBanner:kBanner1PageID];
    self.banner2 = [self createBanner:kBanner2PageID];
    self.banner3 = [self createBanner:kBanner3PageID];
}

- (void)removeBanners {
    [self removeBanner:self.banner1];
    [self removeBanner:self.banner2];
    [self removeBanner:self.banner3];
}

- (CustomBannerView *)createBanner:(unsigned long)pageId {
    CustomBannerView *banner = [[CustomBannerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kDefaultCellHeight)];
    banner.delegate = self;
    banner.modalParentViewController = self;
    
    // To avoid having the parallax going below your navigation bar and your action bar, you can manually set the parallax infos.
    // Uncomment the code below if you want to manually set the viewport of your parallax.
    //
    // CGFloat topBarSize = YOUR_TOP_BAR_SIZE;
    // CGFloat bottomBarSize = YOUR_BOTTOM_BAR_SIZE;
    // CGFloat parallaxViewportHeight = [UIScreen mainScreen].bounds.size.height - topBarSize - bottomBarSize;
    // [banner setParallaxInfos:[[SASParallaxInfos alloc] initWithViewportTopOrigin:topBarSize viewportHeight:parallaxViewportHeight]];
    
    [banner loadWithPlacement:[SASAdPlacement adPlacementWithSiteId:kSiteID pageId:pageId formatId:kFormatID]];
    
    return banner;
}

- (void)removeBanner:(CustomBannerView *) banner {
    [banner removeFromSuperview];
    banner.modalParentViewController = nil;
    banner.delegate = nil;
    banner.loaded = NO;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kNumberOfCells;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (kBanner1Position == indexPath.row) {
        return [self.banner1 optimalAdViewHeightForContainer:tableView];
    } else if (kBanner2Position == indexPath.row) {
        return [self.banner2 optimalAdViewHeightForContainer:tableView];
    } else if (kBanner3Position == indexPath.row) {
        return [self.banner3 optimalAdViewHeightForContainer:tableView];
    } else {
        return kDefaultCellHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (kBanner1Position == indexPath.row) {
        return [SASAdViewContainerCell cellForAdView:self.banner1 inTableView:tableView];
    } else if (kBanner2Position == indexPath.row) {
        return [SASAdViewContainerCell cellForAdView:self.banner2 inTableView:tableView];
    } else if (kBanner3Position == indexPath.row) {
        return [SASAdViewContainerCell cellForAdView:self.banner3 inTableView:tableView];
    } else if (indexPath.row == 0) {
        // Configure description cell
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDescriptionCellIdentifier];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Deselect the cell if it's an ad to avoid messing with the ad creative.
    if (kBanner1Position == indexPath.row || kBanner2Position == indexPath.row || kBanner3Position == indexPath.row) {
        // Ad Cell was selected, nothing to do here.
    } else {
        // Your normal behavior on cell click like pushing a new VC
        [self pushNewViewController];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)pushNewViewController {
    UIViewController *controller = [[UIViewController alloc] init];
    controller.navigationItem.title = @"Details";
    controller.view.backgroundColor = self.view.backgroundColor;
    UILabel *label = [[UILabel alloc] initWithFrame:controller.view.bounds];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Detail view controller";
    [controller.view addSubview:label];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Observe navigation bar hidden state to animate sticky view if needed

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"hidden"] && self.stickyAdView) {
        UINavigationBar *navigationBar = self.navigationController.navigationBar;
        if (navigationBar.hidden == NO) {
            [UIView animateWithDuration:0.3 animations:^{
                CGRect newFrame = self.stickyAdView.frame;
                newFrame.origin.y = self.navigationBarTopOffset + CGRectGetHeight(navigationBar.frame);
                self.stickyAdView.frame = newFrame;
            }];
        } else {
            [UIView animateWithDuration:0.3 animations:^{
                CGRect newFrame = self.stickyAdView.frame;
                newFrame.origin.y = self.navigationBarTopOffset;
                self.stickyAdView.frame = newFrame;
            }];
        }
    }
}

#pragma mark - SASBannerView delegate

- (void)bannerView:(SASBannerView *)bannerView didDownloadAd:(SASAd *)ad {
    [self.tableView reloadData];
}

- (void)bannerViewDidLoad:(SASBannerView *)bannerView {
    NSLog(@"A Banner has been loaded");
    CustomBannerView *banner = (CustomBannerView *)bannerView;
    banner.loaded = YES;

    // Hide refresh control when all banners are fully loaded
    if (self.banner1.loaded && self.banner2.loaded && self.banner3.loaded) {
        [self.refreshControl endRefreshing];
    }
}

- (void)bannerView:(SASBannerView *)bannerView didFailToLoadWithError:(NSError *)error {
    NSLog(@"Banner has failed to load with error: %@", [error description]);
    CustomBannerView *banner = (CustomBannerView *)bannerView;
    banner.loaded = YES;
    
    // Hide refresh control when banners are fully loaded
    if (self.banner1.loaded && self.banner2.loaded && self.banner3.loaded) {
        [self.refreshControl endRefreshing];
    }
}

- (void)bannerView:(SASBannerView *)bannerView didSendVideoEvent:(SASVideoEvent)videoEvent {
    // This delegate can be used to listen for events if the ad is a video.
    
    // For instance, you can use these events to check if the video has been played until the end
    // by listening to the event 'SASVideoEventComplete'
    
    if (videoEvent == SASVideoEventComplete) {
        NSLog(@"The video has been played until the end");
    }
}

- (void)bannerView:(SASBannerView *)bannerView withStickyView:(UIView *)stickyView didStick:(BOOL)stuck withFrame:(CGRect)stickyFrame {
    // This delegate can be used to be notified when a video read banner did stick or unstick, in this implementation as the navigation bar appears / disappears during vertical swipe we need to animate the sticky view

    if (stuck) {
        // Keep a reference to the view to animate it if necessary
        self.stickyAdView = stickyView;
    } else {
        self.stickyAdView = nil;
    }
}

- (BOOL)bannerViewCanStickToTop:(SASBannerView *)bannerView {
    return YES;
}

@end
