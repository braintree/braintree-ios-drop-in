#ifdef COCOAPODS
#import <Braintree/BraintreeCore.h>
#else
#import <BraintreeCore/BraintreeCore.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface BTConfiguration (DropIn)

@property (nonatomic, strong, readonly) NSArray<NSString *> *supportedCardTypes;

@end

NS_ASSUME_NONNULL_END
