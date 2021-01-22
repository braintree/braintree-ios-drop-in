#ifdef COCOAPODS
#import <BraintreeDropIn/BTUIKFormField.h>
#else
#import <BraintreeUIKit/BTUIKFormField.h>
#endif

/// @class Form field to collect a postal code
@interface BTUIKPostalCodeFormField : BTUIKFormField

/// The postal code
@property (nonatomic, strong, readonly) NSString *postalCode;

@end
