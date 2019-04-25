#import "BTPaymentSelectionViewController.h"
#import "BTUIPaymentMethodCollectionViewCell.h"
#import "BTDropInController.h"
#import "BTDropInPaymentSeletionCell.h"
#import "BTAPIClient_Internal_Category.h"
#import "BTDropInOverrides.h"
#import "BTUIKBarButtonItem_Internal_Declaration.h"

#if __has_include("BraintreeUIKit.h")
#import "BraintreeUIKit.h"
#else
#import <BraintreeUIKit/BraintreeUIKit.h>
#endif

#if __has_include("BraintreeCard.h")
#import "BraintreeCard.h"
#else
#import <BraintreeCard/BraintreeCard.h>
#endif

#if __has_include("BraintreePayPal.h")
#import "BraintreePayPal.h"
#else
#import <BraintreePayPal/BraintreePayPal.h>
#endif

#if __has_include("BraintreeApplePay.h")
#define __BT_APPLE_PAY
#import "BraintreeApplePay.h"
#elif __has_include(<BraintreeApplePay/BraintreeApplePay.h>)
#define __BT_APPLE_PAY
#import <BraintreeApplePay/BraintreeApplePay.h>
#endif

#define SAVED_PAYMENT_METHODS_COLLECTION_SPACING 6
#define SAVED_PAYMENT_METHODS_COLLECTION_WIDTH 105
#define SAVED_PAYMENT_METHODS_COLLECTION_HEIGHT 165

@interface BTPaymentSelectionViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *scrollViewContentWrapper;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UIStackView *paymentOptionsLabelContainerStackView;
@property (nonatomic, strong) UIStackView *vaultedPaymentsLabelContainerStackView;
@property (nonatomic, strong) NSArray *paymentOptionsData;
@property (nonatomic, strong) UITableView *paymentOptionsTableView;
@property (nonatomic, strong) NSLayoutConstraint *savedPaymentMethodsCollectionViewConstraint;
@property (nonatomic, strong) UILabel *paymentOptionsHeader;
@property (nonatomic, strong) UILabel *vaultedPaymentsHeader;
@property (nonatomic, strong) UIButton *vaultedPaymentsEditButton;
@property (nonatomic, strong) UICollectionView *savedPaymentMethodsCollectionView;
@end

@implementation BTPaymentSelectionViewController

static BOOL _vaultedCardAppearAnalyticSent = NO;

- (id)init {
    self = [super init];
    if (self) {
        self.paymentMethodNonces = @[];
        self.paymentOptionsData = @[@(BTUIKPaymentOptionTypePayPal), @(BTUIKPaymentOptionTypeUnknown)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.navigationItem.leftBarButtonItem = [[BTUIKBarButtonItem alloc] initWithTitle:BTUIKLocalizedString(CANCEL_ACTION) style:UIBarButtonItemStylePlain target:nil action:nil];

    self.title = BTUIKLocalizedString(SELECT_PAYMENT_LABEL);
    
    self.view.translatesAutoresizingMaskIntoConstraints = false;
    self.view.backgroundColor = [UIColor clearColor];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView setAlwaysBounceVertical:NO];
    self.scrollView.scrollEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    self.scrollViewContentWrapper = [[UIView alloc] init];
    self.scrollViewContentWrapper.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:self.scrollViewContentWrapper];
    
    self.stackView = [self newStackView];
    [self.scrollViewContentWrapper addSubview:self.stackView];
    
    self.view.translatesAutoresizingMaskIntoConstraints = false;
    self.view.backgroundColor = [UIColor clearColor];
    
    NSDictionary *viewBindings = @{@"stackView": self.stackView,
                                   @"scrollView": self.scrollView,
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
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[stackView]|"
                                                                      options:0
                                                                      metrics:[BTUIKAppearance metrics]
                                                                        views:viewBindings]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(VERTICAL_SECTION_SPACE)-[stackView]-(VERTICAL_FORM_SPACE_TIGHT)-|"
                                                                      options:0
                                                                      metrics:[BTUIKAppearance metrics]
                                                                        views:viewBindings]];
    
    NSLayoutConstraint *heightConstraint;
    self.vaultedPaymentsHeader = [self sectionHeaderLabelWithString:BTUIKLocalizedString(RECENT_LABEL)];
    self.vaultedPaymentsHeader.translatesAutoresizingMaskIntoConstraints = NO;

    self.vaultedPaymentsLabelContainerStackView = [self newStackView];
    self.vaultedPaymentsLabelContainerStackView.axis  = UILayoutConstraintAxisHorizontal;
    self.vaultedPaymentsLabelContainerStackView.layoutMargins = UIEdgeInsetsMake(0, [BTUIKAppearance horizontalFormContentPadding], 0, [BTUIKAppearance horizontalFormContentPadding]);
    self.vaultedPaymentsLabelContainerStackView.layoutMarginsRelativeArrangement = true;

    [self.vaultedPaymentsLabelContainerStackView addArrangedSubview:self.vaultedPaymentsHeader];

    self.vaultedPaymentsEditButton = [UIButton new];
    self.vaultedPaymentsEditButton.hidden = YES;
    NSAttributedString *normalVaultedPaymentsEditButton = [[NSAttributedString alloc] initWithString:BTUIKLocalizedString(EDIT_ACTION) attributes:@{NSForegroundColorAttributeName:[BTUIKAppearance sharedInstance].tintColor, NSFontAttributeName:[UIFont fontWithName:[BTUIKAppearance sharedInstance].fontFamily size:[UIFont systemFontSize]]}];
    [self.vaultedPaymentsEditButton setAttributedTitle:normalVaultedPaymentsEditButton forState:UIControlStateNormal];
    NSAttributedString *highlightVaultedPaymentsEditButton = [[NSAttributedString alloc] initWithString:BTUIKLocalizedString(EDIT_ACTION) attributes:@{NSForegroundColorAttributeName:[BTUIKAppearance sharedInstance].highlightedTintColor, NSFontAttributeName:[UIFont fontWithName:[BTUIKAppearance sharedInstance].fontFamily size:[UIFont systemFontSize]]}];
    [self.vaultedPaymentsEditButton setAttributedTitle:highlightVaultedPaymentsEditButton forState:UIControlStateHighlighted];
    NSAttributedString *disabledVaultedPaymentsEditButton = [[NSAttributedString alloc] initWithString:BTUIKLocalizedString(EDIT_ACTION) attributes:@{NSForegroundColorAttributeName:[BTUIKAppearance sharedInstance].disabledColor, NSFontAttributeName:[UIFont fontWithName:[BTUIKAppearance sharedInstance].fontFamily size:[UIFont systemFontSize]]}];
    [self.vaultedPaymentsEditButton setAttributedTitle:disabledVaultedPaymentsEditButton forState:UIControlStateDisabled];
    [self.vaultedPaymentsEditButton sizeToFit];
    [self.vaultedPaymentsEditButton layoutIfNeeded];
    [self.vaultedPaymentsEditButton addTarget:self action:@selector(vaultedPaymentsEditButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.vaultedPaymentsLabelContainerStackView addArrangedSubview:self.vaultedPaymentsEditButton];

    [self.stackView addArrangedSubview:self.vaultedPaymentsLabelContainerStackView];
    _vaultedCardAppearAnalyticSent = NO;

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection: UICollectionViewScrollDirectionHorizontal];
    self.savedPaymentMethodsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.savedPaymentMethodsCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.savedPaymentMethodsCollectionView.delegate = self;
    self.savedPaymentMethodsCollectionView.dataSource = self;
    [self.savedPaymentMethodsCollectionView registerClass:[BTUIPaymentMethodCollectionViewCell class] forCellWithReuseIdentifier:@"BTUIPaymentMethodCollectionViewCellIdentifier"];
    self.savedPaymentMethodsCollectionView.backgroundColor = [UIColor clearColor];
    self.savedPaymentMethodsCollectionView.showsHorizontalScrollIndicator = NO;
    heightConstraint = [self.savedPaymentMethodsCollectionView.heightAnchor constraintEqualToConstant:SAVED_PAYMENT_METHODS_COLLECTION_HEIGHT + [BTUIKAppearance verticalFormSpace]];
    // Setting the prioprity is necessary to avoid autolayout errors when UIStackView rotates
    heightConstraint.priority = UILayoutPriorityDefaultHigh;
    heightConstraint.active = YES;
    [self.stackView addArrangedSubview:self.savedPaymentMethodsCollectionView];

    self.paymentOptionsHeader = [self sectionHeaderLabelWithString:BTUIKLocalizedString(OTHER_LABEL)];
    self.paymentOptionsHeader.translatesAutoresizingMaskIntoConstraints = NO;

    self.paymentOptionsLabelContainerStackView = [self newStackView];
    self.paymentOptionsLabelContainerStackView.layoutMargins = UIEdgeInsetsMake(0, [BTUIKAppearance horizontalFormContentPadding], 0, [BTUIKAppearance horizontalFormContentPadding]);

    self.paymentOptionsLabelContainerStackView.layoutMarginsRelativeArrangement = true;

    [self.paymentOptionsLabelContainerStackView addArrangedSubview:self.paymentOptionsHeader];
    [self addSpacerToStackView:self.paymentOptionsLabelContainerStackView size:[BTUIKAppearance verticalFormSpaceTight] beforeView:nil];
    [self.stackView addArrangedSubview:self.paymentOptionsLabelContainerStackView];
    
    self.paymentOptionsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.paymentOptionsTableView addObserver:self forKeyPath:@"contentSize" options:0 context:NULL];
    self.paymentOptionsTableView.backgroundColor = [UIColor clearColor];
    [self.paymentOptionsTableView registerClass:[BTDropInPaymentSeletionCell class] forCellReuseIdentifier:@"BTDropInPaymentSeletionCell"];
    self.paymentOptionsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.paymentOptionsTableView.delegate = self;
    self.paymentOptionsTableView.dataSource = self;
    self.paymentOptionsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.paymentOptionsTableView setAlwaysBounceVertical:NO];

    [self.stackView addArrangedSubview:self.paymentOptionsTableView];
    
    [self loadConfiguration];
}

- (void)loadConfiguration {
    [self showLoadingScreen:YES];
    self.stackView.hidden = YES;
    [super loadConfiguration];
}

- (void)dealloc {
    [self.paymentOptionsTableView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary <NSString *, id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"]) {
        [self.paymentOptionsTableView removeConstraints:self.paymentOptionsTableView.constraints];
        NSLayoutConstraint *heightConstraint = [self.paymentOptionsTableView.heightAnchor constraintEqualToConstant:self.paymentOptionsTableView.contentSize.height];
        // Setting the prioprity is necessary to avoid autolayout errors when UIStackView rotates
        heightConstraint.priority = UILayoutPriorityDefaultHigh;
        heightConstraint.active = YES;
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)configurationLoaded:(__unused BTConfiguration *)configuration error:(NSError *)error {
    NSMutableArray *activePaymentOptions = [@[] mutableCopy];
    if (!error) {
        [self fetchPaymentMethodsOnCompletion:^{
            if ([[BTTokenizationService sharedService] isTypeAvailable:@"PayPal"] && [self.configuration.json[@"paypalEnabled"] isTrue] && !self.dropInRequest.paypalDisabled) {
                [activePaymentOptions addObject:@(BTUIKPaymentOptionTypePayPal)];
            }

            BTJSON *venmoAccessToken = self.configuration.json[@"payWithVenmo"][@"accessToken"];
            if ([[BTTokenizationService sharedService] isTypeAvailable:@"Venmo"] && venmoAccessToken.isString && !self.dropInRequest.venmoDisabled) {
                NSURLComponents *components = [NSURLComponents componentsWithString:@"com.venmo.touch.v2://x-callback-url/vzero/auth"];
                BOOL isVenmoAppInstalled = [[UIApplication sharedApplication] canOpenURL:components.URL];
                if (isVenmoAppInstalled || [BTDropInOverrides displayVenmoOption]) {
                    [activePaymentOptions addObject:@(BTUIKPaymentOptionTypeVenmo)];
                }
            }

            NSArray *supportedCardTypes = [self.configuration.json[@"creditCards"][@"supportedCardTypes"] asArray];
            for (NSString *supportedCardType in supportedCardTypes) {
                BTUIKPaymentOptionType paymentOptionType = [BTUIKViewUtil paymentOptionTypeForPaymentInfoType:supportedCardType];
                if ([BTUIKViewUtil isPaymentOptionTypeACreditCard:paymentOptionType] && !self.dropInRequest.cardDisabled) {
                    // Add credit cards if they are supported
                    [activePaymentOptions addObject:@(BTUIKPaymentOptionTypeUnknown)];
                    break;
                }
            }

#ifdef __BT_APPLE_PAY
            BTJSON *applePayConfiguration = self.configuration.json[@"applePay"];
            if ([applePayConfiguration[@"status"] isString] && ![[applePayConfiguration[@"status"] asString] isEqualToString:@"off"] && !self.dropInRequest.applePayDisabled && self.configuration.canMakeApplePayPayments) {
                // Short-circuits if BraintreeApplePay is not available at runtime
                if (__BT_AVAILABLE(@"BTApplePayClient")) {
                    [activePaymentOptions addObject:@(BTUIKPaymentOptionTypeApplePay)];
                }
            }
#endif

            self.paymentOptionsData = [activePaymentOptions copy];
            [self.savedPaymentMethodsCollectionView reloadData];
            [self.paymentOptionsTableView reloadData];
            if (self.paymentMethodNonces.count == 0) {
                self.savedPaymentMethodsCollectionView.hidden = YES;
                self.paymentOptionsLabelContainerStackView.hidden = YES;
                self.vaultedPaymentsLabelContainerStackView.hidden = YES;
            } else {
                self.savedPaymentMethodsCollectionView.hidden = NO;
                self.paymentOptionsLabelContainerStackView.hidden = NO;
                self.vaultedPaymentsLabelContainerStackView.hidden = NO;
                [self.savedPaymentMethodsCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:([BTUIKViewUtil isLanguageLayoutDirectionRightToLeft] ? UICollectionViewScrollPositionLeft : UICollectionViewScrollPositionRight) animated:NO];

                [self sendVaultedCardAppearAnalytic];
            }
            [self showLoadingScreen:NO];
            self.stackView.hidden = NO;
            [self.view layoutIfNeeded];
            if (self.delegate) {
                [self.delegate sheetHeightDidChange:self];
            }
        }];
    }
}

#pragma mark - Helpers

- (void)fetchPaymentMethodsOnCompletion:(void(^)(void))completionBlock {
    if (!self.apiClient.clientToken) {
        self.paymentMethodNonces = @[];
        if (completionBlock) {
            completionBlock();
        }
        return;
    }
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [self.apiClient fetchPaymentMethodNonces:YES completion:^(NSArray<BTPaymentMethodNonce *> *paymentMethodNonces, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        if (error) {
            // no action
        } else {
            self.vaultedPaymentsEditButton.hidden = !self.dropInRequest.vaultManager;
            self.paymentMethodNonces = [paymentMethodNonces copy];
            if (completionBlock) {
                completionBlock();
            }
        }
    }];
}

- (BOOL)prefersStatusBarHidden {
    if (self.presentingViewController != nil) {
        return [self.presentingViewController prefersStatusBarHidden];
    }
    return NO;
}

- (UIStackView *)newStackView {
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    stackView.axis  = UILayoutConstraintAxisVertical;
    stackView.distribution  = UIStackViewDistributionFill;
    stackView.alignment = UIStackViewAlignmentFill;
    stackView.spacing = 0;
    return stackView;
}

- (UILabel *)sectionHeaderLabelWithString:(NSString*)string {
    UILabel *sectionLabel = [UILabel new];
    sectionLabel.text = [string uppercaseString];
    sectionLabel.textAlignment = NSTextAlignmentNatural;
    [BTUIKAppearance styleSystemLabelSecondary:sectionLabel];
    return sectionLabel;
}

- (UIView *)addSpacerToStackView:(UIStackView *)stackView size:(CGFloat)spacerSize beforeView:(UIView * _Nullable )view {
    NSInteger indexOfView = view != nil ? [stackView.arrangedSubviews indexOfObject:view] : NSNotFound;
    UIView* spacer = [[UIView alloc] init];
    spacer.translatesAutoresizingMaskIntoConstraints = NO;
    if (indexOfView != NSNotFound) {
        [stackView insertArrangedSubview:spacer atIndex:indexOfView];
    } else {
        [stackView insertArrangedSubview:spacer atIndex:stackView.arrangedSubviews.count];
    }
    NSLayoutConstraint* heightConstraint = [spacer.heightAnchor constraintEqualToConstant:spacerSize];
    heightConstraint.priority = UILayoutPriorityDefaultHigh;
    heightConstraint.active = true;
    return spacer;
}

- (float)sheetHeight {
    return self.paymentMethodNonces.count == 0 ? 280 : 470;
}

- (void)vaultedPaymentsEditButtonPressed {
    if ([self.delegate respondsToSelector:@selector(editPaymentMethods:)]){
        [self.delegate performSelector:@selector(editPaymentMethods:) withObject:self];
    }
}

- (void)sendVaultedCardAppearAnalytic {
    for (BTPaymentMethodNonce *nonce in self.paymentMethodNonces) {
        if ([nonce isKindOfClass: [BTCardNonce class]] && !_vaultedCardAppearAnalyticSent){
            [self.apiClient sendAnalyticsEvent:@"ios.dropin2.vaulted-card.appear"];
            _vaultedCardAppearAnalyticSent = YES;
            break;
        }
    }
}

#pragma mark - Protocol conformance
#pragma mark UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(__unused UICollectionView *)savedPaymentMethodsCollectionView {
    return 1;
}

- (NSInteger)collectionView:(__unused UICollectionView *)savedPaymentMethodsCollectionView numberOfItemsInSection:(__unused NSInteger)section {
    return [self.paymentMethodNonces count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)savedPaymentMethodsCollectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BTUIPaymentMethodCollectionViewCell* cell = [savedPaymentMethodsCollectionView dequeueReusableCellWithReuseIdentifier:@"BTUIPaymentMethodCollectionViewCellIdentifier" forIndexPath:indexPath];
    BTPaymentMethodNonce *paymentInfo = self.paymentMethodNonces[indexPath.row];
    cell.paymentMethodNonce = paymentInfo;
    NSString *typeString = paymentInfo.type;
    NSMutableAttributedString *typeWithDescription = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", paymentInfo.localizedDescription ?: @""]];
    if ([paymentInfo isKindOfClass:[BTCardNonce class]]) {
        typeWithDescription = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"••• ••%@", ((BTCardNonce*)paymentInfo).lastTwo ?: @""]];
    }
    cell.highlighted = NO;
    cell.descriptionLabel.attributedText = typeWithDescription;
    cell.titleLabel.text = [BTUIKViewUtil nameForPaymentMethodType:[BTUIKViewUtil paymentOptionTypeForPaymentInfoType:typeString]];
    cell.paymentOptionCardView.paymentOptionType = [BTUIKViewUtil paymentOptionTypeForPaymentInfoType:typeString];
    return cell;
}

- (CGSize)collectionView:(__unused UICollectionView *)savedPaymentMethodsCollectionView layout:(__unused UICollectionViewLayout *)savedPaymentMethodsCollectionViewLayout sizeForItemAtIndexPath:(__unused NSIndexPath *)indexPath {
    return CGSizeMake(SAVED_PAYMENT_METHODS_COLLECTION_WIDTH, SAVED_PAYMENT_METHODS_COLLECTION_HEIGHT);
}

#pragma mark collection view cell paddings

- (UIEdgeInsets)collectionView:(__unused UICollectionView*)savedPaymentMethodsCollectionView layout:(__unused UICollectionViewLayout *)savedPaymentMethodsCollectionViewLayout insetForSectionAtIndex:(__unused NSInteger)section {
    return UIEdgeInsetsMake(0, [BTUIKAppearance horizontalFormContentPadding], 0, [BTUIKAppearance horizontalFormContentPadding]);
}

- (CGFloat)collectionView:(__unused UICollectionView *)savedPaymentMethodsCollectionView layout:(__unused UICollectionViewLayout*)savedPaymentMethodsCollectionViewLayout minimumInteritemSpacingForSectionAtIndex:(__unused NSInteger)section {
    return SAVED_PAYMENT_METHODS_COLLECTION_SPACING;
}

- (CGFloat)collectionView:(__unused UICollectionView *)savedPaymentMethodsCollectionView layout:(__unused UICollectionViewLayout*)savedPaymentMethodsCollectionViewLayout minimumLineSpacingForSectionAtIndex:(__unused NSInteger)section {
    return SAVED_PAYMENT_METHODS_COLLECTION_SPACING;
}

- (void)collectionView:(__unused UICollectionView *)savedPaymentMethodsCollectionView didSelectItemAtIndexPath:(__unused NSIndexPath *)indexPath {
    BTUIPaymentMethodCollectionViewCell *cell = (BTUIPaymentMethodCollectionViewCell*)[savedPaymentMethodsCollectionView cellForItemAtIndexPath:indexPath];
    if (self.delegate) {
        [self.delegate selectionCompletedWithPaymentMethodType:[BTUIKViewUtil paymentOptionTypeForPaymentInfoType:cell.paymentMethodNonce.type] nonce:cell.paymentMethodNonce error:nil];

        if ([cell.paymentMethodNonce isKindOfClass: [BTCardNonce class]]){
            [self.apiClient sendAnalyticsEvent:@"ios.dropin2.vaulted-card.select"];
        }
    }
}

#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(__unused UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"BTDropInPaymentSeletionCell";

    BTDropInPaymentSeletionCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];

    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    BTUIKPaymentOptionType option = ((NSNumber*)self.paymentOptionsData[indexPath.row]).intValue;

    cell.detailLabel.text = @"";
    cell.label.text = [BTUIKViewUtil nameForPaymentMethodType:option];
    if (option == BTUIKPaymentOptionTypeUnknown) {
        cell.label.text = BTUIKLocalizedString(CREDIT_OR_DEBIT_CARD_LABEL);
    }
    cell.iconView.paymentOptionType = option;
    cell.type = option;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BTDropInPaymentSeletionCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.type == BTUIKPaymentOptionTypeUnknown) {
        if ([self.delegate respondsToSelector:@selector(showCardForm:)]){
            [self.delegate performSelector:@selector(showCardForm:) withObject:self];
        }
    } else if (cell.type == BTUIKPaymentOptionTypePayPal) {
        BTPayPalDriver *driver = [[BTPayPalDriver alloc] initWithAPIClient:self.apiClient];
        driver.viewControllerPresentingDelegate = self.delegate;
        driver.appSwitchDelegate = self.delegate;

        BTPayPalRequest *payPalRequest = self.dropInRequest.payPalRequest;
        if (payPalRequest == nil) {
            payPalRequest = [[BTPayPalRequest alloc] init];
        }

        // One time payment if an amount is present
        if (payPalRequest.amount) {
            [driver requestOneTimePayment:payPalRequest completion:^(BTPayPalAccountNonce * _Nullable payPalAccount, NSError * _Nullable error) {
                if (self.delegate && (payPalAccount != nil || error != nil)) {
                    [self.delegate selectionCompletedWithPaymentMethodType:BTUIKPaymentOptionTypePayPal nonce:payPalAccount error:error];
                }
            }];
        } else {
            [driver requestBillingAgreement:payPalRequest completion:^(BTPayPalAccountNonce * _Nullable payPalAccount, NSError * _Nullable error) {
                if (self.delegate && (payPalAccount != nil || error != nil)) {
                    [self.delegate selectionCompletedWithPaymentMethodType:BTUIKPaymentOptionTypePayPal nonce:payPalAccount error:error];
                }
            }];
        }
    } else if (cell.type == BTUIKPaymentOptionTypeVenmo) {
        NSMutableDictionary *options = [NSMutableDictionary dictionary];
        if (self.delegate != nil) {
            options[BTTokenizationServiceViewPresentingDelegateOption] = self.delegate;
        }
        [[BTTokenizationService sharedService] tokenizeType:@"Venmo" options:options withAPIClient:self.apiClient completion:^(BTPaymentMethodNonce * _Nullable paymentMethodNonce, NSError * _Nullable error) {
            if (self.delegate && (paymentMethodNonce != nil || error != nil)) {
                [self.delegate selectionCompletedWithPaymentMethodType:BTUIKPaymentOptionTypeVenmo nonce:paymentMethodNonce error:error];
            }
        }];
    } else if(cell.type == BTUIKPaymentOptionTypeApplePay) {
        if (self.delegate) {
            [self.delegate selectionCompletedWithPaymentMethodType:BTUIKPaymentOptionTypeApplePay nonce:nil error:nil];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(__unused UITableView *)tableView heightForRowAtIndexPath:(__unused NSIndexPath *)indexPath {
    return 44.0;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(__unused UITableView *)tableView numberOfRowsInSection:(__unused NSInteger)section {
    return [self.paymentOptionsData count];
}

@end
