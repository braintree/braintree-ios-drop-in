#import "BTUIKAppearance.h"
#import "BTUIKCardNumberFormField.h"
#import "BTUIKInputAccessoryToolbar.h"
#import "BTUIKPaymentOptionCardView.h"
#import "BTUIKTextField.h"
#import "BTUIKUtil.h"
#import "BTUIKViewUtil.h"
#import "BTDropInLocalization_Internal.h"

#define TEMP_KERNING 8.0

@interface BTUIKCardNumberFormField ()
@property (nonatomic, strong) BTUIKPaymentOptionCardView *hint;
@property (nonatomic, strong) UIView *hintContainer;
@property (nonatomic, strong) UIButton *validateButton;
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;

@end

@implementation BTUIKCardNumberFormField

@synthesize number = _number;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.state = BTUIKCardNumberFormFieldStateDefault;
        self.textField.accessibilityLabel = BTDropInLocalizedString(CARD_NUMBER_PLACEHOLDER);
        self.textField.placeholder = BTDropInLocalizedString(CARD_NUMBER_PLACEHOLDER);
        self.labelText = @"";
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
        
        self.hint = [BTUIKPaymentOptionCardView new];
        self.hint.paymentMethodType = BTDropInPaymentMethodTypeUnknown;
        self.hint.translatesAutoresizingMaskIntoConstraints = NO;

        [self.hint.widthAnchor constraintEqualToConstant:[BTUIKAppearance smallIconWidth]].active = YES;
        [self.hint.heightAnchor constraintEqualToConstant:[BTUIKAppearance smallIconHeight]].active = YES;

        self.hintContainer = [UIView new];
        [self.hintContainer addSubview:self.hint];

        [self.hintContainer.widthAnchor constraintEqualToAnchor:self.hint.widthAnchor constant:10].active = YES;
        [self.hintContainer.heightAnchor constraintEqualToAnchor:self.hint.heightAnchor].active = YES;
        [self.hint.leadingAnchor constraintEqualToAnchor:self.hintContainer.leadingAnchor constant:10].active = YES;
        [self.hint.centerYAnchor constraintEqualToAnchor:self.hintContainer.centerYAnchor].active = YES;

        self.accessoryView = self.hintContainer;
        [self setAccessoryViewHidden:YES animated:NO];
        
        self.validateButton = [UIButton new];

        [self.validateButton setTitle:BTDropInLocalizedString(NEXT_ACTION) forState:UIControlStateNormal];
        [self.validateButton setTitleColor:[BTUIKAppearance sharedInstance].tintColor forState:UIControlStateNormal];
        [self.validateButton setTitleColor:[BTUIKAppearance sharedInstance].disabledColor forState:UIControlStateDisabled];

        self.validateButton.titleLabel.font = [BTUIKAppearance sharedInstance].staticHeadlineFont;
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
    if (self.validateButton.enabled) {
        self.validateButton.accessibilityHint = nil;
    } else {
        self.validateButton.accessibilityHint = BTDropInLocalizedString(VALID_CARD_ERROR_LABEL);
    }
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
    self.labelText = @"";
    [UIView transitionWithView:self
                      duration:0.2
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        if ([self isShowingValidateButton]) {
                            [self setAccessoryViewHidden:NO animated:NO];
                        } else {
                            [self setAccessoryViewHidden:YES animated:YES];
                        }
                        [self updateAppearance];
                        
                        if (self.isPotentiallyValid) {
                            [self formatCardNumber];
                        }
                    } completion:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [super textFieldDidEndEditing:textField];
    self.displayAsValid = self.number.length == 0 || (![self isValidLength] && self.state == BTUIKCardNumberFormFieldStateValidate) || (_cardType != nil && [_cardType validNumber:_number]);
    self.labelText = self.number.length == 0 || (![self isValidLength] && self.state == BTUIKCardNumberFormFieldStateValidate) ? @"" : BTDropInLocalizedString(CARD_NUMBER_PLACEHOLDER);
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
        [self updateAppearance];
    }];
}

- (void)resetFormField {
    self.labelText = @"";
    self.textField.text = @"";
    [self setAccessoryViewHidden:YES animated:NO];
    [self updateAppearance];
}

#pragma mark - Public Methods

- (void)setState:(BTUIKCardNumberFormFieldState)state {
    if (state == self.state) {
        return;
    }
    _state = state;
    if (self.state == BTUIKCardNumberFormFieldStateDefault) {
        self.accessoryView = self.hintContainer;
        [self setAccessoryViewHidden:(self.labelText.length <= 0) animated:YES];
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

- (BOOL)isPotentiallyValid {
    return self.cardType != nil || self.number.length == 0;
}

- (BOOL)isValidLength {
    return self.cardType != nil && [self.cardType completeNumber:_number];
}

- (void)updateCardHint {
    BTDropInPaymentMethodType paymentMethodType = [BTUIKViewUtil paymentMethodTypeForCardType:self.cardType];
    self.hint.paymentMethodType = paymentMethodType;
}

@end
