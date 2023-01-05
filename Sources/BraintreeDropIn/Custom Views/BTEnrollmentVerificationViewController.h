#import <UIKit/UIKit.h>
#import "BTDropInBaseViewController.h"
#import "BTUIKFormField.h"

// NEXT_MAJOR_VERSION: - Remove BTEnrollmentVerificationViewController.
@interface BTEnrollmentVerificationViewController : BTDropInBaseViewController <UITextFieldDelegate, BTUIKFormFieldDelegate>
typedef void (^BTEnrollmentHandler)(NSString* authCode, BOOL resendSms);

- (instancetype)initWithPhone:(NSString *)mobilePhoneNumber
            mobileCountryCode:(NSString *)mobileCountryCode
                      handler:(BTEnrollmentHandler)handler;

- (void)smsErrorHidden:(BOOL)hidden;
- (void)confirm;

@end
