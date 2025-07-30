#import <Foundation/Foundation.h>

__attribute__((deprecated("BraintreeDropIn is deprecated. Use the Braintre SDK instead. See https://developer.paypal.com/braintree/docs/guides/client-sdk/setup/ for more information.")))
@interface BTUIKCardExpiryFormat : NSObject
@property (nonatomic, copy) NSString *value;
@property (nonatomic, assign) NSUInteger cursorLocation;
@property (nonatomic, assign) BOOL backspace;

- (void)formattedValue:(NSString * __autoreleasing *)value cursorLocation:(NSUInteger *)cursorLocation;

@end
