#import "BTPaymentMethodNonce+DropIn.h"

#ifdef COCOAPODS
#import <Braintree/BTCardNonce.h>
#import <Braintree/BTPayPalAccountNonce.h>
#import <Braintree/BTVenmoAccountNonce.h>
#else
#import <BraintreeCard/BTCardNonce.h>
#import <BraintreePayPal/BTPayPalAccountNonce.h>
#import <BraintreeVenmo/BTVenmoAccountNonce.h>
#endif

@implementation BTPaymentMethodNonce (DropIn)

- (NSString *)paymentDescription {
    if ([self isKindOfClass:[BTCardNonce class]]) {
        return [NSString stringWithFormat:@"••• ••%@", ((BTCardNonce *)self).lastTwo ?: @""];
    } else if ([self isKindOfClass:[BTPayPalAccountNonce class]]) {
        return ((BTPayPalAccountNonce *)self).email;
    } else if ([self isKindOfClass:[BTVenmoAccountNonce class]]) {
        return ((BTVenmoAccountNonce *)self).username;
    } else {
        return @"";
    }
}

@end
