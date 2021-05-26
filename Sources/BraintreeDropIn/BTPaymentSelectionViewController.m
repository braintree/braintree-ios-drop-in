#import <BraintreeDropIn/BTDropInController.h>
#import "BTPaymentSelectionViewController.h"
#import "BTUIPaymentMethodCollectionViewCell.h"
#import "BTDropInPaymentSelectionCell.h"
#import "BTAPIClient_Internal_Category.h"
#import "BTUIKBarButtonItem_Internal_Declaration.h"
#import "BTVaultedPaymentMethodsTableViewCell.h"
#import "BTPaymentSelectionHeaderView.h"
#import "BTUIKAppearance.h"
#import "BTConfiguration+DropIn.h"
#import "BTPaymentMethodNonce+DropIn.h"

#if __has_include(<Braintree/BraintreeCore.h>) // CocoaPods
#import <Braintree/BraintreeCard.h>
#import <Braintree/BraintreePayPal.h>
#import <Braintree/BraintreeVenmo.h>
#import <Braintree/BraintreeApplePay.h>
#else
#import <BraintreeCard/BraintreeCard.h>
#import <BraintreePayPal/BraintreePayPal.h>
#import <BraintreeVenmo/BraintreeVenmo.h>
#import <BraintreeApplePay/BraintreeApplePay.h>
#endif

#define SAVED_PAYMENT_METHODS_COLLECTION_SPACING 6
#define SAVED_PAYMENT_METHODS_COLLECTION_WIDTH 105
#define SAVED_PAYMENT_METHODS_COLLECTION_HEIGHT 165

@interface BTPaymentSelectionViewController () <BTPaymentSelectionHeaderViewDelegate, BTVaultedPaymentMethodsTableViewCellDelegate>
@property (nonatomic, strong) NSArray *paymentOptionsData;
@property (nonatomic, readonly) BOOL hasVaultedPaymentMethods;
@property (nonatomic, strong) UITableView *paymentOptionsTableView;
@property (nonatomic, strong) id application;
@end

@implementation BTPaymentSelectionViewController

static BOOL _vaultedCardAppearAnalyticSent = NO;

// Used for unit testing
- (id)init {
    self = [super init];
    if (self) {
        self.paymentMethodNonces = @[];
        self.paymentOptionsData = @[@(BTDropInPaymentMethodTypePayPal), @(BTDropInPaymentMethodTypeUnknown)];
    }
    return self;
}

- (instancetype)initWithAPIClient:(BTAPIClient *)apiClient request:(BTDropInRequest *)request {
    self = [super initWithAPIClient:apiClient request:request];
    if (self) {
        _venmoDriver = [[BTVenmoDriver alloc] initWithAPIClient: self.apiClient];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [[BTUIKBarButtonItem alloc] initWithTitle:BTDropInLocalizedString(CANCEL_ACTION)
                                                                                style:UIBarButtonItemStylePlain
                                                                               target:self
                                                                               action:@selector(cancelButtonPressed:)];

    UILabel *titleLabel = [BTUIKAppearance styledNavigationTitleLabel];
    titleLabel.text = BTDropInLocalizedString(SELECT_PAYMENT_LABEL);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 2;
    [titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;

    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault]; // make nav bar clear
    self.view.backgroundColor = UIColor.clearColor;

    _vaultedCardAppearAnalyticSent = NO;

    self.paymentOptionsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.paymentOptionsTableView.backgroundColor = UIColor.clearColor;
    [self.paymentOptionsTableView addObserver:self forKeyPath:@"contentSize" options:0 context:NULL];
    [self.paymentOptionsTableView registerClass:BTDropInPaymentSelectionCell.class forCellReuseIdentifier:@"BTDropInPaymentSelectionCell"];
    [self.paymentOptionsTableView registerClass:BTVaultedPaymentMethodsTableViewCell.class forCellReuseIdentifier:@"BTVaultedPaymentMethodsTableViewCell"];
    [self.paymentOptionsTableView registerClass:BTPaymentSelectionHeaderView.class forHeaderFooterViewReuseIdentifier:@"BTPaymentSelectionHeaderView"];
    self.paymentOptionsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.paymentOptionsTableView.delegate = self;
    self.paymentOptionsTableView.dataSource = self;
    self.paymentOptionsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.paymentOptionsTableView setAlwaysBounceVertical:NO];
    [self.view addSubview:self.paymentOptionsTableView];

    [NSLayoutConstraint activateConstraints:@[
        [self.paymentOptionsTableView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor],
        [self.paymentOptionsTableView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.paymentOptionsTableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.paymentOptionsTableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
}

- (void)dealloc {
    [self.paymentOptionsTableView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary <NSString *, id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"]) {
        [self.delegate sheetHeightDidChange:self];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)loadConfiguration {
    [self showLoadingScreen:YES];
    [super loadConfiguration];
}

- (void)showLoadingScreen:(BOOL)show {
    [super showLoadingScreen:show];
    self.paymentOptionsTableView.hidden = show;
}

- (void)cancelButtonPressed:(UIButton *)sender {
    [self.delegate cancelButtonPressedOnPaymentSelectionViewController:self];
}

- (void)configurationLoaded:(__unused BTConfiguration *)configuration error:(NSError *)error {
    NSMutableArray *activePaymentOptions = [@[] mutableCopy];
    if (!error) {
        [self fetchPaymentMethodsOnCompletion:^{
            if (self.configuration.isPayPalEnabled && !self.dropInRequest.paypalDisabled) {
                [activePaymentOptions addObject:@(BTDropInPaymentMethodTypePayPal)];
            }

            if (!self.dropInRequest.venmoDisabled && self.venmoDriver.isiOSAppAvailableForAppSwitch && self.configuration.isVenmoEnabled) {
                [activePaymentOptions addObject:@(BTDropInPaymentMethodTypeVenmo)];
            }

            for (NSString *supportedCardType in self.configuration.supportedCardTypes) {
                BTDropInPaymentMethodType paymentMethodType = [BTUIKViewUtil paymentMethodTypeForPaymentInfoType:supportedCardType];
                if ([BTUIKViewUtil isPaymentMethodTypeACreditCard:paymentMethodType] && !self.dropInRequest.cardDisabled) {
                    // Add credit cards if they are supported
                    [activePaymentOptions addObject:@(BTDropInPaymentMethodTypeUnknown)];
                    break;
                }
            }

            if (self.configuration.isApplePayEnabled && !self.dropInRequest.applePayDisabled && [PKPaymentAuthorizationController canMakePayments]) {
                [activePaymentOptions addObject:@(BTDropInPaymentMethodTypeApplePay)];
            }

            self.paymentOptionsData = [activePaymentOptions copy];
            [self.paymentOptionsTableView reloadData];
            if (self.hasVaultedPaymentMethods) {
                [self sendVaultedCardAppearAnalytic];
            }
            [self showLoadingScreen:NO];
        }];
    }
}

#pragma mark - Accessors

- (id)application {
    if (!_application) {
        _application = [UIApplication sharedApplication];
    }
    return _application;
}

- (BOOL)hasVaultedPaymentMethods {
    return self.paymentMethodNonces.count > 0;
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
    
    [self.application setNetworkActivityIndicatorVisible:YES];
    
    [self.apiClient fetchPaymentMethodNonces:YES completion:^(NSArray<BTPaymentMethodNonce *> *paymentMethodNonces, NSError *error) {
        [self.application setNetworkActivityIndicatorVisible:NO];
        
        if (error) {
            // no action
        } else {
            NSMutableArray* vaultedNoncesForDropIn = [NSMutableArray new];
            for (BTPaymentMethodNonce *nonce in paymentMethodNonces) {
                if ([nonce shouldDisplayVaultedNonceForRequest:self.dropInRequest config:self.configuration]) {
                    [vaultedNoncesForDropIn addObject:nonce];
                }
            }

            self.paymentMethodNonces = [vaultedNoncesForDropIn copy];

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

- (float)sheetHeight {
    return MAX(self.paymentOptionsTableView.contentSize.height, 150) + 50;
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

#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(__unused UITableView *)tableView {
    return self.hasVaultedPaymentMethods ? 2 : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && self.hasVaultedPaymentMethods) {
        static NSString *identifier = @"BTVaultedPaymentMethodsTableViewCell";

        BTVaultedPaymentMethodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.paymentMethodNonces = self.paymentMethodNonces;
        cell.delegate = self;
        return cell;
    } else {
        static NSString *simpleTableIdentifier = @"BTDropInPaymentSelectionCell";

        BTDropInPaymentSelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];

        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        BTDropInPaymentMethodType option = ((NSNumber*)self.paymentOptionsData[indexPath.row]).intValue;

        cell.detailLabel.text = @"";
        cell.label.text = [BTUIKViewUtil nameForPaymentMethodType:option];
        if (option == BTDropInPaymentMethodTypeUnknown) {
            cell.label.text = BTDropInLocalizedString(CREDIT_OR_DEBIT_CARD_LABEL);
        }
        cell.iconView.paymentMethodType = option;
        cell.type = option;

        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:BTDropInPaymentSelectionCell.class]) {
        return;
    }

    BTDropInPaymentSelectionCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.type == BTDropInPaymentMethodTypeUnknown) {
        if ([self.delegate respondsToSelector:@selector(showCardForm:)]){
            [self.delegate performSelector:@selector(showCardForm:) withObject:self];
        }
    } else if (cell.type == BTDropInPaymentMethodTypePayPal) {
        BTPayPalDriver *driver = [[BTPayPalDriver alloc] initWithAPIClient:self.apiClient];

        BTPayPalRequest *payPalRequest = self.dropInRequest.payPalRequest;
        if (payPalRequest == nil) {
            payPalRequest = [[BTPayPalVaultRequest alloc] init];
        }

        [self showLoadingScreen:YES];
        [driver tokenizePayPalAccountWithPayPalRequest:payPalRequest completion:^(BTPayPalAccountNonce * _Nullable tokenizedPayPalAccount, NSError * _Nullable error) {
            [self showLoadingScreen:NO];
            BOOL shouldReturnError = (error != nil && error.code != BTPayPalDriverErrorTypeCanceled);
            if (self.delegate && (tokenizedPayPalAccount != nil || shouldReturnError)) {
                [self.delegate selectionCompletedWithPaymentMethodType:BTDropInPaymentMethodTypePayPal nonce:tokenizedPayPalAccount error:error];
            }
        }];
    } else if (cell.type == BTDropInPaymentMethodTypeVenmo) {
        BTVenmoRequest *venmoRequest = self.dropInRequest.venmoRequest;
        if (venmoRequest == nil) {
            venmoRequest = [[BTVenmoRequest alloc] init];
            venmoRequest.vault = true;
        }

        [self showLoadingScreen:YES];
        [self.venmoDriver tokenizeVenmoAccountWithVenmoRequest:venmoRequest completion:^(BTVenmoAccountNonce * _Nullable venmoAccountNonce, NSError * _Nullable error) {
            [self showLoadingScreen:NO];
            if (self.delegate && (venmoAccountNonce != nil || error != nil)) {
                [self.delegate selectionCompletedWithPaymentMethodType:BTDropInPaymentMethodTypeVenmo nonce:venmoAccountNonce error:error];
            }
        }];
    } else if (cell.type == BTDropInPaymentMethodTypeApplePay) {
        if (self.delegate) {
            [self.delegate selectionCompletedWithPaymentMethodType:BTDropInPaymentMethodTypeApplePay nonce:nil error:nil];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(__unused UITableView *)tableView heightForRowAtIndexPath:(__unused NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(__unused UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 && self.hasVaultedPaymentMethods) {
        return 1;
    } else {
        return self.paymentOptionsData.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.hasVaultedPaymentMethods) {
        return 44;
    } else {
        return CGFLOAT_MIN; // hide the header
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (!self.hasVaultedPaymentMethods) {
        return nil;
    }

    BTPaymentSelectionHeaderView *headerView = (BTPaymentSelectionHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BTPaymentSelectionHeaderView"];
    if (section == 0) {
        headerView.title = BTDropInLocalizedString(RECENT_LABEL);
        if (self.dropInRequest.vaultManager) {
            headerView.buttonText = BTDropInLocalizedString(EDIT_ACTION);
            headerView.delegate = self;
        }
    } else {
        headerView.title = BTDropInLocalizedString(OTHER_LABEL);
    }
    return headerView;
}

#pragma mark BTPaymentMethodSelectionHeaderViewDelegate

- (void)didTapButtonOnHeaderView:(BTPaymentSelectionHeaderView *)headerView {
    if ([self.delegate respondsToSelector:@selector(editPaymentMethods:)]){
        [self.delegate performSelector:@selector(editPaymentMethods:) withObject:self];
    }
}

#pragma mark BTVaultedPaymentMethodsTableViewCellDelegate

- (void)vaultedPaymentMethodsTableViewCell:(BTVaultedPaymentMethodsTableViewCell *)cell didSelectNonce:(BTPaymentMethodNonce *)nonce {
    if (self.delegate) {
        [self.delegate selectionCompletedWithPaymentMethodType:[BTUIKViewUtil paymentMethodTypeForPaymentInfoType:nonce.type]
                                                         nonce:nonce
                                                         error:nil];

        if ([nonce isKindOfClass:BTCardNonce.class]) {
            [self.apiClient sendAnalyticsEvent:@"ios.dropin2.vaulted-card.select"];
        }
    }
}

@end
