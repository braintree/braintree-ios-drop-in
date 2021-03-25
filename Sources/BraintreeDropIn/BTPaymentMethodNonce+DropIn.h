#ifdef COCOAPODS
#import <Braintree/BraintreeCore.h>
#else
#import <BraintreeCore/BraintreeCore.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface BTPaymentMethodNonce (DropIn)

@property (nonatomic, copy, readonly) NSString *paymentDescription;

@end

NS_ASSUME_NONNULL_END
