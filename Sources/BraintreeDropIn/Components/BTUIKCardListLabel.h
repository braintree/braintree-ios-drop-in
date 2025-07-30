#import <UIKit/UIKit.h>
#import <BraintreeDropIn/BTDropInPaymentMethodType.h>

__attribute__((deprecated("BraintreeDropIn is deprecated. Use the Braintre SDK instead. See https://developer.paypal.com/braintree/docs/guides/client-sdk/setup/ for more information.")))
/// @class A UILabel that contains images representing multiple BTDropInPaymentMethodType's
@interface BTUIKCardListLabel : UILabel

/// The array of BTDropInPaymentMethodType's to display
@property (nonatomic, copy) NSArray *availablePaymentOptions;

/// The BTDropInPaymentMethodType to emphasize by fading all other payment methods included in availablePaymentOptions
- (void)emphasizePaymentOption:(BTDropInPaymentMethodType)paymentOption;

@end
