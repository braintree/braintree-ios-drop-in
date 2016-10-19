#import "BTUIKSecurityCodeFormField.h"
#import "BTUIKTextField.h"
#import "BTUIKInputAccessoryToolbar.h"
#import "BTUIKLocalizedString.h"

@interface BTUIKSecurityCodeFormField ()

@end

@implementation BTUIKSecurityCodeFormField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textField.accessibilityLabel = BTUIKLocalizedString(SECURITY_CODE_LABEL);
        self.formLabel.text = BTUIKLocalizedString(SECURITY_CODE_LABEL);
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
