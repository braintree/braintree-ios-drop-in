#import <Foundation/Foundation.h>

__attribute__((deprecated("BraintreeDropIn is deprecated. Use the Braintre SDK instead. See https://developer.paypal.com/braintree/docs/guides/client-sdk/setup/ for more information.")))
@interface BTDropInLocalization : NSObject

/// Sets custom translation locales for the Drop-In UI
///
/// @param locales An array of locale codes
+ (void)setCustomTranslations:(NSArray<NSString *> *)locales;

@end
