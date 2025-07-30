#import <UIKit/UIKit.h>

__attribute__((deprecated("BraintreeDropIn is deprecated. Use the Braintre SDK instead. See https://developer.paypal.com/braintree/docs/guides/client-sdk/setup/ for more information.")))
@interface BTUIKCollectionReusableView : UICollectionReusableView

@property (nonatomic, strong) UILabel* label;

@end
