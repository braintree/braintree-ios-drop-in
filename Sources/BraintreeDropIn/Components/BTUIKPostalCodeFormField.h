#import "BTUIKFormField.h"

__attribute__((deprecated("BraintreeDropIn is deprecated. Use the Braintre SDK instead. See https://developer.paypal.com/braintree/docs/guides/client-sdk/setup/ for more information.")))
/// @class Form field to collect a postal code
@interface BTUIKPostalCodeFormField : BTUIKFormField

/// The postal code
@property (nonatomic, strong, readonly) NSString *postalCode;

@end
