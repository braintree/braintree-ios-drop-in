#if __has_include(<BraintreeDropIn/BraintreeUIKit.h>)
#import <BraintreeDropIn/BTUIKFormField.h>
#else
#import <BraintreeUIKit/BTUIKFormField.h>
#endif

/// @class Form field to collect a mobile phone number
@interface BTUIKMobileNumberFormField : BTUIKFormField

/// The mobile phone number
@property (nonatomic, copy, nullable, readonly) NSString *mobileNumber;

@end
