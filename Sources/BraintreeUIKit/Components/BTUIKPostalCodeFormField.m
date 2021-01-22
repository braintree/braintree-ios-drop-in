#ifdef COCOAPODS
#import <BraintreeDropIn/BTUIKAppearance.h>
#import <BraintreeDropIn/BTUIKInputAccessoryToolbar.h>
#import <BraintreeDropIn/BTUIKLocalizedString.h>
#import <BraintreeDropIn/BTUIKPostalCodeFormField.h>
#import <BraintreeDropIn/BTUIKTextField.h>
#import <BraintreeDropIn/BTUIKUtil.h>
#else
#import <BraintreeUIKit/BTUIKAppearance.h>
#import <BraintreeUIKit/BTUIKInputAccessoryToolbar.h>
#import <BraintreeUIKit/BTUIKLocalizedString.h>
#import <BraintreeUIKit/BTUIKPostalCodeFormField.h>
#import <BraintreeUIKit/BTUIKTextField.h>
#import <BraintreeUIKit/BTUIKUtil.h>
#endif

@implementation BTUIKPostalCodeFormField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textField.accessibilityLabel = BTUIKLocalizedString(POSTAL_CODE_PLACEHOLDER);
        self.formLabel.text = BTUIKLocalizedString(POSTAL_CODE_PLACEHOLDER);
        self.textField.placeholder = @"12345";
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
