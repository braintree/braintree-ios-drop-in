#import <UIKit/UIKit.h>
#import "BTDropInBaseViewController.h"
#import "BTUIKFormField.h"

__attribute__((deprecated("BraintreeDropIn is deprecated. Use the Braintre SDK instead. See https://developer.paypal.com/braintree/docs/guides/client-sdk/setup/ for more information.")))
// NEXT_MAJOR_VERSION: - Remove BTEnrollmentVerificationViewController.
@interface BTEnrollmentVerificationViewController : BTDropInBaseViewController <UITextFieldDelegate, BTUIKFormFieldDelegate>
typedef void (^BTEnrollmentHandler)(NSString* authCode, BOOL resendSms);

- (instancetype)initWithPhone:(NSString *)mobilePhoneNumber
            mobileCountryCode:(NSString *)mobileCountryCode
                      handler:(BTEnrollmentHandler)handler;

- (void)smsErrorHidden:(BOOL)hidden;
- (void)confirm;

@end
