//
//  AppDelegate.m
//  ObjCSample
//
//  Created by Julien Gomez on 16/10/2018.
//  Copyright (c) 2018 Smart AdServer. All rights reserved.
//

#import "AppDelegate.h"
#import <SASDisplayKit/SASDisplayKit.h>

#define kSiteID 104808
#define kBaseURL @"https://mobile.smartadserver.com"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /////////////////////////////////////////
    // Smart Display Kit Configuration
    /////////////////////////////////////////
    
    // The site ID and the base URL must be set before using the SDK, otherwise no ad will be retrieved.
    [[SASConfiguration sharedInstance] configureWithSiteId:kSiteID baseURL:kBaseURL];
    
    // Enabling logging can be useful to get information if ads are not displayed properly.
    // Don't forget to turn the logging OFF before submitting to the App Store.
    // [SASConfiguration sharedInstance].loggingEnabled = YES;
    
    /////////////////////////////////////////
    // GDPR Consent String - Manual setting
    /////////////////////////////////////////
    // By uncommenting the following code, you can set the GDPR consent string manually.
    // Smart Display SDK will retrieve the consent string from the NSUserDefaults using the
    // official IAB key "IABConsent_ConsentString" as per IAB recommandations.
    // If you are using SmartCMP SDK, this step is not required since SmartCMP already complies
    // with IAB specifications and stores the consent string using the official key.
    // If you are using any other CMP that is not validated by the IAB and not using the official
    // key, you will have to manually store the computed consent string into the NSUserDefaults for
    // Smart Display SDK to retrieve it and pass it to its partners.
    /////////////////////////////////////////
    
    // NSString *myConsentString = @"yourCMPComputedConsentStringBase64format";
    // [[NSUserDefaults standardUserDefaults] setObject:myConsentString forKey:@"IABConsent_ConsentString"];
    // [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url {
    
    // Activating Live Preview:
    // -> Add the corresponding URL Type in your Info.plist
    // -> Check the documentation for more information about this feature
    
    NSString *sasSchemeWithSiteID = [NSString stringWithFormat:@"sas%i", kSiteID];
    
    if ([[url scheme] isEqualToString:sasSchemeWithSiteID]) {
        return [[SASConfiguration sharedInstance] handleLivePreviewURL:url];
    }
    
    //Add your own logic here…
    
    return NO;
}

@end
