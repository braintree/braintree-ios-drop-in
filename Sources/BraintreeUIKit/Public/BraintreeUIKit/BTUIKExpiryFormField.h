#ifdef COCOAPODS
#import <BraintreeDropIn/BTUIKFormField.h>
#else
#import <BraintreeUIKit/BTUIKFormField.h>
#endif

/// @class Form field to collect an expiration date.
@interface BTUIKExpiryFormField : BTUIKFormField
// TODO: - make sure the expiration month and expiration year properties are being set correctly
/// The expiration month
@property (nonatomic, strong, nullable, readonly) NSString *expirationMonth;

/// The expiration year
@property (nonatomic, strong, nullable, readonly) NSString *expirationYear;

/// The expiration date in MMYYYY format.
@property (nonatomic, copy, nullable) NSString *expirationDate;

@end
