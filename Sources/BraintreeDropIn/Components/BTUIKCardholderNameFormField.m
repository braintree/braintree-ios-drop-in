#import "BTUIKCardholderNameFormField.h"
#import "BTDropInLocalization_Internal.h"

@implementation BTUIKCardholderNameFormField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textField.accessibilityLabel = BTDropInLocalizedString(CARDHOLDER_NAME_LABEL);
        self.labelText = BTDropInLocalizedString(CARDHOLDER_NAME_LABEL);

        self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
        self.textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        self.textField.returnKeyType = UIReturnKeyNext;
    }

    return self;
}

- (NSString *)cardholderName {
    return self.textField.text;
}

- (BOOL)valid {
    NSString *cardholderName = [self.cardholderName stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];

    if (self.isRequired && cardholderName.length == 0) {
        return NO;
    }

    // A string with ONLY numbers, hypens and whitespace may be a card number.
    // Consider this invalid to avoid leaking unencrypted card numbers to merchant.
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[\\d\\s-]+$"];
    if ([predicate evaluateWithObject:cardholderName]) {
        return NO;
    }

    if (cardholderName.length > 255) {
        return NO;
    }

    return YES;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    return newText.length <= 255;
}

@end
