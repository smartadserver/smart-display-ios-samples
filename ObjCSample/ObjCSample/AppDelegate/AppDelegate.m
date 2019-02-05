//
//  AppDelegate.m
//  ObjCSample
//
//  Created by Julien Gomez on 16/10/2018.
//  Copyright © 2019 Smart AdServer. All rights reserved.
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
    /////////////////////////////////////////
    
    // NSString *myConsentString = @"yourCMPComputedConsentStringBase64format";
    // [[NSUserDefaults standardUserDefaults] setObject:myConsentString forKey:@"IABConsent_ConsentString"];
    // [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Some third party mediation SDK are not IAB compliant and don't rely on the consent string. Those SDK use
    // most of the time a binary consent for the advertising purpose.
    // If you are using one or more of those SDK through Smart mediation, you can set this binary consent for
    // all adapters at once by setting the string '1' (if the consent is granted) or '0' (if the consent is denied)
    // in NSUserDefault for the key 'Smart_advertisingConsentStatus'.
    // NSString *advertisingBinaryConsentString = @"1" or @"0";
    // [[NSUserDefaults standardUserDefaults] setObject:advertisingBinaryConsentString forKey:@"Smart_advertisingConsentStatus"];
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
