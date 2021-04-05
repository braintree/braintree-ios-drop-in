#import "BTEnrollmentVerificationViewController.h"
#import "BTUIKBarButtonItem_Internal_Declaration.h"
#import "BTDropInUIUtilities.h"
#import "BTUIKAppearance.h"
#import "BTDropInLocalization_Internal.h"

@interface BTEnrollmentVerificationViewController ()

@property (nonatomic, strong) NSString *mobilePhoneNumber;
@property (nonatomic, strong) NSString *mobileCountryCode;
@property (nonatomic, strong) BTEnrollmentHandler handler;
@property (nonatomic, strong) BTUIKFormField *smsTextField;
@property (nonatomic, strong) UILabel *smsSentLabel;
@property (nonatomic, strong) UIButton *resendSmsButton;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UIStackView *smsErrorView;
@end

@implementation BTEnrollmentVerificationViewController

- (instancetype)initWithPhone:(NSString *)mobilePhoneNumber
            mobileCountryCode:(NSString *)mobileCountryCode
                      handler:(BTEnrollmentHandler)handler {
    if (self = [super init]) {
        _mobilePhoneNumber = mobilePhoneNumber;
        _mobileCountryCode = mobileCountryCode;
        _handler = handler;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = BTDropInLocalizedString(CONFIRM_ENROLLMENT_LABEL);
    
    self.view.backgroundColor = [BTUIKAppearance sharedInstance].formBackgroundColor;
    self.navigationController.navigationBar.barTintColor = [BTUIKAppearance sharedInstance].barBackgroundColor;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName: [BTUIKAppearance sharedInstance].primaryTextColor
                                                                      }];

    BTUIKBarButtonItem *confirmButton = [[BTUIKBarButtonItem alloc] initWithTitle:BTDropInLocalizedString(CONFIRM_ACTION) style:UIBarButtonItemStyleDone target:self action:@selector(confirm)];
    confirmButton.bold = YES;
    self.navigationItem.rightBarButtonItem = confirmButton;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem.accessibilityHint = BTDropInLocalizedString(SMS_CODE_REQUIRED);
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [BTUIKAppearance sharedInstance].formBackgroundColor;

    UIStackView *smsSentHeader = [BTDropInUIUtilities newStackView];
    smsSentHeader.layoutMargins = UIEdgeInsetsMake(0, [BTUIKAppearance horizontalFormContentPadding], 0, [BTUIKAppearance horizontalFormContentPadding]);
    smsSentHeader.layoutMarginsRelativeArrangement = YES;

    self.smsSentLabel = [UILabel new];
    self.smsSentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.smsSentLabel.textAlignment = NSTextAlignmentCenter;
    NSString *fullMobileNumber = [NSString stringWithFormat:@"+%@ %@", self.mobileCountryCode, self.mobilePhoneNumber];
    self.smsSentLabel.text = [BTDropInLocalization insertIntoLocalizedString:BTDropInLocalizedString(ENTER_SMS_CODE_SENT_HELP_LABEL) replacement:fullMobileNumber];
    self.smsSentLabel.numberOfLines = 0;
    [BTUIKAppearance styleLargeLabelSecondary:self.smsSentLabel];
    [smsSentHeader addArrangedSubview:self.smsSentLabel];

    self.smsTextField = [BTUIKFormField new];
    self.smsTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.smsTextField.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.smsTextField.textField.placeholder = BTDropInLocalizedString(SMS_CODE_LABEL);
    self.smsTextField.delegate = self;
    [self.view addSubview:self.smsTextField];
    
    NSString *smsButtonText = BTDropInLocalizedString(USE_DIFFERENT_PHONE_NUMBER_ACTION);
    self.resendSmsButton = [UIButton new];
    self.resendSmsButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.resendSmsButton setTitle:smsButtonText forState:UIControlStateNormal];

    [self.resendSmsButton setTitleColor:[BTUIKAppearance sharedInstance].tintColor forState:UIControlStateNormal];
    [self.resendSmsButton setTitleColor:[BTUIKAppearance sharedInstance].disabledColor forState:UIControlStateDisabled];

    self.resendSmsButton.titleLabel.font = [BTUIKAppearance sharedInstance].staticHeadlineFont;

    [self.resendSmsButton sizeToFit];
    [self.resendSmsButton layoutIfNeeded];
    [self.resendSmsButton addTarget:self action:@selector(resendTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.resendSmsButton];

    self.stackView = [BTDropInUIUtilities newStackView];

    [self.stackView addArrangedSubview:smsSentHeader];
    [self.stackView addArrangedSubview:self.smsTextField];
    [self.stackView addArrangedSubview:self.resendSmsButton];

    self.resendSmsButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.resendSmsButton.heightAnchor constraintGreaterThanOrEqualToConstant:BTUIKAppearance.minimumHitArea].active = YES;

    [BTDropInUIUtilities addSpacerToStackView:self.stackView beforeView:smsSentHeader size:[BTUIKAppearance verticalFormSpace]];
    [BTDropInUIUtilities addSpacerToStackView:self.stackView beforeView:self.smsTextField size:[BTUIKAppearance verticalFormSpace]];
    [BTDropInUIUtilities addSpacerToStackView:self.stackView beforeView:self.resendSmsButton size:[BTUIKAppearance verticalFormSpaceTight]];

    [self.view addSubview:self.stackView];

    self.smsErrorView = [BTDropInUIUtilities newStackViewForError:BTDropInLocalizedString(SMS_CODE_INVALID)];
    [self smsErrorHidden:YES];

    NSDictionary* viewBindings = @{@"stackView": self.stackView};

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[stackView]" options:0 metrics:[BTUIKAppearance metrics] views:viewBindings]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[stackView]|" options:0 metrics:[BTUIKAppearance metrics] views:viewBindings]];
}


- (void)smsErrorHidden:(BOOL)hidden {
    NSInteger indexOfSMSCodeFormField = [self.stackView.arrangedSubviews indexOfObject:self.smsTextField];
    if (indexOfSMSCodeFormField != NSNotFound && !hidden) {
        [self.stackView insertArrangedSubview:self.smsErrorView atIndex:indexOfSMSCodeFormField + 1];
    } else if (self.smsErrorView.superview != nil && hidden) {
        [self.smsErrorView removeFromSuperview];
    }
}

- (void)formFieldDidChange:(BTUIKFormField *)formField {
    if (formField.text.length > 0) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
        self.navigationItem.rightBarButtonItem.accessibilityHint = nil;
    } else {
        self.navigationItem.rightBarButtonItem.enabled = NO;
        self.navigationItem.rightBarButtonItem.accessibilityHint = BTDropInLocalizedString(SMS_CODE_REQUIRED);
    }
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)resendTapped {
    self.handler(@"", YES);
}

- (void)confirm {
    self.handler(self.smsTextField.text, NO);
}

@end
