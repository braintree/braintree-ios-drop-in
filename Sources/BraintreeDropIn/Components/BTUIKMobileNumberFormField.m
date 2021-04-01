#import "BTUIKInputAccessoryToolbar.h"
#import "BTUIKMobileNumberFormField.h"
#import "BTUIKTextField.h"
#import "BTDropInLocalization_Internal.h"

@implementation BTUIKMobileNumberFormField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textField.accessibilityLabel = BTDropInLocalizedString(MOBILE_NUMBER_LABEL);
        self.labelText = BTDropInLocalizedString(MOBILE_NUMBER_LABEL);
        self.textField.placeholder = @"00 0000 0000";
        self.textField.keyboardType = UIKeyboardTypePhonePad;
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
