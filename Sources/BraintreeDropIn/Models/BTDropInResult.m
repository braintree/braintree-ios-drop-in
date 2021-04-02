#import <BraintreeDropIn/BTDropInResult.h>
#import "BTAPIClient_Internal_Category.h"
#import "BTPaymentMethodNonce+DropIn.h"
#import "BTUIKViewUtil.h"
#import "BTUIKVectorArtView.h"
#import "BTUIKPaymentOptionCardView.h"

#ifdef COCOAPODS
#import <Braintree/BraintreeCore.h>
#else
#import <BraintreeCore/BraintreeCore.h>
#endif

NSString *const BTDropInResultErrorDomain = @"com.braintreepayments.BTDropInResultErrorDomain";

@implementation BTDropInResult

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

+ (void)mostRecentPaymentMethodForClientToken:(NSString *)clientToken handler:(BTDropInResultFetchHandler)handler {
    BTAPIClient *apiClient = [[BTAPIClient alloc] initWithAuthorization:clientToken sendAnalyticsEvent:NO];
    apiClient = [apiClient copyWithSource:apiClient.metadata.source integration:BTClientMetadataIntegrationDropIn2];
    [BTDropInResult mostRecentPaymentMethodForAPIClient:apiClient handler:handler];
}

+ (void)mostRecentPaymentMethodForAPIClient:(BTAPIClient * _Nullable)apiClient handler:(BTDropInResultFetchHandler)handler {
    BTUIKPaymentOptionType lastSelectedPaymentOptionType = [BTDropInResult.userDefaults integerForKey:@"BT_dropInLastSelectedPaymentMethodType"];
    if (lastSelectedPaymentOptionType == BTUIKPaymentOptionTypeApplePay) {
        BTDropInResult *result = [BTDropInResult new];
        result.paymentOptionType = lastSelectedPaymentOptionType;
        handler(result, nil);
        return;
    }

    if (!apiClient) {
        NSError *error = [[NSError alloc] initWithDomain:BTDropInResultErrorDomain
                                                    code:BTDropInErrorTypeAuthorization
                                                userInfo:@{NSLocalizedDescriptionKey: @"Invalid authorization"}];
        handler(nil, error);
        return;
    }

    [apiClient fetchPaymentMethodNonces:NO completion:^(NSArray<BTPaymentMethodNonce *> *paymentMethodNonces, NSError *error) {
        if (error) {
            handler(nil, error);
            return;
        }

        BTDropInResult *result;
        if (paymentMethodNonces.count > 0) {
            result = [BTDropInResult new];
            BTPaymentMethodNonce *paymentMethod = paymentMethodNonces.firstObject;
            result.paymentOptionType = [BTUIKViewUtil paymentOptionTypeForPaymentInfoType:paymentMethod.type];
            result.paymentMethod = paymentMethod;
        }

        handler(result, nil);
    }];
}

- (UIView *)paymentIcon {
    BTUIKPaymentOptionCardView *paymentOptionCardView = [BTUIKPaymentOptionCardView new];
    paymentOptionCardView.paymentOptionType = self.paymentOptionType;
    return paymentOptionCardView;
}

- (NSString *)paymentDescription {
    if (self.paymentOptionType == BTUIKPaymentOptionTypeApplePay) {
        return @"Apple Pay";
    } else {
        return self.paymentMethod.paymentDescription;
    }
}

@end
