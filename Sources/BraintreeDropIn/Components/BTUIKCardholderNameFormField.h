#import "BTUIKFormField.h"

__attribute__((deprecated("BraintreeDropIn is deprecated. Use the Braintre SDK instead. See https://developer.paypal.com/braintree/docs/guides/client-sdk/setup/ for more information.")))
@interface BTUIKCardholderNameFormField : BTUIKFormField

/// The cardholder name
@property (nonatomic, strong, readonly) NSString *cardholderName;

/// Is cardholder name input required
@property (nonatomic, assign) BOOL isRequired;

@end
