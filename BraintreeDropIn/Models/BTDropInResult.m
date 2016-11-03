#import "BTDropInResult.h"
#import "BTAPIClient_Internal_Category.h"
#if __has_include("BraintreeCore.h")
#import "BraintreeCore.h"
#else
#import <BraintreeCore/BraintreeCore.h>
#endif
#if __has_include("BraintreeUIKit.h")
#import "BraintreeUIKit.h"
#else
#import <BraintreeUIKit/BraintreeUIKit.h>
#endif

@implementation BTDropInResult

#pragma mark - Prefetch BTDropInResult

+ (void)fetchDropInResultForAuthorization:(NSString *)authorization handler:(BTDropInResultFetchHandler)handler {
    BTUIKPaymentOptionType lastSelectedPaymentOptionType = [[NSUserDefaults standardUserDefaults] integerForKey:@"BT_dropInLastSelectedPaymentMethodType"];
    __block BTAPIClient *apiClient = [[BTAPIClient alloc] initWithAuthorization:authorization sendAnalyticsEvent:NO];
    apiClient = [apiClient copyWithSource:apiClient.metadata.source integration:BTClientMetadataIntegrationDropIn2];

    [apiClient fetchPaymentMethodNonces:NO completion:^(NSArray<BTPaymentMethodNonce *> *paymentMethodNonces, NSError *error) {
        if (error != nil) {
            handler(nil, error);
        } else {
            BTDropInResult *result = [BTDropInResult new];
            if (lastSelectedPaymentOptionType == BTUIKPaymentOptionTypeApplePay) {
                result.paymentOptionType = lastSelectedPaymentOptionType;
            } else if (paymentMethodNonces != nil && paymentMethodNonces.count > 0) {
                BTPaymentMethodNonce *paymentMethod = paymentMethodNonces.firstObject;
                result.paymentOptionType = [BTUIKViewUtil paymentOptionTypeForPaymentInfoType:paymentMethod.type];
                result.paymentMethod = paymentMethod;
            }
            handler(result, error);
        }
        apiClient = nil;
    }];
}

- (UIView *)paymentIcon {
    return [BTUIKViewUtil vectorArtViewForPaymentOptionType:self.paymentOptionType];
}

- (NSString *)paymentDescription {
    if (self.paymentMethod != nil) {
        return self.paymentMethod.localizedDescription;
    } else if (self.paymentOptionType == BTUIKPaymentOptionTypeApplePay) {
        return BTUIKLocalizedString(BRANDING_APPLE_PAY);
    }
    return @"";
}

@end
