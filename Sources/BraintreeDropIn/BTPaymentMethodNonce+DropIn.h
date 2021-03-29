#ifdef COCOAPODS
#import <Braintree/BraintreeCore.h>
#else
#import <BraintreeCore/BraintreeCore.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface BTPaymentMethodNonce (DropIn)

// TODO - Move this to BTDropInResult; when Apple Pay is selected on Drop-In, nonce is null, so there is never a description.
@property (nonatomic, copy, readonly) NSString *paymentDescription;

@end

NS_ASSUME_NONNULL_END
