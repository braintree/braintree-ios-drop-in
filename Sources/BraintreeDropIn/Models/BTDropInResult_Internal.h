#import <BraintreeDropIn/BTDropInResult.h>

NS_ASSUME_NONNULL_BEGIN

@interface BTDropInResult (Internal)

// Exposed for testing
@property (class, nonatomic, strong) NSUserDefaults *userDefaults;

// Exposed for testing
+ (void)fetchDropInResultWithAPIClient:(BTAPIClient * _Nullable)apiClient handler:(BTDropInResultFetchHandler)handler;

@end

NS_ASSUME_NONNULL_END
