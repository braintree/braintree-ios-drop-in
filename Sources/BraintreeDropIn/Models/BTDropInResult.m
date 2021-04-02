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

@implementation BTDropInResult

#pragma mark - Prefetch BTDropInResult

+ (void)fetchDropInResultForAuthorization:(NSString *)authorization handler:(BTDropInResultFetchHandler)handler {
    BTDropInPaymentMethodType lastSelectedPaymentOptionType = [[NSUserDefaults standardUserDefaults] integerForKey:@"BT_dropInLastSelectedPaymentMethodType"];
    __block BTAPIClient *apiClient = [[BTAPIClient alloc] initWithAuthorization:authorization sendAnalyticsEvent:NO];
    apiClient = [apiClient copyWithSource:apiClient.metadata.source integration:BTClientMetadataIntegrationDropIn2];

    [apiClient fetchPaymentMethodNonces:NO completion:^(NSArray<BTPaymentMethodNonce *> *paymentMethodNonces, NSError *error) {
        if (error != nil) {
            handler(nil, error);
        } else {
            BTDropInResult *result = [BTDropInResult new];
            if (lastSelectedPaymentOptionType == BTDropInPaymentMethodTypeApplePay) {
                result.paymentMethodType = lastSelectedPaymentOptionType;
            } else if (paymentMethodNonces != nil && paymentMethodNonces.count > 0) {
                BTPaymentMethodNonce *paymentMethod = paymentMethodNonces.firstObject;
                result.paymentMethodType = [BTUIKViewUtil paymentOptionTypeForPaymentInfoType:paymentMethod.type];
                result.paymentMethod = paymentMethod;
            }
            handler(result, error);
        }
        apiClient = nil;
    }];
}

- (UIView *)paymentIcon {
    BTUIKPaymentOptionCardView *paymentOptionCardView = [BTUIKPaymentOptionCardView new];
    paymentOptionCardView.paymentOptionType = self.paymentMethodType;
    return paymentOptionCardView;
}

- (NSString *)paymentDescription {
    if (self.paymentMethodType == BTDropInPaymentMethodTypeApplePay) {
        return @"Apple Pay";
    } else {
        return self.paymentMethod.paymentDescription;
    }
}

@end
