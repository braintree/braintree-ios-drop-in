#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

__attribute__((deprecated("BraintreeDropIn is deprecated. Use the Braintre SDK instead. See https://developer.paypal.com/braintree/docs/guides/client-sdk/setup/ for more information.")))
@interface UIFont (BTUIK)

+ (UIFont *)bodyFontForFontFamily:(NSString * _Nullable)fontFamily useStaticSize:(BOOL)useStaticSize;
+ (UIFont *)headlineFontForFontFamily:(NSString * _Nullable)fontFamily useStaticSize:(BOOL)useStaticSize;
+ (UIFont *)captionFontForFontFamily:(NSString * _Nullable)fontFamily useStaticSize:(BOOL)useStaticSize;
+ (UIFont *)titleFontForFontFamily:(NSString * _Nullable)fontFamily useStaticSize:(BOOL)useStaticSize;

@end

NS_ASSUME_NONNULL_END
