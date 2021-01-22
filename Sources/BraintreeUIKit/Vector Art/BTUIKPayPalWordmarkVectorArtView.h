#import <UIKit/UIKit.h>

#ifdef COCOAPODS
#import <BraintreeDropIn/BTUIKVectorArtView.h>
#else
#import <BraintreeUIKit/BTUIKVectorArtView.h>
#endif

@interface BTUIKPayPalWordmarkVectorArtView : BTUIKVectorArtView

///  Initializes a PayPal Wordmark with padding
///
///  This view includes built-in padding to ensure consistent typographical baseline alignment with Venmo and Coinbase wordmarks.
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
