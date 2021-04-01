#import "BTUIKAppearance.h"
#import "BTUIKInputAccessoryToolbar.h"
#import "BTUIKPostalCodeFormField.h"
#import "BTUIKTextField.h"
#import "BTUIKUtil.h"
#import "BTDropInLocalization_Internal.h"

@implementation BTUIKPostalCodeFormField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textField.accessibilityLabel = BTDropInLocalizedString(POSTAL_CODE_LABEL);
        self.labelText = BTDropInLocalizedString(POSTAL_CODE_LABEL);
        self.textField.placeholder = BTDropInLocalizedString(POSTAL_CODE_PLACEHOLDER);
        self.textField.keyboardType = [BTUIKAppearance sharedInstance].postalCodeFormFieldKeyboardType;

        self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
        self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.textField.returnKeyType = UIReturnKeyDone;
    }
    return self;
}

- (NSString *)postalCode {
    return self.textField.text;
}

- (BOOL)entryComplete {
    // Never allow auto-advancing out of postal code field since there is no way to know that the
    // input value constitutes a complete postal code.
    return NO;
}

- (BOOL)valid {
    return self.postalCode.length > 0;
}

- (void)fieldContentDidChange {
    [self.delegate formFieldDidChange:self];
    [self updateAppearance];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.displayAsValid = YES;
    [super textFieldDidBeginEditing:textField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.displayAsValid = YES;
    [super textFieldDidEndEditing:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
