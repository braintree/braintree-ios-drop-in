#import "BTUIKAppearance.h"
#import "BTUIKFormField.h"
#import "BTUIKVectorArtView.h"
#import "BTUIKViewUtil.h"

@interface BTUIKFormField ()<BTUIKTextFieldEditDelegate>

@property (nonatomic, copy) NSString *previousTextFieldText;
@property (nonatomic, strong) NSMutableArray *layoutConstraints;
@property (nonatomic, strong) UILabel *formLabel;
@property (nonatomic, strong) UIStackView *stackView;

@end

@implementation BTUIKFormField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [BTUIKAppearance sharedInstance].formFieldBackgroundColor;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.displayAsValid = YES;
        BTUIKTextField *textField = [BTUIKTextField new];
        textField.editDelegate = self;
        _textField = textField;
        self.textField.borderStyle = UITextBorderStyleNone;
        self.textField.backgroundColor = UIColor.clearColor;
        self.textField.opaque = NO;
        self.textField.adjustsFontSizeToFitWidth = YES;
        self.textField.returnKeyType = UIReturnKeyNext;
        self.textField.keyboardAppearance = [BTUIKAppearance sharedInstance].keyboardAppearance;
        self.textField.textAlignment = [BTUIKViewUtil naturalTextAlignment];
        [self.textField addTarget:self action:@selector(fieldContentDidChange) forControlEvents:UIControlEventEditingChanged];
        [self.textField addTarget:self action:@selector(editingDidBegin) forControlEvents:UIControlEventEditingDidBegin];
        [self.textField addTarget:self action:@selector(editingDidEnd) forControlEvents:UIControlEventEditingDidEnd];
        self.textField.delegate = self;
        [self addSubview:self.textField];

        self.formLabel = [[UILabel alloc] init];
        [BTUIKAppearance styleLabelBoldPrimary:self.formLabel];
        self.formLabel.text = @"";
        self.formLabel.accessibilityElementsHidden = YES;
        self.formLabel.numberOfLines = 0;
        [self addSubview:self.formLabel];

        [self.formLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.formLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.textField setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];

        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedField)]];
        
        [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        self.opaque = NO;

        self.stackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.formLabel, self.textField]];
        self.stackView.alignment = UIStackViewAlignmentFill;
        self.stackView.distribution = UIStackViewDistributionFill;
        self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
        self.stackView.layoutMarginsRelativeArrangement = YES;

        [self addSubview:self.stackView];

        self.textField.translatesAutoresizingMaskIntoConstraints = NO;
        [self.textField.heightAnchor constraintGreaterThanOrEqualToConstant:BTUIKAppearance.minimumHitArea].active = YES;

        if (UIContentSizeCategoryIsAccessibilityCategory(self.traitCollection.preferredContentSizeCategory) && ![BTUIKAppearance sharedInstance].disableDynamicType) {
            self.stackView.axis = UILayoutConstraintAxisVertical;
            self.stackView.directionalLayoutMargins = NSDirectionalEdgeInsetsMake(15, 15, 15, 15);
        } else {
            self.stackView.axis = UILayoutConstraintAxisHorizontal;
            self.stackView.directionalLayoutMargins = NSDirectionalEdgeInsetsMake(0, 15, 0, 15);
        }

        [self.stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
        [self.stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
        [self.stackView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
        [self.stackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    }
    return self;
}

- (void)setLabelText:(NSString *)labelText {
    _labelText = labelText;
    self.formLabel.text = labelText;
    [self updateTextAlignment];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    if (previousTraitCollection.preferredContentSizeCategory != self.traitCollection.preferredContentSizeCategory) {
        if (UIContentSizeCategoryIsAccessibilityCategory(self.traitCollection.preferredContentSizeCategory) && ![BTUIKAppearance sharedInstance].disableDynamicType) {
            self.stackView.axis = UILayoutConstraintAxisVertical;
            self.stackView.directionalLayoutMargins = NSDirectionalEdgeInsetsMake(15, 15, 15, 15);
        } else {
            self.stackView.axis = UILayoutConstraintAxisHorizontal;
            self.stackView.directionalLayoutMargins = NSDirectionalEdgeInsetsMake(0, 15, 0, 15);
        }

        [self updateTextAlignment];
    }
}

- (void)updateTextAlignment {
    BOOL isAccessibilityFontSize = UIContentSizeCategoryIsAccessibilityCategory(self.traitCollection.preferredContentSizeCategory) && ![BTUIKAppearance sharedInstance].disableDynamicType;
    if (self.formLabel.text.length && !isAccessibilityFontSize) {
        self.textField.textAlignment = [BTUIKViewUtil naturalTextAlignmentInverse];
    } else {
        self.textField.textAlignment = [BTUIKViewUtil naturalTextAlignment];
    }
}

- (void)textFieldDidBeginEditing:(__unused UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(formFieldDidBeginEditing:)]) {
        [self.delegate formFieldDidBeginEditing:self];
    }
}

- (void)textFieldDidEndEditing:(__unused UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(formFieldDidEndEditing:)]) {
        [self.delegate formFieldDidEndEditing:self];
    }
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    // Draw borders
    [[BTUIKAppearance sharedInstance].lineColor setFill];
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!self.displayAsValid) {

        CGPathRef path = CGPathCreateWithRect(CGRectMake(rect.origin.x, CGRectGetMaxY(rect) - 0.5f, rect.size.width, 0.5f), NULL);
        CGContextAddPath(context, path);
        CGPathRelease(path);
        
        path = CGPathCreateWithRect(CGRectMake(rect.origin.x, 0, rect.size.width, 0.5f), NULL);
        CGContextAddPath(context, path);
        
        CGContextDrawPath(context, kCGPathFill);
        CGPathRelease(path);
    } else {
        if (self.interFieldBorder || self.bottomBorder) {
            CGFloat horizontalMargin = self.bottomBorder ? 0 : 17.0f;
            CGPathRef path = CGPathCreateWithRect(CGRectMake(rect.origin.x + horizontalMargin, CGRectGetMaxY(rect) - 0.5f, rect.size.width - horizontalMargin, 0.5f), NULL);
            CGContextAddPath(context, path);
            CGContextDrawPath(context, kCGPathFill);
            CGPathRelease(path);
        }
        if (self.topBorder) {
            CGPathRef path = CGPathCreateWithRect(CGRectMake(rect.origin.x, 0, rect.size.width, 0.5f), NULL);
            CGContextAddPath(context, path);
            CGContextDrawPath(context, kCGPathFill);
            CGPathRelease(path);
        }
    }
}

- (void)setBottomBorder:(BOOL)bottomBorder {
    _bottomBorder = bottomBorder;
    [self setNeedsDisplay];
}

- (void)setInterFieldBorder:(BOOL)interFieldBorder {
    _interFieldBorder = interFieldBorder;
    [self setNeedsDisplay];
}

- (void)setTopBorder:(BOOL)topBorder {
    _topBorder = topBorder;
    [self setNeedsDisplay];
}

- (void)updateAppearance {
    UIColor *textColor;
    if (!self.displayAsValid){
        textColor = [BTUIKAppearance sharedInstance].errorForegroundColor;
    } else {
        textColor = [BTUIKAppearance sharedInstance].primaryTextColor;
    }

    self.textField.textColor = textColor;
    self.textField.font = [BTUIKAppearance sharedInstance].bodyFont;
}

#pragma mark - BTUITextFieldEditDelegate methods

- (void)textFieldWillDeleteBackward:(__unused BTUIKFormField *)textField {
    // _backspace indicates that the backspace key was typed.
    _backspace = YES;
    
}

- (void)textFieldDidDeleteBackward:(__unused BTUIKFormField *)textField originalText:(__unused NSString *)originalText {
    // To be implemented by subclasses
}

- (void)textField:(__unused BTUIKFormField *)textField willInsertText:(__unused NSString *)text {
    _backspace = NO;
}

- (void)textField:(__unused BTUIKFormField *)textField didInsertText:(__unused NSString *)text {
    // To be implemented by subclasses
}


#pragma mark - Custom accessors

- (void)setText:( __unused NSString *)text {
    BOOL shouldChange = [self.textField.delegate textField:self.textField
                             shouldChangeCharactersInRange:NSMakeRange(0, self.textField.text.length)
                                         replacementString:text];
    if (shouldChange) {
        [self.textField.editDelegate textField:self.textField willInsertText:text];
        self.textField.text = text;
        [self fieldContentDidChange];
        [self.textField.editDelegate textField:self.textField didInsertText:text];
    }
    [self updateAppearance];
}

- (NSString *)text {
    return self.textField.text;
}

#pragma mark - Delegate methods and handlers

- (void)resetFormField {
    // To be implemented by subclass
}

- (BOOL)becomeFirstResponder {
    return [self.textField becomeFirstResponder];
}

- (void)fieldContentDidChange {
    // To be implemented by subclass
    if (self.delegate) {
        [self.delegate formFieldDidChange:self];    
    }
    [self updateAppearance];
}

- (void)editingDidBegin {
    [self setAccessoryHighlighted:YES];
}

- (void)editingDidEnd {
    [self setAccessoryHighlighted:NO];
}

- (BOOL)textField:(__unused UITextField *)textField shouldChangeCharactersInRange:(__unused NSRange)range replacementString:(__unused NSString *)newText {
    // To be implemented by subclass
    return YES;
}

- (BOOL)textFieldShouldReturn:(__unused UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(formFieldShouldReturn:)]) {
        return [self.delegate formFieldShouldReturn:self];
    } else {
        return YES;
    }
}

- (void)tappedField {
    [self.textField becomeFirstResponder];
}

#pragma mark UIKeyInput

- (void)insertText:(__unused NSString *)text {
    [self.textField insertText:text];
}

- (void)deleteBackward {
    [self.textField deleteBackward];
}

- (BOOL)hasText {
    return [self.textField hasText];
}

#pragma mark Accessory View Helpers

- (void)setAccessoryView:(UIView *)accessoryView {
    if (self.accessoryView && self.accessoryView.superview) {
        [self.accessoryView removeFromSuperview];
        _accessoryView = nil;
    }
    _accessoryView = accessoryView;
    self.textField.rightView = self.accessoryView;
    self.textField.rightViewMode = UITextFieldViewModeAlways;
    [self.accessoryView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.accessoryView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)setAccessoryViewHidden:(BOOL)hidden animated:(__unused BOOL)animated {
    if (self.accessoryView == nil) {
        return;
    }
    if (animated) {
        [UIView animateWithDuration:0.1 animations:^{
            self.accessoryView.hidden = hidden;
        }];
    } else {
        self.accessoryView.hidden = hidden;
    }
}

- (void)setAccessoryHighlighted:(BOOL)highlight {
    if (self.accessoryView) {
        if ([self.accessoryView respondsToSelector:@selector(setHighlighted:animated:)]) {
            SEL selector = @selector(setHighlighted:animated:);
            BOOL animated = YES;
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self.accessoryView methodSignatureForSelector:selector]];
            [invocation setSelector:selector];
            [invocation setTarget:self.accessoryView];
            [invocation setArgument:&highlight atIndex:2];
            [invocation setArgument:&animated atIndex:3];
            [invocation invoke];
        }
    }
}

@end
