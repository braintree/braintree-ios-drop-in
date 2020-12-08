#if __has_include(<BraintreeDropIn/BraintreeUIKit.h>)
#import <BraintreeDropIn/BTUIKFormField.h>
#else
#import <BraintreeUIKit/BTUIKFormField.h>
#endif

@interface BTUIKCardholderNameFormField : BTUIKFormField

/// The cardholder name
@property (nonatomic, strong, readonly) NSString *cardholderName;

/// Is cardholder name input required
@property (nonatomic, assign) BOOL isRequired;

@end
