#import "BraintreeDemoSettings.h"

NSString *BraintreeDemoSettingsEnvironmentDefaultsKey = @"BraintreeDemoSettingsEnvironmentDefaultsKey";
NSString *BraintreeDemoSettingsCustomEnvironmentURLDefaultsKey = @"BraintreeDemoSettingsCustomEnvironmentURLDefaultsKey";
NSString *BraintreeDemoSettingsThreeDSecureRequiredDefaultsKey = @"BraintreeDemoSettingsThreeDSecureRequiredDefaultsKey";
NSString *BraintreeDemoSettingsThreeDSecureVersionDefaultsKey = @"BraintreeDemoSettingsThreeDSecureVersionDefaultsKey";

@implementation BraintreeDemoSettings

+ (BraintreeDemoTransactionServiceEnvironment)currentEnvironment {
    return [[NSUserDefaults standardUserDefaults] integerForKey:BraintreeDemoSettingsEnvironmentDefaultsKey];
}

+ (NSString *)currentEnvironmentName {
    BraintreeDemoTransactionServiceEnvironment env = [self currentEnvironment];
    switch (env) {
        case BraintreeDemoTransactionServiceEnvironmentSandboxBraintreeSampleMerchant:
            return @"Sandbox";
        case BraintreeDemoTransactionServiceEnvironmentProductionExecutiveSampleMerchant:
            return @"Production";
        case BraintreeDemoTransactionServiceEnvironmentCustomMerchant: {
            NSString *shortTitle = [[NSUserDefaults standardUserDefaults] stringForKey:BraintreeDemoSettingsCustomEnvironmentURLDefaultsKey];
            shortTitle = [[shortTitle stringByReplacingOccurrencesOfString:@"http://" withString:@""] stringByReplacingOccurrencesOfString:@"https://" withString:@""];
            return shortTitle;
        }
    }
    return @"(invalid)";
}

+ (NSString *)currentEnvironmentURLString {
    switch ([self currentEnvironment]) {
        case BraintreeDemoTransactionServiceEnvironmentSandboxBraintreeSampleMerchant:
            return @"https://braintree-sample-merchant.herokuapp.com";
        case BraintreeDemoTransactionServiceEnvironmentProductionExecutiveSampleMerchant:
            return @"https://executive-sample-merchant.herokuapp.com";
        case BraintreeDemoTransactionServiceEnvironmentCustomMerchant:
            return [[NSUserDefaults standardUserDefaults] stringForKey:BraintreeDemoSettingsCustomEnvironmentURLDefaultsKey];
    }
}

+ (NSString *)authorizationOverride {
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"BraintreeDemoSettingsAuthorizationOverride"];
}

+ (BOOL)useTokenizationKey {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"BraintreeDemoUseTokenizationKey"];
}

+ (BraintreeDemoTransactionServiceThreeDSecureRequiredStatus)threeDSecureRequiredStatus {
    return [[NSUserDefaults standardUserDefaults] integerForKey:BraintreeDemoSettingsThreeDSecureRequiredDefaultsKey];
}

+ (BTThreeDSecureVersion)threeDSecureRequestedVersion {
    return [[NSUserDefaults standardUserDefaults]
        integerForKey:BraintreeDemoSettingsThreeDSecureVersionDefaultsKey];
}

+ (BOOL)useModalPresentation {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"BraintreeDemoChooserViewControllerShouldUseModalPresentationDefaultsKey"];
}

+ (BOOL)customerPresent {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"BraintreeDemoCustomerPresent"];
}

+ (NSString *)customerIdentifier {
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"BraintreeDemoCustomerIdentifier"];
}

+ (BOOL)paypalDisabled {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"BraintreeDemoDisablePayPal"];
}

+ (BOOL)venmoDisabled {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"BraintreeDemoDisableVenmo"];
}

+ (BOOL)maskSecurityCode {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"BraintreeDemoMaskSecurityCode"];
}

+ (BTFormFieldSetting)cardholderNameSetting {
    return [NSUserDefaults.standardUserDefaults integerForKey:@"BraintreeDemoCardholderNameSetting"];
}

+ (BOOL)vaultCardSetting {
    return [NSUserDefaults.standardUserDefaults boolForKey:@"BraintreeDemoVaultCardSetting"];
}

+ (BOOL)allowVaultCardOverrideSetting {
    return [NSUserDefaults.standardUserDefaults boolForKey:@"BraintreeDemoAllowVaultCardOverrideSetting"];
}

@end
