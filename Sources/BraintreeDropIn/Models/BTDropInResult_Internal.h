#import <BraintreeDropIn/BTDropInResult.h>

NS_ASSUME_NONNULL_BEGIN

__attribute__((deprecated("BraintreeDropIn is deprecated. Use the Braintre SDK instead. See https://developer.paypal.com/braintree/docs/guides/client-sdk/setup/ for more information.")))
@interface BTDropInResult (Internal)

// Exposed for testing
@property (class, nonatomic, strong) NSUserDefaults *userDefaults;

// Exposed for testing
+ (void)mostRecentPaymentMethodForAPIClient:(BTAPIClient * _Nullable)apiClient
                                 completion:(void (^)(BTDropInResult * _Nullable result, NSError * _Nullable error))completion;

// Exposed for testing
// The `PPDataCollector` class, exposed internally for injecting test doubles for unit tests
+ (void)setPayPalDataCollectorClass:(nonnull Class)payPalDataCollectorClass;

- (instancetype)initWithEnvironment:(NSString *)environment;

@end

NS_ASSUME_NONNULL_END
