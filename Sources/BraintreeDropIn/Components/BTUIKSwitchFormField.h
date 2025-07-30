#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

__attribute__((deprecated("BraintreeDropIn is deprecated. Use the Braintre SDK instead. See https://developer.paypal.com/braintree/docs/guides/client-sdk/setup/ for more information.")))
@interface BTUIKSwitchFormField : UIView

- (instancetype)initWithTitle:(NSString *)title;

/// The switch
@property (nonatomic, strong) UISwitch *switchControl;

@end

NS_ASSUME_NONNULL_END
