#if __has_include(<Braintree/BraintreeCore.h>) // CocoaPods
#import <Braintree/BraintreeCore.h>
#else
#import <BraintreeCore/BraintreeCore.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class BTPaymentMethodNonce;
@class BTHTTP;
@class BTAnalyticsService;

@interface BTAPIClient (Internal)

@property (nonatomic, copy, nullable) NSString *tokenizationKey;
@property (nonatomic, strong, nullable) BTClientToken *clientToken;

/// Client metadata that is used for tracking the client session
@property (nonatomic, readonly, strong) BTClientMetadata *metadata;

/// Exposed for testing analytics
@property (nonatomic, strong) BTAnalyticsService *analyticsService;

/// Analytics should only be posted by internal clients.
- (void)sendAnalyticsEvent:(NSString *)eventName;

/// An internal initializer to toggle whether to send an analytics event during initialization.
/// This prevents copyWithSource:integration: from sending a duplicate event. It can also be used
/// to suppress excessive network chatter during testing.
- (nullable instancetype)initWithAuthorization:(NSString *)authorization sendAnalyticsEvent:(BOOL)sendAnalyticsEvent;

@end

NS_ASSUME_NONNULL_END
