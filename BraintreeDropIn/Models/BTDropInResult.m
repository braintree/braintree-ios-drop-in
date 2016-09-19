#import "BTDropInResult.h"

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

- (UIView *)paymentIcon {
    return [BTUIKViewUtil vectorArtViewForPaymentOptionType:self.paymentOptionType];
}

- (NSString *)paymentDescription {
    if (self.paymentMethod != nil) {
        return self.paymentMethod.localizedDescription;
    } else if (self.paymentOptionType == BTUIKPaymentOptionTypeApplePay) {
        return [BTUIKLocalizedString PAYMENT_METHOD_TYPE_APPLE_PAY];
    }
    return @"";
}

@end
