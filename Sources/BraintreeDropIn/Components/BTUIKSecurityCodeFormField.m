#ifdef COCOAPODS
#import <BraintreeDropIn/BTUIKInputAccessoryToolbar.h>
#import <BraintreeDropIn/BTUIKLocalizedString.h>
#import <BraintreeDropIn/BTUIKSecurityCodeFormField.h>
#import <BraintreeDropIn/BTUIKTextField.h>
#else
#import <BraintreeUIKit/BTUIKInputAccessoryToolbar.h>
#import <BraintreeUIKit/BTUIKLocalizedString.h>
#import <BraintreeUIKit/BTUIKSecurityCodeFormField.h>
#import <BraintreeUIKit/BTUIKTextField.h>
#endif

@interface BTUIKSecurityCodeFormField ()

@end

@implementation BTUIKSecurityCodeFormField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textField.accessibilityLabel = BTUIKLocalizedString(SECURITY_CODE_LABEL);
        self.labelText = BTUIKLocalizedString(SECURITY_CODE_LABEL);
        self.textField.placeholder = BTUIKLocalizedString(CVV_FIELD_PLACEHOLDER);
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return self;
}

#pragma mark - Custom accessors

- (BOOL)valid {
    return self.securityCode.length >= 3;
}

- (NSString *)securityCode {
    return self.textField.text;
}

#pragma mark UITextFieldDelegate

- (void)fieldContentDidChange {
    [self.delegate formFieldDidChange:self];
    [self updateAppearance];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [super textFieldDidBeginEditing:textField];
    [self updateAppearance];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [super textFieldDidEndEditing:textField];
    [self updateAppearance];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return textField.text.length - range.length + string.length <= 4;
}

@end
