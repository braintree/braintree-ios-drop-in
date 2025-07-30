#import <UIKit/UIKit.h>

__attribute__((deprecated("BraintreeDropIn is deprecated. Use the Braintre SDK instead. See https://developer.paypal.com/braintree/docs/guides/client-sdk/setup/ for more information.")))
@interface UIColor (BTUIK)

/// Color with bytes and alpha
+ (instancetype)btuik_colorWithBytesR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b A:(NSInteger)a;

/// Color with bytes
+ (instancetype)btuik_colorWithBytesR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b;

/// Color from hex string with alpha
+ (instancetype)btuik_colorFromHex:(NSString *)hex alpha:(CGFloat)alpha;

/// Asjusts the brightness of a color
- (instancetype)btuik_adjustedBrightness:(CGFloat)adjustment;

@end
