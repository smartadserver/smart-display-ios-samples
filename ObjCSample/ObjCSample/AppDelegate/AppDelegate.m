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

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /////////////////////////////////////////
    // TRACKING AUTHORIZATION
    /////////////////////////////////////////
    
    // Starting with iOS 14, the SDK need the user's consent before being able to access the IDFA.
    // Check the MasterViewController class to check how to request this consent…
    
    /////////////////////////////////////////
    // Smart Display Kit Configuration
    /////////////////////////////////////////
    
    // The site ID must be set before using the SDK, otherwise no ad will be retrieved.
    [[SASConfiguration sharedInstance] configureWithSiteId:kSiteID];
    
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
    
    /////////////////////////////////////////
    // SDK - TCF Compliance
    // OPTIONAL
    // By uncommenting the following code, you can set the TCF consent string manually.
    // As per IAB specifications in Transparency And Consent Framework.
    // Smart Display SDK will retrieve the TCF consent string from the NSUserDefaults using the official IAB key "IABTCF_TCString"
    /////////////////////////////////////////
    // If you are using a CMP that is not validated by the IAB or not using the official key:
    // you will have to manually store the computed consent string into the NSUserDefaults for Smart Display SDK to retrieve it and forward it to its partners.
    /////////////////////////////////////////
    //NSString *myTCFConsentString = @"yourCMPComputedConsentStringBase64format";
    //[[NSUserDefaults standardUserDefaults] setObject:myTCFConsentString forKey:@"IABTCF_TCString"];
    //[[NSUserDefaults standardUserDefaults] synchronize];
    
    // Some third party mediation SDK are not IAB compliant and don't rely on the TCF consent string. Those SDK use
    // most of the time a binary consent for the advertising purpose.
    // If you are using one or more of those SDK through Smart mediation, you can set this binary consent for
    // all adapters at once by setting the string '1' (if the consent is granted) or '0' (if the consent is denied)
    // in NSUserDefault for the key 'Smart_advertisingConsentStatus'.
    // NSString *advertisingBinaryConsentString = @"1" or @"0";
    // [[NSUserDefaults standardUserDefaults] setObject:advertisingBinaryConsentString forKey:@"Smart_advertisingConsentStatus"];
    // [[NSUserDefaults standardUserDefaults] synchronize];
    
    /////////////////////////////////////////
    // SDK - CCPA Compliance
    // OPTIONAL
    // By uncommenting the following code, you can set the CCPA consent string manually.
    // As per IAB specifications in CCPA Compliance Framework.
    // Smart Display SDK will retrieve the CCPA consent string from the NSUserDefaults using the official IAB key "IABUSPrivacy_String"
    /////////////////////////////////////////
    // If you are using a CMP that is not validated by the IAB or not using the official key:
    // you will have to manually store the computed consent string into the NSUserDefaults for Smart Display SDK to retrieve it and forward it to its partners.
    /////////////////////////////////////////
    //NSString *myCCPAConsentString = @"yourCCPAConsentString";
    //[[NSUserDefaults standardUserDefaults] setObject:myCCPAConsentString forKey:@"IABUSPrivacy_String"];
    //[[NSUserDefaults standardUserDefaults] synchronize];
    
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
