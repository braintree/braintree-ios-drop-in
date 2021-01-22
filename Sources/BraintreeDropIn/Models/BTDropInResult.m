#import <BraintreeDropIn/BTDropInResult.h>
#import "BTAPIClient_Internal_Category.h"
#import "BTPaymentMethodNonce+DropIn.h"

#ifdef COCOAPODS
#import <BraintreeDropIn/BraintreeUIKit.h>
#import <Braintree/BraintreeCore.h>
#else
#import <BraintreeUIKit/BraintreeUIKit.h>
#import <BraintreeCore/BraintreeCore.h>
#endif

#ifdef COCOAPODS
#import <BraintreeDropIn/BraintreeUIKit.h>
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
    return self.paymentMethod.paymentDescription;
}

@end
