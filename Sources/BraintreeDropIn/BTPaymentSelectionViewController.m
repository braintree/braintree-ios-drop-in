#import <BraintreeDropIn/BTDropInController.h>
#import "BTPaymentSelectionViewController.h"
#import "BTUIPaymentMethodCollectionViewCell.h"
#import "BTDropInPaymentSeletionCell.h"
#import "BTAPIClient_Internal_Category.h"
#import "BTUIKBarButtonItem_Internal_Declaration.h"
#import "BTPaymentMethodNonce+DropIn.h"
#import "BTVaultedPaymentMethodsTableViewCell.h"

#ifdef COCOAPODS
#import <BraintreeDropIn/BraintreeUIKit.h>
#import <Braintree/BraintreeCard.h>
#import <Braintree/BraintreePayPal.h>
#import <Braintree/BraintreeVenmo.h>
#import <Braintree/BraintreeApplePay.h>
#else
#import <BraintreeUIKit/BraintreeUIKit.h>
#import <BraintreeCard/BraintreeCard.h>
#import <BraintreePayPal/BraintreePayPal.h>
#import <BraintreeVenmo/BraintreeVenmo.h>
#import <BraintreeApplePay/BraintreeApplePay.h>
#endif

#define SAVED_PAYMENT_METHODS_COLLECTION_SPACING 6
#define SAVED_PAYMENT_METHODS_COLLECTION_WIDTH 105
#define SAVED_PAYMENT_METHODS_COLLECTION_HEIGHT 165

@interface BTPaymentSelectionViewController ()
@property (nonatomic, strong) NSArray *paymentOptionsData;
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
        self.paymentOptionsData = @[@(BTUIKPaymentOptionTypePayPal), @(BTUIKPaymentOptionTypeUnknown)];
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

    self.navigationItem.leftBarButtonItem = [[BTUIKBarButtonItem alloc] initWithTitle:BTUIKLocalizedString(CANCEL_ACTION)
                                                                                style:UIBarButtonItemStylePlain
                                                                               target:nil
                                                                               action:nil];

    self.title = BTUIKLocalizedString(SELECT_PAYMENT_LABEL);
    self.view.translatesAutoresizingMaskIntoConstraints = false;
    self.view.backgroundColor = UIColor.clearColor;

    _vaultedCardAppearAnalyticSent = NO;

    self.paymentOptionsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.paymentOptionsTableView addObserver:self forKeyPath:@"contentSize" options:0 context:NULL];
    self.paymentOptionsTableView.backgroundColor = UIColor.clearColor;
    [self.paymentOptionsTableView registerClass:[BTDropInPaymentSeletionCell class] forCellReuseIdentifier:@"BTDropInPaymentSeletionCell"];
    [self.paymentOptionsTableView registerClass:[BTVaultedPaymentMethodsTableViewCell class] forCellReuseIdentifier:@"BTVaultedPaymentMethodsTableViewCell"];
    self.paymentOptionsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.paymentOptionsTableView.delegate = self;
    self.paymentOptionsTableView.dataSource = self;
    self.paymentOptionsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.paymentOptionsTableView setAlwaysBounceVertical:NO];
    [self.view addSubview:self.paymentOptionsTableView];

    [self.paymentOptionsTableView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.paymentOptionsTableView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor].active = YES;
    [self.paymentOptionsTableView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.paymentOptionsTableView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    [self loadConfiguration];
}

- (void)loadConfiguration {
    [self showLoadingScreen:YES];
    [super loadConfiguration];
}

- (void)showLoadingScreen:(BOOL)show {
    [super showLoadingScreen:show];
}

- (void)dealloc {
    [self.paymentOptionsTableView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary <NSString *, id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"]) {
        [self.paymentOptionsTableView removeConstraints:self.paymentOptionsTableView.constraints];
        NSLayoutConstraint *heightConstraint = [self.paymentOptionsTableView.heightAnchor constraintEqualToConstant:self.paymentOptionsTableView.contentSize.height];
        // Setting the priority is necessary to avoid autolayout errors when UIStackView rotates
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
            if (self.configuration.isPayPalEnabled && !self.dropInRequest.paypalDisabled) {
                [activePaymentOptions addObject:@(BTUIKPaymentOptionTypePayPal)];
            }

            if (!self.dropInRequest.venmoDisabled && self.venmoDriver.isiOSAppAvailableForAppSwitch && self.configuration.isVenmoEnabled) {
                [activePaymentOptions addObject:@(BTUIKPaymentOptionTypeVenmo)];
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

            if (self.configuration.isApplePayEnabled && !self.dropInRequest.applePayDisabled && self.configuration.canMakeApplePayPayments) {
                [activePaymentOptions addObject:@(BTUIKPaymentOptionTypeApplePay)];
            }

            self.paymentOptionsData = [activePaymentOptions copy];
            [self.paymentOptionsTableView reloadData];
            if (self.paymentMethodNonces.count > 0) {
                // TODO: - is this necessary?
//                [self.savedPaymentMethodsCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:([BTUIKViewUtil isLanguageLayoutDirectionRightToLeft] ? UICollectionViewScrollPositionLeft : UICollectionViewScrollPositionRight) animated:NO];

                [self sendVaultedCardAppearAnalytic];
            }
            [self showLoadingScreen:NO];
            [self.view layoutIfNeeded];
            if (self.delegate) {
                [self.delegate sheetHeightDidChange:self];
            }
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

- (UILabel *)sectionHeaderLabelWithString:(NSString*)string {
    UILabel *sectionLabel = [UILabel new];
    sectionLabel.text = [string uppercaseString];
    sectionLabel.textAlignment = NSTextAlignmentNatural;
    [BTUIKAppearance styleSystemLabelSecondary:sectionLabel];
    return sectionLabel;
}

- (float)sheetHeight {
    // TODO: - adjust this or get rid of it entirely? Can the view set its own height?
    return self.paymentOptionsTableView.contentSize.height + 150;
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
    return self.paymentMethodNonces.count > 0 ? 2 : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && self.paymentMethodNonces.count > 0) {
        static NSString *identifier = @"BTVaultedPaymentMethodsTableViewCell";

        BTVaultedPaymentMethodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.paymentMethodNonces = self.paymentMethodNonces;
        return cell;
    } else {
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
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:BTDropInPaymentSeletionCell.class]) {
        return;
    }

    BTDropInPaymentSeletionCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.type == BTUIKPaymentOptionTypeUnknown) {
        if ([self.delegate respondsToSelector:@selector(showCardForm:)]){
            [self.delegate performSelector:@selector(showCardForm:) withObject:self];
        }
    } else if (cell.type == BTUIKPaymentOptionTypePayPal) {
        BTPayPalDriver *driver = [[BTPayPalDriver alloc] initWithAPIClient:self.apiClient];

        BTPayPalRequest *payPalRequest = self.dropInRequest.payPalRequest;
        if (payPalRequest == nil) {
            payPalRequest = [[BTPayPalVaultRequest alloc] init];
        }

        [self showLoadingScreen:YES];
        [driver tokenizePayPalAccountWithPayPalRequest:payPalRequest completion:^(BTPayPalAccountNonce * _Nullable tokenizedPayPalAccount, NSError * _Nullable error) {
            [self showLoadingScreen:NO];
            if (self.delegate && (tokenizedPayPalAccount != nil || error != nil)) {
                [self.delegate selectionCompletedWithPaymentMethodType:BTUIKPaymentOptionTypePayPal nonce:tokenizedPayPalAccount error:error];
            }
        }];
    } else if (cell.type == BTUIKPaymentOptionTypeVenmo) {
        [self showLoadingScreen:YES];
        BTVenmoRequest *request = [[BTVenmoRequest alloc] init];
        request.vault = self.dropInRequest.vaultVenmo;
        [self.venmoDriver tokenizeVenmoAccountWithVenmoRequest:request completion:^(BTVenmoAccountNonce * _Nullable venmoAccountNonce, NSError * _Nullable error) {
            [self showLoadingScreen:NO];
            if (self.delegate && (venmoAccountNonce != nil || error != nil)) {
                [self.delegate selectionCompletedWithPaymentMethodType:BTUIKPaymentOptionTypeVenmo nonce:venmoAccountNonce error:error];
            }
        }];
    } else if (cell.type == BTUIKPaymentOptionTypeApplePay) {
        if (self.delegate) {
            [self.delegate selectionCompletedWithPaymentMethodType:BTUIKPaymentOptionTypeApplePay nonce:nil error:nil];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(__unused UITableView *)tableView heightForRowAtIndexPath:(__unused NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(__unused UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 && self.paymentMethodNonces.count > 0) {
        return 1;
    } else {
        return [self.paymentOptionsData count];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.paymentMethodNonces.count == 0) {
        return nil;
    } else if (section == 0) {
        // TODO: - add header view with edit button, but only show edit button if requested on BTDropInRequest
        return BTUIKLocalizedString(RECENT_LABEL);
    } else if (section == 1) {
        return BTUIKLocalizedString(OTHER_LABEL);
    } else {
        return nil;
    }
}

@end
