#if __has_include("BraintreeCore.h")
#import "BraintreeCore.h"
#else
#import <BraintreeCore/BraintreeCore.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class BTPaymentMethodNonce;
@class BTHTTP;
@class BTAnalyticsService;

typedef NS_ENUM(NSInteger, BTAPIClientHTTPType) {
    /// Use the Gateway
    BTAPIClientHTTPTypeGateway = 0,

    /// Use the Braintree API
    BTAPIClientHTTPTypeBraintreeAPI,

    /// Use the GraphQL API
    BTAPIClientHTTPTypeGraphQLAPI,
};

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

- (void)GET:(NSString *)path
 parameters:(nullable NSDictionary <NSString *, NSString *> *)parameters
   httpType:(BTAPIClientHTTPType)httpType
 completion:(nullable void(^)(BTJSON * _Nullable body, NSHTTPURLResponse * _Nullable response, NSError * _Nullable error))completionBlock;

- (void)POST:(NSString *)path
  parameters:(nullable NSDictionary *)parameters
    httpType:(BTAPIClientHTTPType)httpType
  completion:(nullable void(^)(BTJSON * _Nullable body, NSHTTPURLResponse * _Nullable response, NSError * _Nullable error))completionBlock;

@end

NS_ASSUME_NONNULL_END
