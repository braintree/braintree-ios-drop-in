#import <BraintreeDropIn/BTDropInRequest.h>
#import "BTConfiguration+DropIn.h"

#if __has_include(<Braintree/BraintreeCore.h>) // CocoaPods
#import <Braintree/BraintreeCore.h>
#else
#import <BraintreeCore/BraintreeCore.h>
#endif

NS_ASSUME_NONNULL_BEGIN

__attribute__((deprecated("BraintreeDropIn is deprecated. Use the Braintre SDK instead. See https://developer.paypal.com/braintree/docs/guides/client-sdk/setup/ for more information.")))
@interface BTPaymentMethodNonce (DropIn)

@property (nonatomic, copy, readonly) NSString *paymentDescription;

- (BOOL)shouldDisplayVaultedNonceForRequest:(BTDropInRequest *)request config:(BTConfiguration *)configuration;

@end

NS_ASSUME_NONNULL_END
