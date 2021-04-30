#if __has_include(<Braintree/BraintreeCore.h>) // CocoaPods
#import <Braintree/BraintreeCore.h>
#else
#import <BraintreeCore/BraintreeCore.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface BTConfiguration (DropIn)

@property (nonatomic, strong, readonly) NSArray<NSString *> *supportedCardTypes;

@end

NS_ASSUME_NONNULL_END
