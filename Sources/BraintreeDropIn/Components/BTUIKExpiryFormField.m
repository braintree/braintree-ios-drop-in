#import "BTUIKCardExpirationValidator.h"
#import "BTUIKCardExpiryFormat.h"
#import "BTUIKExpiryFormField.h"
#import "BTUIKInputAccessoryToolbar.h"
#import "BTUIKTextField.h"
#import "BTUIKUtil.h"
#import "BTDropInLocalization_Internal.h"

#define BTUIKCardExpiryFieldComponentSeparator @"/"

@implementation BTUIKExpiryFormField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textField.accessibilityLabel = BTDropInLocalizedString(EXPIRATION_DATE_LABEL);
        self.labelText = BTDropInLocalizedString(EXPIRATION_DATE_LABEL);
        [self updatePlaceholder];
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return self;
}

#pragma mark - Custom accessors

- (void)setExpirationDate:(NSString *)expirationDate {
    [self setText:expirationDate];
}

- (NSString *)expirationDate {
    if (!self.expirationMonth || !self.expirationYear) return nil;
    
    return [NSString stringWithFormat:@"%@%@", self.expirationMonth, self.expirationYear];
}

- (BOOL)valid {
    if (!self.expirationYear || !self.expirationMonth) {
        return NO;
    }
    return [BTUIKCardExpirationValidator month:self.expirationMonth.intValue year:self.expirationYear.intValue validForDate:[NSDate date]];
}

#pragma mark - Private methods

- (void)updatePlaceholder {
    NSString *placeholder = BTDropInLocalizedString(EXPIRY_PLACEHOLDER_TWO_DIGIT_YEAR);
    [self setThemedPlaceholder:placeholder];
}

- (void)kernExpiration:(NSMutableAttributedString *)input {
    CGFloat kerningValue = 4;
    [input removeAttribute:NSKernAttributeName range:NSMakeRange(0, input.length)];
    
    [input beginEditing];
    if (input.length > 2) {
        [input addAttribute:NSKernAttributeName value:@(kerningValue) range:NSMakeRange(1, 1)];
        if (input.length > 3) {
            [input addAttribute:NSKernAttributeName value:@(kerningValue) range:NSMakeRange(2, 1)];
        }
    }
    [input endEditing];
}

- (void)setThemedPlaceholder:(NSString *)placeholder {
    NSMutableAttributedString *attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:placeholder ?: @""
                                                                                              attributes:@{}];
    [self kernExpiration:attributedPlaceholder];
    self.textField.placeholder = placeholder;
}

#pragma mark - Helpers

// Returns YES if date is either a valid date or can have digits appended to make one. It does not contain any expiration
// date validation.
- (BOOL)dateIsValid:(NSString *)date {
    if (date.length > 5) {
        return NO;
    }
    
    NSString *updatedNumberText = [BTUIKUtil stripNonDigits:date];
    
    NSString *monthStr = [updatedNumberText substringToIndex:MIN((NSUInteger)2, updatedNumberText.length)];
    if (monthStr.length > 0) {
        NSInteger month = [monthStr integerValue];
        if (month < 0 || month > 12) {
            return NO;
        }
        if (monthStr.length >= 2 && month == 0) {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - Protocol conformance

#pragma mark UITextFieldDelegate

- (void)fieldContentDidChange {
    _expirationMonth = nil;
    _expirationYear = nil;
    
    NSString *formattedValue;
    NSUInteger formattedCursorLocation;
    BTUIKCardExpiryFormat *format = [[BTUIKCardExpiryFormat alloc] init];
    format.value = self.textField.text;
    format.cursorLocation = [self.textField offsetFromPosition:self.textField.beginningOfDocument toPosition:self.textField.selectedTextRange.start];
    format.backspace = self.backspace;
    [format formattedValue:&formattedValue cursorLocation:&formattedCursorLocation];
    
    // Important: Reset the state of self.backspace.
    // Otherwise, the user won't be able to do the following:
    // Enter "11/16", then backspace to
    //       "1", and then type e.g. "2". Instead of showing:
    //       "12/" (as it should), the form would instead remain stuck at
    //       "1".
    self.backspace = NO;
    // This is because UIControlEventEditingChanged is *not* sent after the "/" is removed.
    // We can't trigger UIControlEventEditingChanged here (after removing a "/") because that would cause an infinite loop.
    
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:formattedValue];
    [self kernExpiration:result];
    self.textField.attributedText = result;
    
    UITextPosition *newPosition = [self.textField positionFromPosition:self.textField.beginningOfDocument offset:formattedCursorLocation];
    UITextRange *newRange = [self.textField textRangeFromPosition:newPosition toPosition:newPosition];
    self.textField.selectedTextRange = newRange;
    
    NSArray *expirationComponents = [self.textField.text componentsSeparatedByString:BTUIKCardExpiryFieldComponentSeparator];
    if (expirationComponents.count == 2 && (self.textField.text.length == 3 || self.textField.text.length == 5)) {
        _expirationMonth = expirationComponents[0];
        _expirationYear = expirationComponents[1];
    }
    
    [self updatePlaceholder];

    // Always display as valid if fewer than 5 characters entered
    self.displayAsValid = self.textField.text.length != 5 || self.valid;

    [self updateAppearance];
    [self.delegate formFieldDidChange:self];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [super textFieldDidBeginEditing:textField];
    self.displayAsValid = YES;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [super textFieldDidEndEditing:textField];
    self.displayAsValid = self.textField.text.length == 0 || self.valid;
    [self updateAppearance];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)newText {
    NSString *numericNewText = [BTUIKUtil stripNonDigits:newText];
    if (![numericNewText isEqualToString:newText]) {
        return NO;
    }
    NSString *updatedText = [textField.text stringByReplacingCharactersInRange:range withString:numericNewText];
    
    return [self dateIsValid:updatedText];
}

@end
