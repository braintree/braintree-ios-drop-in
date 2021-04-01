#import <BraintreeDropIn/BTDropInRequest.h>
#import "BTConfiguration+DropIn.h"

#ifdef COCOAPODS
#import <Braintree/BraintreeCore.h>
#else
#import <BraintreeCore/BraintreeCore.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface BTPaymentMethodNonce (DropIn)

@property (nonatomic, copy, readonly) NSString *paymentDescription;

- (BOOL)shouldDisplayVaultedNonceForRequest:(BTDropInRequest *)request config:(BTConfiguration *)configuration;

@end

NS_ASSUME_NONNULL_END
