#import <UIKit/UIKit.h>
#import "BTDropInBaseViewController.h"
#ifdef COCOAPODS
#import <BraintreeDropIn/BraintreeUIKit.h>
#else
#import <BraintreeUIKit/BraintreeUIKit.h>
#endif

@interface BTEnrollmentVerificationViewController : BTDropInBaseViewController <UITextFieldDelegate, BTUIKFormFieldDelegate>
typedef void (^BTEnrollmentHandler)(NSString* authCode, BOOL resendSms);

- (instancetype)initWithPhone:(NSString *)mobilePhoneNumber
            mobileCountryCode:(NSString *)mobileCountryCode
                      handler:(BTEnrollmentHandler)handler;

- (void)smsErrorHidden:(BOOL)hidden;
- (void)confirm;

@end
