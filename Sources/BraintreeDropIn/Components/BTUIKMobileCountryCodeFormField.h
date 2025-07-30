#import "BTUIKFormField.h"

__attribute__((deprecated("BraintreeDropIn is deprecated. Use the Braintre SDK instead. See https://developer.paypal.com/braintree/docs/guides/client-sdk/setup/ for more information.")))
/// @class Form field to collect a mobile country code
@interface BTUIKMobileCountryCodeFormField : BTUIKFormField

/// The country code
@property (nonatomic, copy, nullable, readonly) NSString *countryCode;

@end
