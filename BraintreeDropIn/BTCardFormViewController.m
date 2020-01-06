#import "BTCardFormViewController.h"
#import "BTDropInController.h"
#import "BTPaymentSelectionViewController.h"
#import "BTEnrollmentVerificationViewController.h"
#if __has_include("BraintreeCore.h")
#import "BraintreeCore.h"
#else
#import <BraintreeCore/BraintreeCore.h>
#endif
#import "BTAPIClient_Internal_Category.h"
#import "BTUIKBarButtonItem_Internal_Declaration.h"
#import "BTEnrollmentVerificationViewController.h"
#import "BTDropInUIUtilities.h"
#if __has_include("BraintreeCard.h")
#import "BraintreeCard.h"
#else
#import <BraintreeCard/BraintreeCard.h>
#endif
#if __has_include("BraintreeUnionPay.h")
#import "BraintreeUnionPay.h"
#else
#import <BraintreeUnionPay/BraintreeUnionPay.h>
#endif
#if __has_include("BraintreePaymentFlow.h")
#import "BraintreePaymentFlow.h"
#else
#import <BraintreePaymentFlow/BraintreePaymentFlow.h>
#endif

@interface BTCardFormViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *scrollViewContentWrapper;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong, readwrite) BTUIKCardNumberFormField *cardNumberField;
@property (nonatomic, strong, readwrite) BTUIKCardholderNameFormField *cardholderNameField;
@property (nonatomic, strong, readwrite) BTUIKExpiryFormField *expirationDateField;
@property (nonatomic, strong, readwrite) BTUIKSecurityCodeFormField *securityCodeField;
@property (nonatomic, strong, readwrite) BTUIKPostalCodeFormField *postalCodeField;
@property (nonatomic, strong, readwrite) BTUIKMobileCountryCodeFormField *mobileCountryCodeField;
@property (nonatomic, strong, readwrite) BTUIKMobileNumberFormField *mobilePhoneField;
@property (nonatomic, strong, readwrite) BTUIKSwitchFormField *shouldVaultCardSwitchField;
@property (nonatomic, strong) UIStackView *cardNumberErrorView;
@property (nonatomic, strong) UIStackView *cardNumberHeader;
@property (nonatomic, strong) UIStackView *enrollmentFooter;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) NSArray <BTUIKFormField *> *formFields;
@property (nonatomic, strong) NSMutableArray <BTUIKFormField *> *requiredFields;
@property (nonatomic, strong) NSMutableArray <BTUIKFormField *> *optionalFields;
@property (nonatomic, strong) UIStackView *cardNumberFooter;
@property (nonatomic, strong) BTUIKCardListLabel *cardList;
@property (nonatomic, getter=isCollapsed) BOOL collapsed;
@property (nonatomic, strong) BTUIKFormField *firstResponderFormField;
@property (nonatomic, strong, nullable, readwrite) BTCardCapabilities *cardCapabilities;
@property (nonatomic) BOOL unionPayEnabledMerchant;
@property (nonatomic, assign) BOOL cardEntryDidBegin;
@property (nonatomic, assign) BOOL cardEntryDidFocus;
@property (nonatomic, assign) BOOL enrollmentFailed;
@property (nonatomic, strong) NSString *enrollmentID;
@end

@implementation BTCardFormViewController

#pragma mark - Lifecycle

- (instancetype)initWithAPIClient:(BTAPIClient *)apiClient request:(nonnull BTDropInRequest *)request {
    if (self = [super initWithAPIClient:apiClient request:request]) {
        _requiredFields = [NSMutableArray new];
        _optionalFields = [NSMutableArray new];
        _supportedCardTypes = [NSArray new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Using ivar so that setter is not called
    _collapsed = YES;
    self.unionPayEnabledMerchant = NO;
    self.formFields = @[];
    self.view.backgroundColor = [BTUIKAppearance sharedInstance].formBackgroundColor;
    self.navigationController.navigationBar.barTintColor = [BTUIKAppearance sharedInstance].barBackgroundColor;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName: [BTUIKAppearance sharedInstance].primaryTextColor
                                                                      }];

    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView setAlwaysBounceVertical:NO];
    self.scrollView.scrollEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    self.scrollViewContentWrapper = [[UIView alloc] init];
    self.scrollViewContentWrapper.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:self.scrollViewContentWrapper];
    
    self.stackView = [BTDropInUIUtilities newStackView];
    [self.scrollViewContentWrapper addSubview:self.stackView];
    
    NSDictionary *viewBindings = @{@"stackView":self.stackView,
                                   @"scrollView":self.scrollView,
                                   @"scrollViewContentWrapper": self.scrollViewContentWrapper};
    
    [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [self.scrollView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollViewContentWrapper]|"
                                                                      options:0
                                                                      metrics:[BTUIKAppearance metrics]
                                                                        views:viewBindings]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollViewContentWrapper(scrollView)]|"
                                                                      options:0
                                                                      metrics:[BTUIKAppearance metrics]
                                                                        views:viewBindings]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[stackView]|"
                                                                      options:0
                                                                      metrics:[BTUIKAppearance metrics]
                                                                        views:viewBindings]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[stackView]-|"
                                                                      options:0
                                                                      metrics:[BTUIKAppearance metrics]
                                                                        views:viewBindings]];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    
    [self.view addGestureRecognizer:tapGesture];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [self setupForm];
    [self resetForm];
    [self showLoadingScreen:YES];
    [self loadConfiguration];
    
    self.firstResponderFormField = self.cardNumberField;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = BTUIKLocalizedString(CARD_DETAILS_LABEL);
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    if (self.firstResponderFormField) {
        [self.firstResponderFormField becomeFirstResponder];
        self.firstResponderFormField = nil;
    }
}

#pragma mark - Setup

- (void)setupForm {
    self.nextButton = [[UIButton alloc] init];
    [self.nextButton setTitle:BTUIKLocalizedString(NEXT_ACTION) forState:UIControlStateNormal];
    self.nextButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.nextButton setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    
    self.cardNumberField = [[BTUIKCardNumberFormField alloc] init];
    self.cardNumberField.delegate = self;
    self.cardNumberField.cardNumberDelegate = self;
    self.cardholderNameField = [[BTUIKCardholderNameFormField alloc] init];
    self.cardholderNameField.delegate = self;
    self.cardholderNameField.isRequired = (self.dropInRequest.cardholderNameSetting == BTFormFieldRequired);
    self.expirationDateField = [[BTUIKExpiryFormField alloc] init];
    self.expirationDateField.delegate = self;
    self.securityCodeField = [[BTUIKSecurityCodeFormField alloc] init];
    self.securityCodeField.delegate = self;
    self.securityCodeField.textField.secureTextEntry = self.dropInRequest.shouldMaskSecurityCode;
    self.postalCodeField = [[BTUIKPostalCodeFormField alloc] init];
    self.postalCodeField.delegate = self;
    self.mobileCountryCodeField = [[BTUIKMobileCountryCodeFormField alloc] init];
    self.mobileCountryCodeField.delegate = self;
    self.mobilePhoneField = [[BTUIKMobileNumberFormField alloc] init];
    self.mobilePhoneField.delegate = self;
    
    self.cardNumberHeader = [BTDropInUIUtilities newStackView];
    self.cardNumberHeader.layoutMargins = UIEdgeInsetsMake(0, [BTUIKAppearance verticalFormSpace], 0, [BTUIKAppearance verticalFormSpace]);
    self.cardNumberHeader.layoutMarginsRelativeArrangement = true;
    UILabel *cardNumberHeaderLabel = [[UILabel alloc] init];
    cardNumberHeaderLabel.numberOfLines = 0;
    cardNumberHeaderLabel.textAlignment = NSTextAlignmentCenter;
    cardNumberHeaderLabel.text = BTUIKLocalizedString(ENTER_CARD_DETAILS_HELP_LABEL);
    [BTUIKAppearance styleLargeLabelSecondary:cardNumberHeaderLabel];
    [self.cardNumberHeader addArrangedSubview:cardNumberHeaderLabel];
    [BTDropInUIUtilities addSpacerToStackView:self.cardNumberHeader beforeView:cardNumberHeaderLabel size: [BTUIKAppearance verticalFormSpace]];
    [self.stackView addArrangedSubview:self.cardNumberHeader];

    self.formFields = @[self.cardNumberField, self.cardholderNameField, self.expirationDateField, self.securityCodeField, self.postalCodeField, self.mobileCountryCodeField, self.mobilePhoneField];

    for (NSUInteger i = 0; i < self.formFields.count; i++) {
        BTUIKFormField *formField = self.formFields[i];
        [self.stackView addArrangedSubview:formField];
        
        NSLayoutConstraint* heightConstraint = [formField.heightAnchor constraintEqualToConstant:[BTUIKAppearance formCellHeight]];
        // Setting the priority is necessary to avoid autolayout errors when UIStackView rotates
        heightConstraint.priority = UILayoutPriorityDefaultHigh;
        heightConstraint.active = YES;
        
        [formField updateConstraints];
    }
    
    self.cardNumberField.formLabel.text = @"";
    [self.cardNumberField updateConstraints];
    
    self.cardholderNameField.hidden = YES;
    self.expirationDateField.hidden = YES;
    self.securityCodeField.hidden = YES;
    self.postalCodeField.hidden = YES;
    self.mobileCountryCodeField.hidden = YES;
    self.mobilePhoneField.hidden = YES;

    [BTDropInUIUtilities addSpacerToStackView:self.stackView beforeView:self.cardNumberField size: [BTUIKAppearance verticalFormSpace]];
    [BTDropInUIUtilities addSpacerToStackView:self.stackView beforeView:self.cardholderNameField size: [BTUIKAppearance verticalFormSpace]];
    [BTDropInUIUtilities addSpacerToStackView:self.stackView beforeView:self.mobileCountryCodeField size: [BTUIKAppearance verticalFormSpace]];

    self.cardNumberFooter = [BTDropInUIUtilities newStackView];
    self.cardNumberFooter.layoutMargins = UIEdgeInsetsMake(0, [BTUIKAppearance verticalFormSpace], 0, [BTUIKAppearance verticalFormSpace]);
    self.cardNumberFooter.layoutMarginsRelativeArrangement = true;
    [self.stackView addArrangedSubview:self.cardNumberFooter];
    self.cardList = [BTUIKCardListLabel new];
    self.cardList.translatesAutoresizingMaskIntoConstraints = NO;
    self.cardList.availablePaymentOptions = self.supportedCardTypes;
    [self.cardNumberFooter addArrangedSubview:self.cardList];
    [BTDropInUIUtilities addSpacerToStackView:self.cardNumberFooter beforeView:self.cardList size: [BTUIKAppearance horizontalFormContentPadding]];
    
    NSUInteger indexOfCardNumberField = [self.stackView.arrangedSubviews indexOfObject:self.cardNumberField];
    [self.stackView insertArrangedSubview:self.cardNumberFooter atIndex:(indexOfCardNumberField + 1)];
    
    [self updateFormBorders];
    
    //Error labels
    self.cardNumberErrorView = [BTDropInUIUtilities newStackViewForError:@""];
    [self cardNumberErrorHidden:YES];
    
    //Enrollment footer
    self.enrollmentFooter = [BTDropInUIUtilities newStackView];
    self.enrollmentFooter.layoutMargins = UIEdgeInsetsMake(0, [BTUIKAppearance horizontalFormContentPadding], 0, [BTUIKAppearance horizontalFormContentPadding]);
    self.enrollmentFooter.layoutMarginsRelativeArrangement = true;
    UILabel *enrollmentFooterLabel = [[UILabel alloc] init];
    enrollmentFooterLabel.numberOfLines = 0;
    enrollmentFooterLabel.textAlignment = [BTUIKViewUtil naturalTextAlignment];
    enrollmentFooterLabel.text = BTUIKLocalizedString(ENROLLMENT_WITH_SMS_HELP_LABEL);
    [BTUIKAppearance styleLabelSecondary:enrollmentFooterLabel];
    [self.enrollmentFooter addArrangedSubview:enrollmentFooterLabel];
    [BTDropInUIUtilities addSpacerToStackView:self.enrollmentFooter beforeView:enrollmentFooterLabel size: [BTUIKAppearance verticalFormSpaceTight]];
    self.enrollmentFooter.hidden = YES;
    [self.stackView addArrangedSubview:self.enrollmentFooter];

    self.shouldVaultCardSwitchField = [[BTUIKSwitchFormField alloc] initWithTitle:BTUIKLocalizedString(SAVE_CARD_LABEL)];
    self.shouldVaultCardSwitchField.hidden = YES;
    [self.stackView addArrangedSubview:self.shouldVaultCardSwitchField];
}

- (void)configurationLoaded:(__unused BTConfiguration *)configuration error:(NSError *)error {
    [self showLoadingScreen:NO];
    if (!error) {
        self.collapsed = YES;
        self.unionPayEnabledMerchant = NO;
        BTJSON *unionPayJSON = self.configuration.json[@"unionPay"];
        if (![unionPayJSON isError] && [unionPayJSON[@"enabled"] isTrue] && !self.apiClient.tokenizationKey) {
            self.unionPayEnabledMerchant = YES;
            [self.cardNumberField setAccessoryViewHidden:NO animated:NO];
        }
        self.cardNumberField.state = BTUIKCardNumberFormFieldStateValidate;
        [self updateRequiredFields];
    }
}

- (void)updateRequiredFields {
    NSArray <NSString *> *challenges = [self.configuration.json[@"challenges"] asStringArray];
    self.requiredFields = [NSMutableArray arrayWithObject:self.cardNumberField];
    if (self.dropInRequest.cardholderNameSetting != BTFormFieldDisabled) {
        [self.requiredFields addObject:self.cardholderNameField];
    }
    [self.requiredFields addObject:self.expirationDateField];
    if ([challenges containsObject:@"cvv"]) {
        [self.requiredFields addObject:self.securityCodeField];
    }
    if ([challenges containsObject:@"postal_code"]) {
        [self.requiredFields addObject:self.postalCodeField];
    }
}

#pragma mark - Custom accessors

- (BTCardRequest *)cardRequest {
    if (![self isFormValid]) {
        return nil;
    }
    
    BTCard *card = [[BTCard alloc] initWithNumber:self.cardNumberField.number
                                  expirationMonth:self.expirationDateField.expirationMonth
                                   expirationYear:self.expirationDateField.expirationYear
                                              cvv:self.securityCodeField.securityCode];
    
    if ([self.requiredFields containsObject:self.postalCodeField]) {
        card.postalCode = self.postalCodeField.postalCode;
    }
    if (self.cardholderNameField.cardholderName.length) {
        card.cardholderName = self.cardholderNameField.cardholderName;
    }
    
    card.shouldValidate = self.shouldVaultCardSwitchField.switchControl.isOn;
    BTCardRequest *cardRequest = [[BTCardRequest alloc] initWithCard:card];
    
    if (self.cardCapabilities != nil && self.cardCapabilities.isUnionPay && self.cardCapabilities.isSupported) {
        cardRequest.mobileCountryCode = self.mobileCountryCodeField.countryCode;
        cardRequest.mobilePhoneNumber = self.mobilePhoneField.mobileNumber;
    }
    
    return cardRequest;
}

- (void)setCollapsed:(BOOL)collapsed {
    if (collapsed == self.collapsed) {
        return;
    }
    // Using ivar so that setter is not called
    _collapsed = collapsed;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionAllowAnimatedContent|UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.cardNumberHeader.hidden = !collapsed;
            self.cardholderNameField.hidden = (self.dropInRequest.cardholderNameSetting == BTFormFieldDisabled) || collapsed;
            self.expirationDateField.hidden = collapsed;
            self.securityCodeField.hidden = ![self.requiredFields containsObject:self.securityCodeField] || collapsed;
            self.postalCodeField.hidden = ![self.requiredFields containsObject:self.postalCodeField] || collapsed;
            self.mobileCountryCodeField.hidden = ![self.requiredFields containsObject:self.mobileCountryCodeField] || collapsed;
            self.mobilePhoneField.hidden = ![self.requiredFields containsObject:self.mobilePhoneField] || collapsed;
            self.enrollmentFooter.hidden = self.mobilePhoneField.hidden;
            self.shouldVaultCardSwitchField.hidden = ![self shouldDisplaySaveCardToggle] || collapsed;
            [self updateFormBorders];
        } completion:^(__unused BOOL finished) {
            self.cardNumberFooter.hidden = !collapsed;
            self.cardNumberHeader.hidden = !collapsed;
            self.cardholderNameField.hidden = (self.dropInRequest.cardholderNameSetting == BTFormFieldDisabled) || collapsed;
            self.expirationDateField.hidden = collapsed;
            self.securityCodeField.hidden = ![self.requiredFields containsObject:self.securityCodeField] || collapsed;
            self.postalCodeField.hidden = ![self.requiredFields containsObject:self.postalCodeField] || collapsed;
            self.mobileCountryCodeField.hidden = ![self.requiredFields containsObject:self.mobileCountryCodeField] || collapsed;
            self.mobilePhoneField.hidden = ![self.requiredFields containsObject:self.mobilePhoneField] || collapsed;
            self.enrollmentFooter.hidden = self.mobilePhoneField.hidden;
            self.shouldVaultCardSwitchField.hidden = ![self shouldDisplaySaveCardToggle] || collapsed;
            
            [self updateFormBorders];
            [self updateSubmitButton];
        }];
    });
}

- (BOOL)shouldDisplaySaveCardToggle {
    return self.dropInRequest.allowVaultCardOverride && self.apiClient.tokenizationKey == nil;
}

#pragma mark - Public methods

- (void)resetForm {
    self.navigationItem.leftBarButtonItem = [[BTUIKBarButtonItem alloc] initWithTitle:BTUIKLocalizedString(CANCEL_ACTION) style:UIBarButtonItemStylePlain target:self action:@selector(cancelTapped)];
    BTUIKBarButtonItem *addButton = [[BTUIKBarButtonItem alloc] initWithTitle:BTUIKLocalizedString(ADD_CARD_ACTION) style:UIBarButtonItemStylePlain target:self action:@selector(tokenizeCard)];
    addButton.bold = YES;
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    for (BTUIKFormField *formField in self.formFields) {
        formField.text = @"";
        formField.hidden = YES;
    }
    // Using ivar so that setter is not called
    _collapsed = YES;
    self.unionPayEnabledMerchant = NO;
    self.cardNumberField.hidden = NO;
    [self.cardNumberField resetFormField];
    self.cardNumberFooter.hidden = NO;
    self.cardNumberHeader.hidden = NO;
    [self.cardList emphasizePaymentOption:BTUIKPaymentOptionTypeUnknown];
    self.shouldVaultCardSwitchField.switchControl.on = self.dropInRequest.vaultCard && self.apiClient.tokenizationKey == nil;
    [self updateFormBorders];
}

#pragma mark - Keyboard management

- (void)hideKeyboard {
    [self.view endEditing:YES];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyboardRectInWindow = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGSize keyboardSize = [self.view convertRect:keyboardRectInWindow fromView:nil].size;
    UIEdgeInsets scrollInsets = self.scrollView.contentInset;
    scrollInsets.bottom = keyboardSize.height;
    self.scrollView.contentInset = scrollInsets;
    self.scrollView.scrollIndicatorInsets = scrollInsets;
}

- (void)keyboardWillHide:(__unused NSNotification *)notification {
    UIEdgeInsets scrollInsets = self.scrollView.contentInset;
    scrollInsets.bottom = 0.0;
    self.scrollView.contentInset = scrollInsets;
    self.scrollView.scrollIndicatorInsets = scrollInsets;
}

#pragma mark - Helper methods

- (void)cancelTapped {
    [self hideKeyboard];
    [self.delegate reloadDropInData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)updateFormBorders {
    self.cardNumberField.bottomBorder = YES;
    self.cardNumberField.topBorder = YES;
    
    self.mobileCountryCodeField.topBorder = YES;
    self.mobileCountryCodeField.interFieldBorder = YES;
    self.mobilePhoneField.bottomBorder = YES;

    NSArray *groupedFormFields = @[self.cardholderNameField, self.expirationDateField, self.securityCodeField, self.postalCodeField];
    BOOL topBorderAdded = NO;
    BTUIKFormField* lastVisibleFormField;
    for (NSUInteger i = 0; i < groupedFormFields.count; i++) {
        BTUIKFormField *formField = groupedFormFields[i];
        if (!formField.hidden) {
            if (!topBorderAdded) {
                formField.topBorder = YES;
                topBorderAdded = YES;
            } else {
                formField.topBorder = NO;
            }
            formField.bottomBorder = NO;
            formField.interFieldBorder = YES;
            lastVisibleFormField = formField;
        }
    }
    if (lastVisibleFormField) {
        lastVisibleFormField.bottomBorder = YES;
    }
}


- (BOOL)isFormValid {
    __block BOOL isFormValid = YES;
    [self.requiredFields enumerateObjectsUsingBlock:^(BTUIKFormField * _Nonnull formField, __unused NSUInteger idx, BOOL * _Nonnull stop) {
        if (![self.optionalFields containsObject:formField] && !formField.valid) {
            *stop = YES;
            isFormValid = NO;
        }
    }];
    return isFormValid;
}

- (void)updateSubmitButton {
    if (!self.collapsed && [self isFormValid]) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    } else {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

- (void)advanceFocusFromField:(BTUIKFormField *)currentField {
    NSUInteger currentIdx = [self.requiredFields indexOfObject:currentField];
    if (currentIdx < [self.requiredFields count] - 1) {
        [[self.requiredFields objectAtIndex:currentIdx + 1] becomeFirstResponder];
    }
}

- (void)fetchCardCapabilities {
    [self cardNumberErrorHidden:YES];
    self.cardNumberField.state = BTUIKCardNumberFormFieldStateLoading;
    
    BTCardClient *unionPayClient = [[BTCardClient alloc] initWithAPIClient:self.apiClient];
    [unionPayClient fetchCapabilities:self.cardNumberField.number completion:^(BTCardCapabilities * _Nullable cardCapabilities, NSError * _Nullable error) {
        if (error || (!cardCapabilities.isUnionPay && !self.cardNumberField.valid)) {
            [self cardNumberErrorHidden:NO];
            self.cardNumberField.state = BTUIKCardNumberFormFieldStateValidate;
            return;
        } else if (cardCapabilities.isUnionPay && !cardCapabilities.isSupported) {
            [self cardNumberErrorHidden:NO];
            self.cardNumberField.state = BTUIKCardNumberFormFieldStateValidate;
            return;
        }
        if (cardCapabilities.isUnionPay) {
            self.requiredFields = [NSMutableArray arrayWithArray:@[self.cardNumberField, self.expirationDateField]];
        } else {
            [self updateRequiredFields];
        }
        self.optionalFields = [NSMutableArray new];
        self.cardCapabilities = cardCapabilities;
        if (cardCapabilities.isUnionPay) {
            if (cardCapabilities.isDebit) {
                [self.requiredFields addObject:self.securityCodeField];
                [self.optionalFields addObject:self.securityCodeField];
                [self.optionalFields addObject:self.expirationDateField];
            } else {
                [self.requiredFields addObject:self.securityCodeField];
            }
            [self.requiredFields addObject:self.mobileCountryCodeField];
            [self.requiredFields addObject:self.mobilePhoneField];
        }
        
        self.securityCodeField.textField.placeholder = self.cardNumberField.cardType.securityCodeName;
        self.cardNumberField.state = BTUIKCardNumberFormFieldStateDefault;
        self.collapsed = NO;
        [self advanceFocusFromField:self.cardNumberField];
        [self formFieldDidChange:nil];
    }];
}

- (void)cardNumberErrorHidden:(BOOL)hidden {
    [self cardNumberErrorHidden:hidden errorString:BTUIKLocalizedString(VALID_CARD_ERROR_LABEL)];
}

- (void)cardNumberErrorHidden:(BOOL)hidden errorString:(NSString *)errorString {
    NSInteger indexOfCardNumberFormField = [self.stackView.arrangedSubviews indexOfObject:self.cardNumberField];
    if (indexOfCardNumberFormField != NSNotFound && !hidden) {
        [self.stackView insertArrangedSubview:self.cardNumberErrorView atIndex:indexOfCardNumberFormField + 1];
        UILabel *errorLabel = self.cardNumberErrorView.arrangedSubviews.firstObject;
        errorLabel.text = errorString;
        errorLabel.accessibilityLabel = errorString;
        errorLabel.accessibilityHint = BTUIKLocalizedString(REVIEW_AND_TRY_AGAIN);
        UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification,
                                        errorLabel);
    } else if (self.cardNumberErrorView.superview != nil && hidden) {
        [self.cardNumberErrorView removeFromSuperview];
    }
}

- (void)tokenizeCard {
    [self.view endEditing:YES];

    if (self.cardCapabilities != nil && self.cardCapabilities.isUnionPay && self.cardCapabilities.isSupported) {
        [self enrollCard];
    } else {
        [self basicTokenization];
    }
}

- (void)basicTokenization {
    BTCardRequest *cardRequest = self.cardRequest;
    BTCardClient *cardClient = [[BTCardClient alloc] initWithAPIClient:self.apiClient];

    UIActivityIndicatorView *spinner = [UIActivityIndicatorView new];
    spinner.activityIndicatorViewStyle = [BTUIKAppearance sharedInstance].activityIndicatorViewStyle;
    [spinner startAnimating];

    UIBarButtonItem *addCardButton = self.navigationItem.rightBarButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    self.view.userInteractionEnabled = NO;
    __block UINavigationController *navController = self.navigationController;

    [cardClient tokenizeCard:cardRequest options:nil completion:^(BTCardNonce * _Nullable tokenizedCard, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.view.userInteractionEnabled = YES;

            self.navigationItem.rightBarButtonItem = addCardButton;

            if (error != nil) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:BTUIKLocalizedString(CARD_DETAILS_LABEL) message:BTUIKLocalizedString(REVIEW_AND_TRY_AGAIN) preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *alertAction = [UIAlertAction actionWithTitle:BTUIKLocalizedString(TOP_LEVEL_ERROR_ALERT_VIEW_OK_BUTTON_TEXT) style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction: alertAction];
                [navController presentViewController:alertController animated:YES completion:nil];
            } else {
                [self.delegate cardTokenizationCompleted:tokenizedCard error:error sender:self];
            }
        });
    }];
}

- (void)enrollCard {
    __block BTCardRequest *cardRequest = self.cardRequest;
    __block BTCardClient *cardClient = [[BTCardClient alloc] initWithAPIClient:self.apiClient];

    UIViewController *currentViewController = [self.navigationController topViewController];
    __block UIBarButtonItem *originalRightBarButtonItem = currentViewController.navigationItem.rightBarButtonItem;

    dispatch_async(dispatch_get_main_queue(), ^{
        UIActivityIndicatorView *spinner = [UIActivityIndicatorView new];
        spinner.activityIndicatorViewStyle = [BTUIKAppearance sharedInstance].activityIndicatorViewStyle;
        [spinner startAnimating];
        
        currentViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
        self.view.userInteractionEnabled = NO;
    });
    
    [cardClient enrollCard:cardRequest completion:^(NSString * _Nullable enrollmentID, BOOL smsCodeRequired, NSError * _Nullable error) {

        if (originalRightBarButtonItem) {
            [self.navigationController topViewController].navigationItem.rightBarButtonItem = originalRightBarButtonItem;
        }
        
        if (error) {
            [self.delegate cardTokenizationCompleted:nil error:error sender:self];
            return;
        }
        
        self.enrollmentID = enrollmentID;
        
        if (!smsCodeRequired) {
            [self basicTokenization];
            return;
        }
        
        // If a BTEnrollmentVerificationViewController is displayed, retry confirmation
        if ([[self.navigationController topViewController] isKindOfClass:[BTEnrollmentVerificationViewController class]]) {
            BTEnrollmentVerificationViewController *enrollmentController = (BTEnrollmentVerificationViewController*)[self.navigationController topViewController];
            [enrollmentController confirm];
            return;
        }
        
        __block UINavigationController *navController = self.navigationController;
        __block BTEnrollmentVerificationViewController *enrollmentController;
        enrollmentController = [[BTEnrollmentVerificationViewController alloc] initWithPhone:self.mobilePhoneField.mobileNumber mobileCountryCode:self.mobileCountryCodeField.countryCode handler:^(NSString* authCode, BOOL resend) {
            if (resend) {
                self.firstResponderFormField = self.mobilePhoneField;
                [self.navigationController popViewControllerAnimated:YES];
                return;
            }
            
            if (self.enrollmentFailed) {
                self.enrollmentFailed = NO;
                [self enrollCard];
                return;
            }
            
            __block UIBarButtonItem *originalRightBarButtonItem = enrollmentController.navigationItem.rightBarButtonItem;
            dispatch_async(dispatch_get_main_queue(), ^{
                UIActivityIndicatorView *spinner = [UIActivityIndicatorView new];
                spinner.activityIndicatorViewStyle = [BTUIKAppearance sharedInstance].activityIndicatorViewStyle;
                [spinner startAnimating];
                
                enrollmentController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
                self.view.userInteractionEnabled = NO;
            });
            
            cardRequest.smsCode = authCode;
            cardRequest.enrollmentID = self.enrollmentID;
            
            [cardClient tokenizeCard:cardRequest options:nil completion:^(BTCardNonce * _Nullable tokenizedCard, NSError * _Nullable error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.view.userInteractionEnabled = YES;
                    enrollmentController.navigationItem.rightBarButtonItem = originalRightBarButtonItem;
                    if (error) {
                        [enrollmentController smsErrorHidden:NO];
                        self.enrollmentFailed = YES;
                        return;
                    }
                    
                    [self.delegate cardTokenizationCompleted:tokenizedCard error:error sender:self];
                });
            }];
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.title = @"";
            [self.navigationController pushViewController:enrollmentController animated:YES];
            BTJSON *environment = self.configuration.json[@"environment"];
            if(![environment isError] && [[environment asString] isEqualToString:@"sandbox"]) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:BTUIKLocalizedString(DEV_SAMPLE_SMS_CODE_TITLE) message:BTUIKLocalizedString(DEV_SAMPLE_SMS_CODE_INFO) preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *alertAction = [UIAlertAction actionWithTitle:BTUIKLocalizedString(TOP_LEVEL_ERROR_ALERT_VIEW_OK_BUTTON_TEXT) style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction: alertAction];
                [navController presentViewController:alertController animated:YES completion:nil];
            }
            
        });
    }];
}

#pragma mark - Protocol conformance
#pragma mark FormField Delegate Methods

- (void)validateButtonPressed:(__unused BTUIKFormField *)formField {
    BTUIKCardType *cardType = self.cardNumberField.cardType;
    BOOL cardSupported = NO;
    for (id object in self.supportedCardTypes) {
        BTUIKPaymentOptionType supportedCardType = ((NSNumber*)object).intValue;
        if ( supportedCardType == [BTUIKViewUtil paymentMethodTypeForCardType:cardType]) {
            cardSupported = YES;
            break;
        }
    }
    if (!cardSupported) {
        [self cardNumberErrorHidden:NO errorString:BTUIKLocalizedString(CARD_NOT_ACCEPTED_ERROR_LABEL)];
        return;
    }
    
    if (!self.unionPayEnabledMerchant) {
        [self cardNumberErrorHidden:formField.valid];
        if (formField.valid) {
            self.cardNumberField.state = BTUIKCardNumberFormFieldStateDefault;
            self.collapsed = NO;
            [self advanceFocusFromField:formField];
        }
    } else {
        [self fetchCardCapabilities];
    }
}

- (void)formFieldDidBeginEditing:(__unused BTUIKFormField *)formField {
    if (!self.cardEntryDidFocus) {
        [self.apiClient sendAnalyticsEvent:@"ios.dropin2.card.focus"];
        self.cardEntryDidFocus = YES;
    }
    
    if (!self.collapsed && formField == self.cardNumberField) {
        self.cardNumberField.state = BTUIKCardNumberFormFieldStateValidate;
        self.collapsed = YES;
        if (self.unionPayEnabledMerchant) {
            self.cardCapabilities = nil;
        }
    }
}

- (void)formFieldDidChange:(BTUIKFormField *)formField {
    [self updateSubmitButton];
    
    // When focus moves from card number field, display the error state if the value in the field is invalid
    if (formField == self.cardNumberField && self.cardNumberField.state == BTUIKCardNumberFormFieldStateDefault) {
        [self cardNumberErrorHidden:self.cardNumberField.displayAsValid];
    }
    
    // Analytics event - fires when a customer begins entering card information
    if (!self.cardEntryDidBegin && formField.text.length > 0) {
        [self.apiClient sendAnalyticsEvent:@"ios.dropin2.add-card.start"];
        self.cardEntryDidBegin = YES;
    }
    
    // Highlight card brand in card hint view according to BIN number
    if (self.collapsed && formField == self.cardNumberField) {
        [self cardNumberErrorHidden:YES];
        BTUIKPaymentOptionType paymentMethodType = [BTUIKViewUtil paymentMethodTypeForCardType:self.cardNumberField.cardType];
        [self.cardList emphasizePaymentOption:paymentMethodType];
    }
    
    // Auto-advance fields when complete
    if (self.collapsed && formField == self.cardNumberField && formField.text.length > 0) {
        BTUIKCardType *cardType = self.cardNumberField.cardType;
        if (cardType != nil && formField.text.length >= cardType.maxNumberLength) {
            [self validateButtonPressed:formField];
        }
    } else if (formField == self.expirationDateField && formField.text.length > 0) {
        if (formField.text.length >= 5) {
            [self advanceFocusFromField:formField];
        }
    } else if (formField == self.securityCodeField && formField.text.length > 0) {
        BTUIKCardType *cardType = self.cardNumberField.cardType;
        if (cardType != nil && formField.text.length >= cardType.validCvvLength) {
            [self advanceFocusFromField:formField];
        }
    }
}

- (BOOL)formFieldShouldReturn:(BTUIKFormField *)formField {
    if (formField == self.cardholderNameField) {
        [self advanceFocusFromField:formField];
        return NO;
    }

    return YES;
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(__unused UITextField *)textField {
    return YES;
}

@end
