#import "BTEnrollmentVerificationViewController.h"
#import "BTUIKBarButtonItem_Internal_Declaration.h"
#import "BTDropInUIUtilities.h"

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
    self.title = BTUIKLocalizedString(CONFIRM_ENROLLMENT_LABEL);
    
    self.view.backgroundColor = [BTUIKAppearance sharedInstance].formBackgroundColor;
    if (@available(iOS 15.0, *)) {
        self.navigationController.navigationBar.scrollEdgeAppearance = self.navigationController.navigationBar.standardAppearance;
    }
    self.navigationController.navigationBar.barTintColor = [BTUIKAppearance sharedInstance].barBackgroundColor;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName: [BTUIKAppearance sharedInstance].primaryTextColor
                                                                      }];

    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    BTUIKBarButtonItem *confirmButton = [[BTUIKBarButtonItem alloc] initWithTitle:BTUIKLocalizedString(CONFIRM_ACTION) style:UIBarButtonItemStyleDone target:self action:@selector(confirm)];
    confirmButton.bold = YES;
    self.navigationItem.rightBarButtonItem = confirmButton;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [BTUIKAppearance sharedInstance].formBackgroundColor;
    self.smsSentLabel = [UILabel new];
    self.smsSentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.smsSentLabel.textAlignment = NSTextAlignmentCenter;
    NSString *fullMobileNumber = [NSString stringWithFormat:@"+%@ %@", self.mobileCountryCode, self.mobilePhoneNumber];
    self.smsSentLabel.text = [BTUIKLocalizedString insertIntoLocalizedString:BTUIKLocalizedString(ENTER_SMS_CODE_SENT_HELP_LABEL) replacement:fullMobileNumber];
    self.smsSentLabel.numberOfLines = 0;
    [self.view addSubview:self.smsSentLabel];
    [BTUIKAppearance styleLargeLabelSecondary:self.smsSentLabel];

    self.smsTextField = [BTUIKFormField new];
    self.smsTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.smsTextField.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.smsTextField.textField.placeholder = BTUIKLocalizedString(SMS_CODE_LABEL);
    self.smsTextField.delegate = self;
    [self.view addSubview:self.smsTextField];
    
    NSString *smsButtonText = BTUIKLocalizedString(USE_DIFFERENT_PHONE_NUMBER_ACTION);
    self.resendSmsButton = [UIButton new];
    self.resendSmsButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.resendSmsButton setTitle:smsButtonText forState:UIControlStateNormal];
    
    NSAttributedString *normalValidateButtonString = [[NSAttributedString alloc] initWithString:smsButtonText
                                                                                     attributes:@{NSForegroundColorAttributeName:[BTUIKAppearance sharedInstance].tintColor,
                                                                                                  NSFontAttributeName:[[BTUIKAppearance sharedInstance].font fontWithSize:UIFont.labelFontSize]}];
    [self.resendSmsButton setAttributedTitle:normalValidateButtonString forState:UIControlStateNormal];
    NSAttributedString *disabledValidateButtonString = [[NSAttributedString alloc] initWithString:smsButtonText
                                                                                       attributes:@{NSForegroundColorAttributeName:[BTUIKAppearance sharedInstance].disabledColor,
                                                                                                    NSFontAttributeName:[[BTUIKAppearance sharedInstance].font fontWithSize:UIFont.labelFontSize]}];
    [self.resendSmsButton setAttributedTitle:disabledValidateButtonString forState:UIControlStateDisabled];
    
    [self.resendSmsButton sizeToFit];
    [self.resendSmsButton layoutIfNeeded];
    [self.resendSmsButton addTarget:self action:@selector(resendTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.resendSmsButton];

    self.stackView = [BTDropInUIUtilities newStackView];

    [self.stackView addArrangedSubview:self.smsSentLabel];
    [self.stackView addArrangedSubview:self.smsTextField];
    [self.stackView addArrangedSubview:self.resendSmsButton];

    [BTDropInUIUtilities addSpacerToStackView:self.stackView beforeView:self.smsSentLabel size:[BTUIKAppearance verticalFormSpace]];
    [BTDropInUIUtilities addSpacerToStackView:self.stackView beforeView:self.smsTextField size:[BTUIKAppearance verticalFormSpace]];
    [BTDropInUIUtilities addSpacerToStackView:self.stackView beforeView:self.resendSmsButton size:[BTUIKAppearance verticalFormSpaceTight]];

    [self.smsTextField.heightAnchor constraintEqualToConstant:[BTUIKAppearance formCellHeight]].active = YES;

    [self.view addSubview:self.stackView];

    self.smsErrorView = [BTDropInUIUtilities newStackViewForError:BTUIKLocalizedString(SMS_CODE_INVALID)];
    [self smsErrorHidden:YES];

    NSDictionary* viewBindings = @{
                                   @"smsSentLabel": self.smsSentLabel,
                                   @"smsTextField": self.smsTextField,
                                   @"resendSmsButton": self.resendSmsButton,
                                   @"stackView": self.stackView,
                                   };

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
    } else {
        self.navigationItem.rightBarButtonItem.enabled = NO;
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
