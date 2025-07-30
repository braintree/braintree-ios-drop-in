#import <UIKit/UIKit.h>
#import "BTUIKVectorArtView.h"

__attribute__((deprecated("BraintreeDropIn is deprecated. Use the Braintre SDK instead. See https://developer.paypal.com/braintree/docs/guides/client-sdk/setup/ for more information.")))
@interface BTUIKPayPalWordmarkVectorArtView : BTUIKVectorArtView

///  Initializes a PayPal Wordmark with padding
///
///  This view includes built-in padding to ensure consistent typographical baseline alignment with Venmo wordmark.
///
///  @return A PayPal Wordmark with padding
- (instancetype)initWithPadding;

///  Initializes a PayPal Wordmark
///
///  This view does not include built-in padding.
///
///  @return A PayPal Wordmark
- (instancetype)init;

@end
