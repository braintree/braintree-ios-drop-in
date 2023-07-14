#import <BraintreeDropIn/BTDropInResult.h>
#import "BTUIKViewUtil.h"
#import "BTUIKVectorArtView.h"
#import "BTUIKPaymentOptionCardView.h"

// Import BraintreeDataCollector (Swift) module
#if __has_include(<Braintree/Braintree-Swift.h>)      // CocoaPods
#import <Braintree/Braintree-Swift.h>

#else                                                // SPM
/* Use @import for SPM support
 * See https://forums.swift.org/t/using-a-swift-package-in-a-mixed-swift-and-objective-c-project/27348
 */
@import BraintreeDataCollector;
@import BraintreeCore;
@import BraintreeCard;
@import BraintreePayPal;
@import BraintreeVenmo;
@import BraintreeApplePay;

#endif

NSString *const BTDropInResultErrorDomain = @"com.braintreepayments.BTDropInResultErrorDomain";

@implementation BTDropInResult

// For testing
static Class BraintreeDataCollectorClass;
static NSString *BraintreeDataCollectorClassString = @"BTDataCollector";

- (instancetype)init {
    self = [super init];
    if (self) {
// TODO: we need to move data collection somewhere else. Maybe into another method? Commenting our for now.
//        // If we are testing we want to set BraintreeDataCollectorClass to the class passed in `setBraintreeDataCollectorClass`
//        if (BraintreeDataCollectorClass != NSClassFromString(BraintreeDataCollectorClassString)) {
//            _deviceData = [BraintreeDataCollectorClass collectDeviceData];
//            return self;
//        }
//        // Otherwise we should use `BTDataCollector` to collect device data
//        _deviceData = [BTDataCollector collectDeviceData];
    }

    return self;
}

- (instancetype)initWithEnvironment:(NSString *)environment {
    self = [super init];
    if (self) {
// TODO: we need to move data collection somewhere else. Maybe into another method? Commenting our for now.
//        // If we are testing we want to set PayPalDataCollectorClass to the class passed in `setPayPalDataCollectorClass`
//        if (PayPalDataCollectorClass != NSClassFromString(PayPalDataCollectorClassString)) {
//            BOOL isSandbox = [environment isEqualToString:@"sandbox"];
//            _deviceData = [PayPalDataCollectorClass collectPayPalDeviceDataWithIsSandbox:isSandbox];
//            return self;
//        }
//        // Otherwise we should use `PPDataCollector` to collect device data
//        BOOL isSandbox = [environment isEqualToString:@"sandbox"];
//        _deviceData = [PPDataCollector collectPayPalDeviceDataWithIsSandbox:isSandbox];
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
    BTAPIClient *apiClient = [[BTAPIClient alloc] initWithAuthorization:clientToken];
    apiClient.metadata.integration = BTClientMetadataIntegrationDropIn;
    [BTDropInResult mostRecentPaymentMethodForAPIClient:apiClient completion:completion];
}

+ (void)mostRecentPaymentMethodForAPIClient:(BTAPIClient * _Nullable)apiClient
                                 completion:(void (^)(BTDropInResult *result, NSError *error))completion {
    
    if (!apiClient) {
        NSError *error = [[NSError alloc] initWithDomain:BTDropInResultErrorDomain
                                                    code:BTDropInErrorTypeAuthorization
                                                userInfo:@{NSLocalizedDescriptionKey: @"Invalid authorization"}];
        completion(nil, error);
        return;
    }
    
    [apiClient fetchOrReturnRemoteConfiguration:^(BTConfiguration *configuration, NSError *error) {
        __block BTDropInResult *result;
        
        if (error != nil) {
            completion(nil, error);
            return;
        }
        
        BTDropInPaymentMethodType lastSelectedPaymentOptionType = [BTDropInResult.userDefaults integerForKey:@"BT_dropInLastSelectedPaymentMethodType"];
        if (lastSelectedPaymentOptionType == BTDropInPaymentMethodTypeApplePay) {
            result = [[BTDropInResult alloc] initWithEnvironment:configuration.environment];
            result.paymentMethodType = lastSelectedPaymentOptionType;
            completion(result, nil);
            return;
        }

        [apiClient fetchPaymentMethodNonces:NO completion:^(NSArray<BTPaymentMethodNonce *> *paymentMethodNonces, NSError *error) {
            if (error) {
                completion(nil, error);
                return;
            }

            if (paymentMethodNonces.count == 0 || paymentMethodNonces == nil) {
                NSError *error = [[NSError alloc] initWithDomain:BTDropInResultErrorDomain
                                                            code:BTDropInErrorTypeNoRecentPaymentMethods
                                                        userInfo:@{NSLocalizedDescriptionKey: @"No recent payment methods found."}];
                completion(nil, error);
                return;
            } else {
                result = [[BTDropInResult alloc] initWithEnvironment:configuration.environment];
                BTPaymentMethodNonce *paymentMethod = paymentMethodNonces.firstObject;
                result.paymentMethodType = [BTUIKViewUtil paymentMethodTypeForPaymentInfoType:paymentMethod.type];
                result.paymentMethod = paymentMethod;
                completion(result, nil);
                return;
            }
        }];
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
        return [self paymentDescription:self.paymentMethod];
    }
}

- (NSString *)paymentDescription:(BTPaymentMethodNonce *)paymentMethodNonce {
    if ([paymentMethodNonce isKindOfClass:[BTCardNonce class]]) {
        return ((BTCardNonce *)self).lastFour;
    } else if ([paymentMethodNonce isKindOfClass:[BTPayPalAccountNonce class]]) {
        return ((BTPayPalAccountNonce *)self).email;
    } else if ([paymentMethodNonce isKindOfClass:[BTVenmoAccountNonce class]]) {
        return ((BTVenmoAccountNonce *)self).username;
    } else if ([paymentMethodNonce isKindOfClass:[BTApplePayCardNonce class]]) {
        return @"Apple Pay";
    } else {
        return @"";
    }
}

@end
