#import <Foundation/Foundation.h>
#import <BraintreeDropIn/BTDropInRequest.h>
#import <Braintree/BraintreePaymentFlow.h>

extern NSString *BraintreeDemoSettingsEnvironmentDefaultsKey;
extern NSString *BraintreeDemoSettingsCustomEnvironmentURLDefaultsKey;
extern NSString *BraintreeDemoSettingsThreeDSecureRequiredDefaultsKey;
extern NSString *BraintreeDemoSettingsThreeDSecureVersionDefaultsKey;

typedef NS_ENUM(NSInteger, BraintreeDemoTransactionServiceEnvironment) {
    BraintreeDemoTransactionServiceEnvironmentSandboxBraintreeSampleMerchant = 0,
    BraintreeDemoTransactionServiceEnvironmentProductionExecutiveSampleMerchant = 1,
    BraintreeDemoTransactionServiceEnvironmentCustomMerchant = 2,
};

typedef NS_ENUM(NSInteger, BraintreeDemoTransactionServiceThreeDSecureRequiredStatus) {
    BraintreeDemoTransactionServiceThreeDSecureRequiredStatusDefault = 0,
    BraintreeDemoTransactionServiceThreeDSecureRequiredStatusRequired = 1,
    BraintreeDemoTransactionServiceThreeDSecureRequiredStatusNotRequired = 2,
};

@interface BraintreeDemoSettings : NSObject

+ (BraintreeDemoTransactionServiceEnvironment)currentEnvironment;
+ (NSString *)currentEnvironmentName;
+ (NSString *)currentEnvironmentURLString;
+ (NSString *)authorizationOverride;
+ (BOOL)useTokenizationKey;
+ (BraintreeDemoTransactionServiceThreeDSecureRequiredStatus)threeDSecureRequiredStatus;
+ (BTThreeDSecureVersion)threeDSecureRequestedVersion;
+ (BOOL)useModalPresentation;
+ (BOOL)customerPresent;
+ (NSString *)customerIdentifier;
+ (BOOL)paypalDisabled;
+ (BOOL)venmoDisabled;
+ (BOOL)maskSecurityCode;
+ (BTFormFieldSetting)cardholderNameSetting;
+ (BOOL)vaultCardSetting;
+ (BOOL)allowVaultCardOverrideSetting;

@end
