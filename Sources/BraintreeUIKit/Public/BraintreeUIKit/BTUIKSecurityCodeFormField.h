#ifdef COCOAPODS
#import <BraintreeDropIn/BTUIKFormField.h>
#else
#import <BraintreeUIKit/BTUIKFormField.h>
#endif

/// @class Form field to collect a mobile country code
@interface BTUIKSecurityCodeFormField : BTUIKFormField

/// The security code
@property (nonatomic, copy, nullable, readonly) NSString *securityCode;

@end
