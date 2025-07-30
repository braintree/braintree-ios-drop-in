#import <UIKit/UIKit.h>
#import "BTUIKPaymentOptionCardView.h"
#import <BraintreeDropIn/BTDropInPaymentMethodType.h>

__attribute__((deprecated("BraintreeDropIn is deprecated. Use the Braintre SDK instead. See https://developer.paypal.com/braintree/docs/guides/client-sdk/setup/ for more information.")))
@interface BTDropInPaymentSelectionCell : UITableViewCell

@property (nonatomic, strong) UILabel* label;
@property (nonatomic, strong) UILabel* detailLabel;
@property (nonatomic, strong) BTUIKPaymentOptionCardView* iconView;
@property (nonatomic, strong) UIView *bottomBorder;
@property (nonatomic) BTDropInPaymentMethodType type;

@end
