#import "BraintreeDemoDropInViewController.h"

#import <PureLayout/PureLayout.h>
#import "BraintreeCore.h"
#import <BraintreeDropIn/BraintreeDropIn.h>
#import "BraintreeUIKit.h"
#import "BTPaymentSelectionViewController.h"
#import "BraintreeApplePay.h"
#import "BraintreeCard.h"
#import "BraintreePaymentFlow.h"
#import "BraintreePayPal.h"

#import "DropInDemo-Swift.h"

@interface BraintreeDemoDropInViewController () <PKPaymentAuthorizationViewControllerDelegate, BTViewControllerPresentingDelegate>

@property (nonatomic, strong) BTUIKPaymentOptionCardView *paymentMethodTypeIcon;
@property (nonatomic, strong) UILabel *paymentMethodTypeLabel;
@property (nonatomic, strong) UILabel *cartLabel;
@property (nonatomic, strong) UILabel *itemLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *paymentMethodHeaderLabel;
@property (nonatomic, strong) UIButton *dropInButton;
@property (nonatomic, strong) UIButton *purchaseButton;
@property (nonatomic, strong) UILabel *colorSchemeLabel;
@property (nonatomic, strong) UISegmentedControl *colorSchemeSegmentedControl;
@property (nonatomic, strong) NSString *authorizationString;
@property (nonatomic) BOOL useApplePay;
@property (nonatomic, strong) BTPaymentMethodNonce *selectedNonce;
@property (nonatomic, strong) NSArray *checkoutConstraints;
@property (nonatomic, readonly, strong) UIColor *secondaryLabelColor;

@end

@implementation BraintreeDemoDropInViewController

- (instancetype)initWithAuthorization:(NSString *)authorization {
    if (self = [super initWithAuthorization:authorization]) {

        self.authorizationString = authorization;
    }
    return self;
}

- (void)updatePaymentMethod:(BTPaymentMethodNonce*)paymentMethodNonce {
    self.paymentMethodTypeLabel.hidden = paymentMethodNonce == nil;
    self.paymentMethodTypeIcon.hidden = paymentMethodNonce == nil;
    if (paymentMethodNonce != nil) {
        BTUIKPaymentOptionType paymentMethodType = [BTUIKViewUtil paymentOptionTypeForPaymentInfoType:paymentMethodNonce.type];
        self.paymentMethodTypeIcon.paymentOptionType = paymentMethodType;
        [self.paymentMethodTypeLabel setText:paymentMethodNonce.localizedDescription];
    }
    [self updatePaymentMethodConstraints];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.cartLabel = [[UILabel alloc] init];
    [self.cartLabel setText:NSLocalizedString(@"CART", nil)];
    self.cartLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
    self.cartLabel.textColor = self.secondaryLabelColor;
    self.cartLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.cartLabel];

    self.itemLabel = [[UILabel alloc] init];
    [self.itemLabel setText:NSLocalizedString(@"1 Sock", nil)];
    self.itemLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.itemLabel];

    self.priceLabel = [[UILabel alloc] init];
    [self.priceLabel setText:NSLocalizedString(@"$10", nil)];
    self.priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.priceLabel];

    self.paymentMethodHeaderLabel = [[UILabel alloc] init];
    [self.paymentMethodHeaderLabel setText:NSLocalizedString(@"PAYMENT METHODS", nil)];
    self.paymentMethodHeaderLabel.textColor = self.secondaryLabelColor;
    self.paymentMethodHeaderLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
    self.paymentMethodHeaderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.paymentMethodHeaderLabel];

    self.dropInButton = [[UIButton alloc] init];
    [self.dropInButton setTitle:NSLocalizedString(@"Select Payment Method", nil) forState:UIControlStateNormal];
    [self.dropInButton setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    self.dropInButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.dropInButton addTarget:self action:@selector(tappedToShowDropIn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dropInButton];

    self.purchaseButton = [[UIButton alloc] init];
    [self.purchaseButton setTitle:NSLocalizedString(@"Complete Purchase", nil) forState:UIControlStateNormal];
    [self.purchaseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.purchaseButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.8] forState:UIControlStateHighlighted];
    self.purchaseButton.backgroundColor = self.view.tintColor;
    self.purchaseButton.translatesAutoresizingMaskIntoConstraints = NO;

    [self.purchaseButton addTarget:self action:@selector(purchaseButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    self.purchaseButton.layer.cornerRadius = 4.0;
    [self.view addSubview:self.purchaseButton];

    self.paymentMethodTypeIcon = [BTUIKPaymentOptionCardView new];
    self.paymentMethodTypeIcon.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.paymentMethodTypeIcon];
    self.paymentMethodTypeIcon.hidden = YES;

    self.paymentMethodTypeLabel = [[UILabel alloc] init];
    self.paymentMethodTypeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.paymentMethodTypeLabel];
    self.paymentMethodTypeLabel.hidden = YES;

    self.colorSchemeLabel = [[UILabel alloc] init];
    [self.colorSchemeLabel setText:NSLocalizedString(@"COLOR SCHEME", nil)];
    self.colorSchemeLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
    self.colorSchemeLabel.textColor = self.secondaryLabelColor;
    self.colorSchemeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.colorSchemeLabel];

    NSArray<NSString *> *colorSchemes;
    if (@available(iOS 13, *)) {
        colorSchemes = @[@"Light", @"Dark", @"Dynamic"];
    } else {
        colorSchemes = @[@"Light", @"Dark"];
    }
    
    self.colorSchemeSegmentedControl = [[UISegmentedControl alloc] initWithItems:colorSchemes];
    self.colorSchemeSegmentedControl.translatesAutoresizingMaskIntoConstraints = NO;
    self.colorSchemeSegmentedControl.selectedSegmentIndex = DemoSettings.colorSchemeSetting;
    [self.colorSchemeSegmentedControl addTarget:self action:@selector(tappedColorSchemeSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.colorSchemeSegmentedControl];
    
    [self updatePaymentMethodConstraints];
    [self fetchPaymentMethods];
}

- (void)fetchPaymentMethods {
    self.progressBlock(@"Fetching customer's payment methods...");
    self.useApplePay = NO;

    [BTDropInResult fetchDropInResultForAuthorization:self.authorizationString handler:^(BTDropInResult * _Nullable result, NSError * _Nullable error) {
        if (error) {
            self.progressBlock([NSString stringWithFormat:@"Error: %@", error.localizedDescription]);
            NSLog(@"Error: %@", error);
        } else {
            if (result.paymentOptionType == BTUIKPaymentOptionTypeApplePay) {
                self.progressBlock(@"Ready for checkout...");
                [self setupApplePay];
            } else {
                self.useApplePay = NO;
                self.selectedNonce = result.paymentMethod;
                self.progressBlock(@"Ready for checkout...");
                [self updatePaymentMethod:self.selectedNonce];
            }
        }
    }];
}

- (void)setupApplePay {
    self.paymentMethodTypeLabel.hidden = NO;
    self.paymentMethodTypeIcon.hidden = NO;
    self.paymentMethodTypeIcon.paymentOptionType = BTUIKPaymentOptionTypeApplePay;
    [self.paymentMethodTypeLabel setText:NSLocalizedString(@"Apple Pay", nil)];
    self.useApplePay = YES;
    [self updatePaymentMethodConstraints];
}

#pragma mark Colors

- (UIColor *)secondaryLabelColor {
    if (@available(iOS 13,*)) {
        return UIColor.secondaryLabelColor;
    } else {
        return UIColor.grayColor;
    }
}

#pragma mark Constraints

- (void)updatePaymentMethodConstraints {
    if (self.checkoutConstraints) {
        [NSLayoutConstraint deactivateConstraints:self.checkoutConstraints];
    }

    NSDictionary *viewBindings = @{
                                   @"view": self,
                                   @"cartLabel": self.cartLabel,
                                   @"itemLabel": self.itemLabel,
                                   @"priceLabel": self.priceLabel,
                                   @"paymentMethodHeaderLabel": self.paymentMethodHeaderLabel,
                                   @"dropInButton": self.dropInButton,
                                   @"paymentMethodTypeIcon": self.paymentMethodTypeIcon,
                                   @"paymentMethodTypeLabel": self.paymentMethodTypeLabel,
                                   @"purchaseButton":self.purchaseButton,
                                   @"colorSchemeLabel": self.colorSchemeLabel,
                                   @"colorSchemeSegmentedControl":self.colorSchemeSegmentedControl
                                   };
    
    NSMutableArray *newConstraints = [NSMutableArray new];
    [newConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[cartLabel]-|" options:0 metrics:nil views:viewBindings]];
    [newConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[purchaseButton]-|" options:0 metrics:nil views:viewBindings]];
    [newConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(20)-[cartLabel]-[itemLabel]-[paymentMethodHeaderLabel]" options:0 metrics:nil views:viewBindings]];
    [newConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[itemLabel]-[priceLabel]-|" options:NSLayoutFormatAlignAllTop metrics:nil views:viewBindings]];
    [newConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[paymentMethodHeaderLabel]-|" options:0 metrics:nil views:viewBindings]];
    [newConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[colorSchemeLabel]-|" options:0 metrics:nil views:viewBindings]];

    if (!self.paymentMethodTypeIcon.hidden && !self.paymentMethodTypeLabel.hidden) {
        [newConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[paymentMethodHeaderLabel]-[paymentMethodTypeIcon(29)]-[dropInButton]" options:0 metrics:nil views:viewBindings]];
        [newConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[paymentMethodTypeIcon(45)]-[paymentMethodTypeLabel]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewBindings]];
        [newConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[dropInButton]-|" options:0 metrics:nil views:viewBindings]];
        [self.dropInButton setTitle:NSLocalizedString(@"Change Payment Method", nil) forState:UIControlStateNormal];
        self.purchaseButton.backgroundColor = self.view.tintColor;
        self.purchaseButton.enabled = YES;
    } else {
        [newConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[paymentMethodHeaderLabel]-[dropInButton]" options:0 metrics:nil views:viewBindings]];
        [newConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[dropInButton]-|" options:0 metrics:nil views:viewBindings]];
        [self.dropInButton setTitle:NSLocalizedString(@"Add Payment Method", nil) forState:UIControlStateNormal];
        self.purchaseButton.backgroundColor = self.secondaryLabelColor;
        self.purchaseButton.enabled = NO;
    }
    [newConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[dropInButton]-(20)-[purchaseButton]-(20)-[colorSchemeLabel]-[colorSchemeSegmentedControl]" options:0 metrics:nil views:viewBindings]];
    [newConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[colorSchemeSegmentedControl]-|" options:0 metrics:nil views:viewBindings]];
    
    self.checkoutConstraints = newConstraints;
    [self.view addConstraints:self.checkoutConstraints];
}

#pragma mark Button Handlers

- (void)tappedColorSchemeSegmentedControl:(UISegmentedControl *)segmentedControl {
    DemoSettings.colorSchemeSetting = segmentedControl.selectedSegmentIndex;
}

- (void)purchaseButtonPressed {
    if (self.useApplePay) {

        PKPaymentRequest *paymentRequest = [[PKPaymentRequest alloc] init];
        paymentRequest.paymentSummaryItems = @[
                                               [PKPaymentSummaryItem summaryItemWithLabel:@"Socks" amount:[NSDecimalNumber decimalNumberWithString:@"10"]]
                                               ];
        paymentRequest.supportedNetworks = @[PKPaymentNetworkVisa, PKPaymentNetworkMasterCard, PKPaymentNetworkAmex, PKPaymentNetworkDiscover];
        paymentRequest.merchantCapabilities = PKMerchantCapability3DS;
        paymentRequest.currencyCode = @"USD";
        paymentRequest.countryCode = @"US";
        
        switch (DemoSettings.currentEnvironment) {
            case DemoEnvironmentSandbox:
                paymentRequest.merchantIdentifier = @"merchant.com.braintreepayments.sandbox.Braintree-Demo";
                break;
            case DemoEnvironmentProduction:
                paymentRequest.merchantIdentifier = @"merchant.com.braintreepayments.Braintree-Demo";
                break;
            case DemoEnvironmentCustom:
                self.progressBlock(@"Direct Apple Pay integration does not support custom environments in this Demo App");
                break;
        }
        
        PKPaymentAuthorizationViewController *viewController = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:paymentRequest];
        viewController.delegate = self;
        
        self.progressBlock(@"Presenting Apple Pay Sheet");
        [self presentViewController:viewController animated:YES completion:nil];
    } else if (DemoSettings.threeDSecureRequiredStatus == DemoThreeDSecureRequiredSettingRequired
               && [self nonceRequiresThreeDSecureVerification:self.selectedNonce]) {
        [self performThreeDSecureVerification];
    } else {
        self.completionBlock(self.selectedNonce);
        self.transactionBlock();
    }
}

- (void)tappedToShowDropIn {
    BTDropInRequest *dropInRequest = [[BTDropInRequest alloc] init];

    BTUIKAppearance.sharedInstance.colorScheme = DemoSettings.colorSchemeSetting;

    dropInRequest.vaultManager = ![[[NSProcessInfo processInfo] arguments] containsObject:@"-DisableEditMode"];
    [BTUIKLocalizedString setCustomTranslations:@[@"cs"]];

    dropInRequest.paypalDisabled = DemoSettings.paypalDisabled;
    dropInRequest.venmoDisabled = DemoSettings.venmoDisabled;
    dropInRequest.cardDisabled = [[[NSProcessInfo processInfo] arguments] containsObject:@"-CardDisabled"];
    dropInRequest.shouldMaskSecurityCode = DemoSettings.maskSecurityCode;
    dropInRequest.cardholderNameSetting = DemoSettings.cardholderNameSetting;
    dropInRequest.vaultCard = DemoSettings.vaultCardSetting;
    dropInRequest.allowVaultCardOverride = DemoSettings.allowVaultCardOverrideSetting;

    if ([[[NSProcessInfo processInfo] arguments] containsObject:@"-PayPalOneTime"]) {
        dropInRequest.payPalRequest = [[BTPayPalRequest alloc] initWithAmount:@"4.77"];
    }

    if (DemoSettings.threeDSecureRequiredStatus == DemoThreeDSecureRequiredSettingRequired) {
        dropInRequest.threeDSecureVerification = YES;
        BTThreeDSecureRequest *threeDSecureRequest = [BTThreeDSecureRequest new];
        threeDSecureRequest.amount = [NSDecimalNumber decimalNumberWithString:@"10.32"];
        threeDSecureRequest.versionRequested = DemoSettings.threeDSecureRequestedVersion;
        
        BTThreeDSecurePostalAddress *billingAddress = [BTThreeDSecurePostalAddress new];
        billingAddress.givenName = @"Jill";
        billingAddress.surname = @"Doe";
        billingAddress.streetAddress = @"555 Smith St.";
        billingAddress.extendedAddress = @"#5";
        billingAddress.locality = @"Oakland";
        billingAddress.region = @"CA";
        billingAddress.countryCodeAlpha2 = @"US";
        billingAddress.postalCode = @"12345";
        billingAddress.phoneNumber = @"8101234567";
        threeDSecureRequest.billingAddress = billingAddress;
        threeDSecureRequest.email = @"test@example.com";
        threeDSecureRequest.shippingMethod = @"01";
        dropInRequest.threeDSecureRequest = threeDSecureRequest;
    }

    BTDropInController *dropIn = [[BTDropInController alloc] initWithAuthorization:self.authorizationString
                                                                           request:dropInRequest
                                                                           handler:^(BTDropInController * _Nonnull dropInController,
                                                                                     BTDropInResult * _Nullable result,
                                                                                     NSError * _Nullable error) {
                                                                               
                                                                               if (error) {
                                                                                   self.progressBlock([NSString stringWithFormat:@"Error: %@", error.localizedDescription]);
                                                                                   NSLog(@"Error: %@", error);
                                                                               } else if (result.isCancelled) {
                                                                                   self.progressBlock(@"Cancelled🎲");
                                                                               } else if (result.paymentOptionType == BTUIKPaymentOptionTypeApplePay) {
                                                                                   self.progressBlock(@"Ready for checkout...");
                                                                                   [self setupApplePay];
                                                                               } else {
                                                                                   self.useApplePay = NO;
                                                                                   self.selectedNonce = result.paymentMethod;
                                                                                   self.progressBlock(@"Ready for checkout...");
                                                                                   [self updatePaymentMethod:self.selectedNonce];
                                                                               }
                                                                               NSLog(@"%@", dropInController);
                                                                               [dropInController dismissViewControllerAnimated:YES completion:nil];
                                                                           }];

    [self presentViewController:dropIn animated:YES completion:nil];
}

#pragma mark PKPaymentAuthorizationViewControllerDelegate

- (void)paymentAuthorizationViewController:(__unused PKPaymentAuthorizationViewController *)controller
                   didSelectShippingMethod:(PKShippingMethod *)shippingMethod
                                completion:(void (^)(PKPaymentAuthorizationStatus, NSArray<PKPaymentSummaryItem *> * _Nonnull))completion
{
    PKPaymentSummaryItem *testItem = [PKPaymentSummaryItem summaryItemWithLabel:@"SOME ITEM" amount:[NSDecimalNumber decimalNumberWithString:@"10"]];
    if ([shippingMethod.identifier isEqualToString:@"fast"]) {
        completion(PKPaymentAuthorizationStatusSuccess,
                   @[
                     testItem,
                     [PKPaymentSummaryItem summaryItemWithLabel:@"SHIPPING" amount:shippingMethod.amount],
                     [PKPaymentSummaryItem summaryItemWithLabel:@"BRAINTREE" amount:[testItem.amount decimalNumberByAdding:shippingMethod.amount]],
                     ]);
    } else if ([shippingMethod.identifier isEqualToString:@"fail"]) {
        completion(PKPaymentAuthorizationStatusFailure, @[testItem]);
    } else {
        completion(PKPaymentAuthorizationStatusSuccess, @[testItem]);
    }
}

- (void)paymentAuthorizationViewController:(__unused PKPaymentAuthorizationViewController *)controller didAuthorizePayment:(PKPayment *)payment handler:(void (^)(PKPaymentAuthorizationResult * _Nonnull))completion API_AVAILABLE(ios(11.0), watchos(4.0)) {
    self.progressBlock(@"Apple Pay Did Authorize Payment");
    BTAPIClient *client = [[BTAPIClient alloc] initWithAuthorization:self.authorizationString];
    BTApplePayClient *applePayClient = [[BTApplePayClient alloc] initWithAPIClient:client];
    [applePayClient tokenizeApplePayPayment:payment completion:^(BTApplePayCardNonce * _Nullable tokenizedApplePayPayment, NSError * _Nullable error) {
        if (error) {
            self.progressBlock(error.localizedDescription);
            completion([[PKPaymentAuthorizationResult alloc] initWithStatus:PKPaymentAuthorizationStatusFailure errors:nil]);
        } else {
            self.completionBlock(tokenizedApplePayPayment);
            completion([[PKPaymentAuthorizationResult alloc] initWithStatus:PKPaymentAuthorizationStatusSuccess errors:nil]);
        }
    }];
}

- (void)paymentAuthorizationViewController:(__unused PKPaymentAuthorizationViewController *)controller
                       didAuthorizePayment:(PKPayment *)payment
                                completion:(void (^)(PKPaymentAuthorizationStatus status))completion {
    self.progressBlock(@"Apple Pay Did Authorize Payment");
    BTAPIClient *client = [[BTAPIClient alloc] initWithAuthorization:self.authorizationString];
    BTApplePayClient *applePayClient = [[BTApplePayClient alloc] initWithAPIClient:client];
    [applePayClient tokenizeApplePayPayment:payment completion:^(BTApplePayCardNonce * _Nullable tokenizedApplePayPayment, NSError * _Nullable error) {
        if (error) {
            self.progressBlock(error.localizedDescription);
            completion(PKPaymentAuthorizationStatusFailure);
        } else {
            self.completionBlock(tokenizedApplePayPayment);
            completion(PKPaymentAuthorizationStatusSuccess);
        }
    }];
}

- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)paymentAuthorizationViewControllerWillAuthorizePayment:(__unused PKPaymentAuthorizationViewController *)controller {
    self.progressBlock(@"Apple Pay will Authorize Payment");
}

#pragma mark ThreeDSecure Verification

- (void)performThreeDSecureVerification {
    BTAPIClient* apiClient = [[BTAPIClient alloc] initWithAuthorization:self.authorizationString];

    BTPaymentFlowDriver *paymentFlowDriver = [[BTPaymentFlowDriver alloc] initWithAPIClient:apiClient];
    paymentFlowDriver.viewControllerPresentingDelegate = self;

    BTThreeDSecureRequest *request = [[BTThreeDSecureRequest alloc] init];
    request.amount = [NSDecimalNumber decimalNumberWithString:@"10"];
    request.nonce = self.selectedNonce.nonce;
    [paymentFlowDriver startPaymentFlow:request completion:^(BTPaymentFlowResult * _Nonnull result, NSError * _Nonnull error) {
         self.selectedNonce = nil;
         if (error) {
             if (error.code == BTPaymentFlowDriverErrorTypeCanceled) {
                 // User cancelled and nonce was consumed
                 [self updatePaymentMethod:self.selectedNonce];
                 [self fetchPaymentMethods];
                 return;
             }
             // Error and nonce was consumed
             [self updatePaymentMethod:self.selectedNonce];
             [self fetchPaymentMethods];
             self.progressBlock(error.localizedDescription);
             return;
         }
        BTThreeDSecureResult *threeDSecureResult = (BTThreeDSecureResult *)result;
        self.selectedNonce = threeDSecureResult.tokenizedCard;
        [self updatePaymentMethod:self.selectedNonce];
        self.completionBlock(self.selectedNonce);
        self.transactionBlock();
    }];
}

- (BOOL)nonceRequiresThreeDSecureVerification:(BTPaymentMethodNonce *)nonce {
    if ([nonce isKindOfClass:[BTCardNonce class]]) {
        BTCardNonce *cardNonce = (BTCardNonce *)nonce;
        return !cardNonce.threeDSecureInfo.wasVerified;
    }
    return false;
}

- (void)paymentDriver:(__unused id)driver requestsPresentationOfViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)paymentDriver:(__unused id)driver requestsDismissalOfViewController:(__unused UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
