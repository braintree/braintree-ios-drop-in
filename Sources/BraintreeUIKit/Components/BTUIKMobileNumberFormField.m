#ifdef COCOAPODS
#import <BraintreeDropIn/BTUIKInputAccessoryToolbar.h>
#import <BraintreeDropIn/BTUIKLocalizedString.h>
#import <BraintreeDropIn/BTUIKMobileNumberFormField.h>
#import <BraintreeDropIn/BTUIKTextField.h>
#else
#import <BraintreeUIKit/BTUIKInputAccessoryToolbar.h>
#import <BraintreeUIKit/BTUIKLocalizedString.h>
#import <BraintreeUIKit/BTUIKMobileNumberFormField.h>
#import <BraintreeUIKit/BTUIKTextField.h>
#endif

@implementation BTUIKMobileNumberFormField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textField.accessibilityLabel = BTUIKLocalizedString(MOBILE_NUMBER_LABEL);
        self.formLabel.text = BTUIKLocalizedString(MOBILE_NUMBER_LABEL);
        self.textField.placeholder = @"00 0000 0000";
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return self;
}

- (void)fieldContentDidChange {
    [self.delegate formFieldDidChange:self];
    [self updateAppearance];
}

#pragma mark - Custom accessors

- (BOOL)valid {
    return self.mobileNumber.length >= 8;
}

- (NSString *)mobileNumber {
    return self.textField.text;
}

@end
