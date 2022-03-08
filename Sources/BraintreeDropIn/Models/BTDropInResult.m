#import <BraintreeDropIn/BTDropInResult.h>
#import "BTAPIClient_Internal_Category.h"
#import "BTPaymentMethodNonce+DropIn.h"
#import "BTUIKViewUtil.h"
#import "BTUIKVectorArtView.h"
#import "BTUIKPaymentOptionCardView.h"

#if __has_include(<Braintree/BraintreeCore.h>) // CocoaPods
#import <Braintree/BraintreeCore.h>
#else
#import <BraintreeCore/BraintreeCore.h>
#endif

// Import PayPalDataCollector (Swift) module
#if __has_include(<Braintree/Braintree-Swift.h>)      // CocoaPods
#import <Braintree/Braintree-Swift.h>

#elif SWIFT_PACKAGE                                   // SPM
/* Use @import for SPM support
 * See https://forums.swift.org/t/using-a-swift-package-in-a-mixed-swift-and-objective-c-project/27348
 */
@import PayPalDataCollector;

#elif __has_include("Braintree-umbrella.h")              // CocoaPods for ReactNative
/* Use quoted style when importing Swift headers for ReactNative support
 * See https://github.com/braintree/braintree_ios/issues/671
 */
@import Braintree;

#else                                                 // Carthage
#import <PayPalDataCollector/PayPalDataCollector-Swift.h>
#endif

NSString *const BTDropInResultErrorDomain = @"com.braintreepayments.BTDropInResultErrorDomain";

@implementation BTDropInResult

// For testing
static Class PayPalDataCollectorClass;
static NSString *PayPalDataCollectorClassString = @"PPDataCollector";

- (instancetype)init {
    self = [super init];
    if (self) {
        _deviceData = [PayPalDataCollectorClass collectPayPalDeviceData];
    }

    return self;
}

#pragma mark - Prefetch BTDropInResult

static NSUserDefaults *_userDefaults = nil;

+ (NSUserDefaults *)userDefaults {
    if (_userDefaults == nil) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return _userDefaults;
}

+ (void)setUserDefaults:(NSUserDefaults *)userDefaults {
    if (userDefaults != _userDefaults) {
        _userDefaults = userDefaults;
    }
}

+ (void)mostRecentPaymentMethodForClientToken:(NSString *)clientToken
                                   completion:(void (^)(BTDropInResult *result, NSError *error))completion {
    BTAPIClient *apiClient = [[BTAPIClient alloc] initWithAuthorization:clientToken sendAnalyticsEvent:NO];
    apiClient = [apiClient copyWithSource:apiClient.metadata.source integration:BTClientMetadataIntegrationDropIn2];
    [BTDropInResult mostRecentPaymentMethodForAPIClient:apiClient completion:completion];
}

+ (void)mostRecentPaymentMethodForAPIClient:(BTAPIClient * _Nullable)apiClient
                                 completion:(void (^)(BTDropInResult *result, NSError *error))completion {
    BTDropInPaymentMethodType lastSelectedPaymentOptionType = [BTDropInResult.userDefaults integerForKey:@"BT_dropInLastSelectedPaymentMethodType"];
    if (lastSelectedPaymentOptionType == BTDropInPaymentMethodTypeApplePay) {
        BTDropInResult *result = [BTDropInResult new];
        result.paymentMethodType = lastSelectedPaymentOptionType;
        completion(result, nil);
        return;
    }

    if (!apiClient) {
        NSError *error = [[NSError alloc] initWithDomain:BTDropInResultErrorDomain
                                                    code:BTDropInErrorTypeAuthorization
                                                userInfo:@{NSLocalizedDescriptionKey: @"Invalid authorization"}];
        completion(nil, error);
        return;
    }

    [apiClient fetchPaymentMethodNonces:NO completion:^(NSArray<BTPaymentMethodNonce *> *paymentMethodNonces, NSError *error) {
        if (error) {
            completion(nil, error);
            return;
        }

        BTDropInResult *result;
        if (paymentMethodNonces.count > 0) {
            result = [BTDropInResult new];
            BTPaymentMethodNonce *paymentMethod = paymentMethodNonces.firstObject;
            result.paymentMethodType = [BTUIKViewUtil paymentMethodTypeForPaymentInfoType:paymentMethod.type];
            result.paymentMethod = paymentMethod;
        }

        completion(result, nil);
    }];
}

- (UIView *)paymentIcon {
    BTUIKPaymentOptionCardView *paymentOptionCardView = [BTUIKPaymentOptionCardView new];
    paymentOptionCardView.paymentMethodType = self.paymentMethodType;
    return paymentOptionCardView;
}

- (NSString *)paymentDescription {
    if (self.paymentMethodType == BTDropInPaymentMethodTypeApplePay) {
        return @"Apple Pay";
    } else {
        return self.paymentMethod.paymentDescription;
    }
}

#pragma mark - Test Helpers

+ (void)setPayPalDataCollectorClass:(Class)payPalDataCollectorClass {
    PayPalDataCollectorClass = payPalDataCollectorClass;
}

@end
