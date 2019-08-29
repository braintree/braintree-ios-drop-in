#import "BraintreeDemoAppDelegate.h"
#import "BraintreeDemoSettings.h"
#import "BraintreeDemoDemoContainmentViewController.h"
#import "BraintreeCore.h"
#import "BTDropInOverrides.h"
#import "BraintreePaymentFlow.h"

NSString *BraintreeDemoAppDelegatePaymentsURLScheme = @"com.braintreepayments.DropInDemo.payments";

@implementation BraintreeDemoAppDelegate

- (BOOL)application:(__unused UIApplication *)application didFinishLaunchingWithOptions:(__unused NSDictionary *)launchOptions {
    [self setupAppearance];
    [self registerDefaultsFromSettings];

    BraintreeDemoDemoContainmentViewController *rootViewController = [[BraintreeDemoDemoContainmentViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(__unused UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    if ([[url.scheme lowercaseString] isEqualToString:[BraintreeDemoAppDelegatePaymentsURLScheme lowercaseString]]) {
        return [BTAppSwitch handleOpenURL:url options:options];
    }
    return YES;
}

- (void)setupAppearance {
    UIColor *pleasantGray = [UIColor colorWithWhite:42/255.0f alpha:1.0f];

    [[UIToolbar appearance] setBarTintColor:pleasantGray];
    [[UIToolbar appearance] setBarStyle:UIBarStyleBlackTranslucent];
}

- (void)registerDefaultsFromSettings {
    // Check for testing arguments
    if ([[[NSProcessInfo processInfo] arguments] containsObject:@"-EnvironmentSandbox"]) {
        [[NSUserDefaults standardUserDefaults] setInteger:BraintreeDemoTransactionServiceEnvironmentSandboxBraintreeSampleMerchant forKey:BraintreeDemoSettingsEnvironmentDefaultsKey];
    } else if ([[[NSProcessInfo processInfo] arguments] containsObject:@"-EnvironmentProduction"]) {
        [[NSUserDefaults standardUserDefaults] setInteger:BraintreeDemoTransactionServiceEnvironmentProductionExecutiveSampleMerchant forKey:BraintreeDemoSettingsEnvironmentDefaultsKey];
    }

    if ([[[NSProcessInfo processInfo] arguments] containsObject:@"-ThreeDSecureRequired"]) {
        [[NSUserDefaults standardUserDefaults] setInteger:BraintreeDemoTransactionServiceThreeDSecureRequiredStatusRequired forKey:BraintreeDemoSettingsThreeDSecureRequiredDefaultsKey];
    } else if ([[[NSProcessInfo processInfo] arguments] containsObject:@"-ThreeDSecureDefault"]) {
        [[NSUserDefaults standardUserDefaults] setInteger:BraintreeDemoTransactionServiceThreeDSecureRequiredStatusDefault forKey:BraintreeDemoSettingsThreeDSecureRequiredDefaultsKey];
    }

    if ([[[NSProcessInfo processInfo] arguments] containsObject:@"-ThreeDSecureVersion2"]) {
        [[NSUserDefaults standardUserDefaults] setInteger:BTThreeDSecureVersion2 forKey:BraintreeDemoSettingsThreeDSecureVersionDefaultsKey];
    } else if ([[[NSProcessInfo processInfo] arguments] containsObject:@"-ThreeDSecureVersionLegacy"]) {
        [[NSUserDefaults standardUserDefaults] setInteger:BTThreeDSecureVersion1 forKey:BraintreeDemoSettingsThreeDSecureVersionDefaultsKey];
    }

    if ([[[NSProcessInfo processInfo] arguments] containsObject:@"-TokenizationKey"]) {
        [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"BraintreeDemoUseTokenizationKey"];
    } else if ([[[NSProcessInfo processInfo] arguments] containsObject:@"-ClientToken"]) {
        [[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:@"BraintreeDemoUseTokenizationKey"];
        // Use random users for testing with Client Tokens
        [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"BraintreeDemoCustomerPresent"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"BraintreeDemoCustomerIdentifier"];
    }

    if ([[[NSProcessInfo processInfo] arguments] containsObject:@"-CustomerIDWithVaultedPaymentMethods"]) {
        // Customer ID "123-edit-test" has vaulted payment methods
        [[NSUserDefaults standardUserDefaults] setObject:@"123-edit-test" forKey:@"BraintreeDemoCustomerIdentifier"];
    }

    [[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:@"BraintreeDemoDisablePayPal"];
    if ([[[NSProcessInfo processInfo] arguments] containsObject:@"-DisablePayPal"]) {
        [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"BraintreeDemoDisablePayPal"];
    }

    [[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:@"BraintreeDemoDisableVenmo"];
    if ([[[NSProcessInfo processInfo] arguments] containsObject:@"-DisableVenmo"]) {
        [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"BraintreeDemoDisableVenmo"];
    }

    [[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:@"BraintreeDemoMaskSecurityCode"];
    if ([[[NSProcessInfo processInfo] arguments] containsObject:@"-MaskSecurityCode"]) {
        [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"BraintreeDemoMaskSecurityCode"];
    }
    
    [[NSUserDefaults standardUserDefaults] setInteger:BTFormFieldDisabled forKey:@"BraintreeDemoCardholderNameSetting"];
    if ([[[NSProcessInfo processInfo] arguments] containsObject:@"-CardholderNameAccepted"]) {
        [[NSUserDefaults standardUserDefaults] setInteger:BTFormFieldOptional forKey:@"BraintreeDemoCardholderNameSetting"];
    } else if ([[[NSProcessInfo processInfo] arguments] containsObject:@"-CardholderNameRequired"]) {
        [[NSUserDefaults standardUserDefaults] setInteger:BTFormFieldRequired forKey:@"BraintreeDemoCardholderNameSetting"];
    }

    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"BraintreeDemoAllowVaultCardOverrideSetting"];
    if ([[[NSProcessInfo processInfo] arguments] containsObject:@"-SaveCardToggleVisible"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"BraintreeDemoAllowVaultCardOverrideSetting"];
    }

    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"BraintreeDemoVaultCardSetting"];
    if ([[[NSProcessInfo processInfo] arguments] containsObject:@"-VaultCardIsFalse"]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"BraintreeDemoVaultCardSetting"];
    }

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"BraintreeTest_ForceVenmoDisplay"];
    if ([[[NSProcessInfo processInfo] arguments] containsObject:@"-ForceVenmo"]) {
        [BTDropInOverrides setDisplayVenmoOption:YES];
    }

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"BraintreeDemoSettingsAuthorizationOverride"];
    for (NSString* arg in [[NSProcessInfo processInfo] arguments]) {
        if ([arg rangeOfString:@"-Authorization:"].location != NSNotFound) {
            NSString* testIntegration = [arg stringByReplacingOccurrencesOfString:@"-Authorization:" withString:@""];
            [[NSUserDefaults standardUserDefaults] setObject:testIntegration forKey:@"BraintreeDemoSettingsAuthorizationOverride"];
        }
    }

    if ([[[NSProcessInfo processInfo] arguments] containsObject:@"-BadUrlScheme"]) {
        [BTAppSwitch setReturnURLScheme:@"com.braintreepayments.bad.scheme"];
    } else {
        [BTAppSwitch setReturnURLScheme:BraintreeDemoAppDelegatePaymentsURLScheme];
    }

    // End checking for testing arguments

    NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    if(!settingsBundle) {
        NSLog(@"Could not find Settings.bundle");
        return;
    }

    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
    NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];
    
    NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
    for (NSDictionary *prefSpecification in preferences) {
        NSString *key = [prefSpecification objectForKey:@"Key"];
        if(key && [[prefSpecification allKeys] containsObject:@"DefaultValue"]) {
            [defaultsToRegister setObject:[prefSpecification objectForKey:@"DefaultValue"] forKey:key];
        }
    }
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsToRegister];
}

@end
