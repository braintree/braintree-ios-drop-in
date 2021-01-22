#ifdef COCOAPODS
#import <BraintreeDropIn/BTUIKAppearance.h>
#import <BraintreeDropIn/BTUIKCardNumberFormField.h>
#import <BraintreeDropIn/BTUIKInputAccessoryToolbar.h>
#import <BraintreeDropIn/BTUIKLocalizedString.h>
#import <BraintreeDropIn/BTUIKPaymentOptionCardView.h>
#import <BraintreeDropIn/BTUIKTextField.h>
#import <BraintreeDropIn/BTUIKUtil.h>
#import <BraintreeDropIn/BTUIKViewUtil.h>
#else
#import <BraintreeUIKit/BTUIKAppearance.h>
#import <BraintreeUIKit/BTUIKCardNumberFormField.h>
#import <BraintreeUIKit/BTUIKInputAccessoryToolbar.h>
#import <BraintreeUIKit/BTUIKLocalizedString.h>
#import <BraintreeUIKit/BTUIKPaymentOptionCardView.h>
#import <BraintreeUIKit/BTUIKTextField.h>
#import <BraintreeUIKit/BTUIKUtil.h>
#import <BraintreeUIKit/BTUIKViewUtil.h>
#endif

#define TEMP_KERNING 8.0

@interface BTUIKCardNumberFormField ()
@property (nonatomic, strong) BTUIKPaymentOptionCardView *hint;
@property (nonatomic, strong) UIButton *validateButton;
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;

@end

@implementation BTUIKCardNumberFormField

@synthesize number = _number;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.state = BTUIKCardNumberFormFieldStateDefault;
        self.textField.accessibilityLabel = BTUIKLocalizedString(CARD_NUMBER_PLACEHOLDER);
        self.textField.placeholder = BTUIKLocalizedString(CARD_NUMBER_PLACEHOLDER);
        self.formLabel.text = @"";
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
        
        self.hint = [BTUIKPaymentOptionCardView new];
        self.hint.paymentOptionType = BTUIKPaymentOptionTypeUnknown;
        self.hint.translatesAutoresizingMaskIntoConstraints = NO;
        [self.hint addConstraint:[NSLayoutConstraint constraintWithItem:self.hint attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:[BTUIKAppearance smallIconHeight]]];
        [self.hint addConstraint:[NSLayoutConstraint constraintWithItem:self.hint attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:[BTUIKAppearance smallIconWidth]]];
        
        self.accessoryView = self.hint;
        [self setAccessoryViewHidden:YES animated:NO];
        
        self.validateButton = [UIButton new];
        [self.validateButton setTitle:BTUIKLocalizedString(NEXT_ACTION) forState:UIControlStateNormal];
        
        NSAttributedString *normalValidateButtonString = [[NSAttributedString alloc] initWithString:BTUIKLocalizedString(NEXT_ACTION)
                                                                                         attributes:@{NSForegroundColorAttributeName:[BTUIKAppearance sharedInstance].tintColor,
                                                                                                      NSFontAttributeName:[[BTUIKAppearance sharedInstance].boldFont fontWithSize:UIFont.labelFontSize]}];
        [self.validateButton setAttributedTitle:normalValidateButtonString
                                       forState:UIControlStateNormal];
        NSAttributedString *disabledValidateButtonString = [[NSAttributedString alloc] initWithString:BTUIKLocalizedString(NEXT_ACTION)
                                                                                           attributes:@{NSForegroundColorAttributeName:[BTUIKAppearance sharedInstance].disabledColor,
                                                                                                        NSFontAttributeName:[[BTUIKAppearance sharedInstance].boldFont fontWithSize:UIFont.labelFontSize]}];
        [self.validateButton setAttributedTitle:disabledValidateButtonString forState:UIControlStateDisabled];

        [self.validateButton sizeToFit];
        [self.validateButton layoutIfNeeded];
        [self.validateButton addTarget:self action:@selector(validateButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self updateValidationButton];

        self.loadingView = [UIActivityIndicatorView new];
        self.loadingView.activityIndicatorViewStyle = [BTUIKAppearance sharedInstance].activityIndicatorViewStyle;
        [self.loadingView sizeToFit];
    }
    return self;
}

- (void)validateButtonPressed {
    if (self.cardNumberDelegate != nil) {
        [self.cardNumberDelegate validateButtonPressed:self];
    }
}

- (void)updateValidationButton {
    self.validateButton.enabled = _number.length > 13;
}

- (BOOL)valid {
    return [self.cardType validNumber:self.number];
}

- (BOOL)entryComplete {
    return [super entryComplete] && [self.cardType validAndNecessarilyCompleteNumber:self.number];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = textField.text.length - range.length + string.length;
    NSUInteger maxLength = self.cardType == nil ? [BTUIKCardType maxNumberLength] : self.cardType.maxNumberLength;
    if ([self isShowingValidateButton]) {
        return YES;
    } else {
        return newLength <= maxLength;
    }
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self fieldContentDidChange];
}

- (void)fieldContentDidChange {
    _number = [BTUIKUtil stripNonDigits:self.textField.text];
    BTUIKCardType *oldCardType = _cardType;
    _cardType = [BTUIKCardType cardTypeForNumber:_number];
    [self formatCardNumber];

    if (self.cardType != oldCardType) {
        [self updateCardHint];
    }
    
    self.displayAsValid = self.valid || (!self.isValidLength && self.isPotentiallyValid) || self.state == BTUIKCardNumberFormFieldStateValidate;
    [self updateValidationButton];
    [self updateAppearance];
    [self setNeedsDisplay];
    
    [self.delegate formFieldDidChange:self];
}

- (void)formatCardNumber {
    if (self.cardType != nil) {
        UITextRange *r = self.textField.selectedTextRange;
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:[self.cardType formatNumber:_number kerning:TEMP_KERNING]];
        self.textField.attributedText = text;
        self.textField.selectedTextRange = r;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.textField.text = _number;
    [super textFieldDidBeginEditing:textField];
    self.displayAsValid = self.valid || (!self.isValidLength && self.isPotentiallyValid);
    self.formLabel.text = @"";
    [UIView transitionWithView:self
                      duration:0.2
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        if ([self isShowingValidateButton]) {
                            [self setAccessoryViewHidden:NO animated:NO];
                        } else {
                            [self setAccessoryViewHidden:YES animated:YES];
                        }
                        [self updateConstraints];
                        [self updateAppearance];
                        
                        if (self.isPotentiallyValid) {
                            [self formatCardNumber];
                        }
                    } completion:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [super textFieldDidEndEditing:textField];
    self.displayAsValid = self.number.length == 0 || (![self isValidLength] && self.state == BTUIKCardNumberFormFieldStateValidate) || (_cardType != nil && [_cardType validNumber:_number]);
    self.formLabel.text = self.number.length == 0 || (![self isValidLength] && self.state == BTUIKCardNumberFormFieldStateValidate) ? @"" : BTUIKLocalizedString(CARD_NUMBER_PLACEHOLDER);
    [UIView animateWithDuration:0.2 animations:^{
        if ([self isShowingValidateButton]) {
            [self setAccessoryViewHidden:NO animated:NO];
        } else {
            if (self.number.length == 0) {
                [self setAccessoryViewHidden:YES animated:YES];
            } else {
                [self showCardHintAccessory];
            }
        }
        if (self.number.length > 7 && ([self isValidLength] || self.state != BTUIKCardNumberFormFieldStateValidate)) {
            NSString *lastFour = [self.number substringFromIndex: [self.number length] - 4];
            self.textField.text = [NSString stringWithFormat:@"•••• %@", lastFour];
        }
        [self updateConstraints];
        [self updateAppearance];
    }];
}

- (void)resetFormField {
    self.formLabel.text = @"";
    self.textField.text = @"";
    [self setAccessoryViewHidden:YES animated:NO];
    [self updateConstraints];
    [self updateAppearance];
}

#pragma mark - Public Methods

- (void)setState:(BTUIKCardNumberFormFieldState)state {
    if (state == self.state) {
        return;
    }
    _state = state;
    if (self.state == BTUIKCardNumberFormFieldStateDefault) {
        self.accessoryView = self.hint;
        [self setAccessoryViewHidden:(self.formLabel.text.length <= 0) animated:YES];
    } else if (self.state == BTUIKCardNumberFormFieldStateLoading) {
        self.accessoryView = self.loadingView;
        [self setAccessoryViewHidden:NO animated:YES];
        [self.loadingView startAnimating];
    } else {
        self.accessoryView = self.validateButton;
        [self setAccessoryViewHidden:NO animated:YES];
    }
}

- (void)setNumber:(NSString *)number {
    self.text = number;
    _number = self.textField.text;
}

- (void)showCardHintAccessory {
    [self setAccessoryViewHidden:NO animated:YES];
}

#pragma mark - Private Helpers

- (BOOL)isShowingValidateButton {
    return self.state == BTUIKCardNumberFormFieldStateValidate;
}

- (BOOL)isValidCardType {
    return self.cardType != nil || _number.length == 0;
}

- (BOOL)isPotentiallyValid {
    return [BTUIKCardType cardTypeForNumber:self.number] != nil;
}

- (BOOL)isValidLength {
    return self.cardType != nil && [self.cardType completeNumber:_number];
}

- (void)updateCardHint {
    BTUIKPaymentOptionType paymentMethodType = [BTUIKViewUtil paymentMethodTypeForCardType:self.cardType];
    self.hint.paymentOptionType = paymentMethodType;
}

@end
