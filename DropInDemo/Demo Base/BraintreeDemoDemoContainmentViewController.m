#import "BraintreeDemoDemoContainmentViewController.h"

#import <InAppSettingsKit/IASKAppSettingsViewController.h>
#import <InAppSettingsKit/IASKSettingsReader.h>
#import <PureLayout/PureLayout.h>
#import "BraintreeCore.h"

#import "DropInDemo-Swift.h"
#import "BraintreeDemoDropInViewController.h"

@interface BraintreeDemoDemoContainmentViewController () <IASKSettingsDelegate>
@property (nonatomic, strong) UIBarButtonItem *statusItem;
@property (nonatomic, strong) BTPaymentMethodNonce *latestTokenizedPayment;
@property (nonatomic, strong) BraintreeDemoBaseViewController *currentDemoViewController;
@end

@implementation BraintreeDemoDemoContainmentViewController

- (void)viewDidLoad {
    self.title = NSLocalizedString(@"Braintree", nil);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action: @selector(tappedRefresh)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Settings", nil) style:UIBarButtonItemStylePlain target:self action: @selector(tappedSettings)];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setToolbarHidden:NO];
    [super viewDidLoad];
    [self setupToolbar];
    [self reloadIntegration];
}

- (void)setupToolbar {
    UIBarButtonItem *flexSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:nil
                                                                                   action:nil];
    UIBarButtonItem *flexSpaceRight = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                    target:nil
                                                                                    action:nil];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.numberOfLines = 0;
    [button setTitle:NSLocalizedString(@"Ready", nil) forState:UIControlStateNormal];
    [button.titleLabel setTextColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(tappedStatus) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    CGRect f = self.navigationController.navigationBar.frame;
    [button setFrame:CGRectMake(0, 0, f.size.width, f.size.height)];
    // Use custom view with button so the text can span multiple lines
    self.statusItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.statusItem.enabled = NO;
    self.toolbarItems = @[flexSpaceLeft, self.statusItem, flexSpaceRight];
}

#pragma mark - UI Updates

- (void)setLatestTokenizedPayment:(id)latestPaymentMethodOrNonce {
    _latestTokenizedPayment = latestPaymentMethodOrNonce;

    if (latestPaymentMethodOrNonce) {
        self.statusItem.enabled = YES;
    }
}

- (void)updateStatus:(NSString *)status {
    [(UIButton *)self.statusItem.customView setTitle:status forState:UIControlStateNormal];
    NSLog(@"%@", ((UIButton *)self.statusItem.customView).titleLabel.text);
}


#pragma mark - UI Handlers

- (void)tappedStatus {
    NSLog(@"Tapped status!");

    if (self.latestTokenizedPayment) {
        NSString *nonce = self.latestTokenizedPayment.nonce;
        [self updateStatus:@"Creating Transaction…"];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
        NSString *merchantAccountId;
        if ([self.latestTokenizedPayment.type isEqualToString:@"UnionPay"]) {
            merchantAccountId = @"fake_switch_usd";
        }
        
        [DemoMerchantAPIClient.shared makeTransactionWithPaymentMethodNonce:nonce
                                                             merchantAccountId:merchantAccountId
                                                                    completion:^(NSString *transactionId, NSError *error) {
                                                                        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                                                        self.latestTokenizedPayment = nil;
                                                                        if (error) {
                                                                            [self updateStatus:error.localizedDescription];
                                                                        } else {
                                                                            [self updateStatus:transactionId];
                                                                        }
                                                                    }];
    }
}

- (IBAction)tappedRefresh {
    [self reloadIntegration];
}

- (IBAction)tappedSettings {
    IASKAppSettingsViewController *appSettingsViewController = [[IASKAppSettingsViewController alloc] init];
    appSettingsViewController.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:appSettingsViewController];
    [self presentViewController:nav animated:YES completion:nil];
}


#pragma mark - Demo Integration Lifecycle


- (void)reloadIntegration {
    if (self.currentDemoViewController) {
        [self.currentDemoViewController willMoveToParentViewController:nil];
        [self.currentDemoViewController removeFromParentViewController];
        [self.currentDemoViewController.view removeFromSuperview];
    }

    self.title = NSLocalizedString(@"Braintree", nil);
    
    if (DemoSettings.authorizationOverride) {
        self.currentDemoViewController = [self instantiateCurrentIntegrationViewControllerWithAuthorization:DemoSettings.authorizationOverride];
        return;
    }

    if (DemoSettings.useTokenizationKey) {
        [self updateStatus:@"Using Tokenization Key"];

        // If we're using a Tokenization Key, then we're not using a Customer.
        NSString *tokenizationKey;
        switch (DemoSettings.currentEnvironment) {
            case DemoEnvironmentSandbox:
                tokenizationKey = @"sandbox_9dbg82cq_dcpspy2brwdjr3qn";
                break;
            case DemoEnvironmentProduction:
                tokenizationKey = @"production_t2wns2y2_dfy45jdj3dxkmz5m";
                break;
            case DemoEnvironmentCustom:
            default:
                tokenizationKey = @"development_testing_integration_merchant_id";
                break;
        }

        self.currentDemoViewController = [self instantiateCurrentIntegrationViewControllerWithAuthorization:tokenizationKey];
        return;
    }

    [self updateStatus:@"Fetching Client Token…"];

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    [DemoMerchantAPIClient.shared createCustomerAndFetchClientTokenWithCompletion:^(NSString *clientToken, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (error) {
            [self updateStatus:error.localizedDescription];
        } else {
            [self updateStatus:@"Using Client Token"];
            self.currentDemoViewController = [self instantiateCurrentIntegrationViewControllerWithAuthorization:clientToken];
        }
    }];
}

- (void)setCurrentDemoViewController:(BraintreeDemoBaseViewController *)currentDemoViewController {
    _currentDemoViewController = currentDemoViewController;
    
    if (!_currentDemoViewController) {
        [self updateStatus:@"Demo not available"];
        return;
    }

    [self updateStatus:[NSString stringWithFormat:@"Presenting %@", NSStringFromClass([_currentDemoViewController class])]];
    _currentDemoViewController.progressBlock = [self progressBlock];
    _currentDemoViewController.completionBlock = [self completionBlock];
    _currentDemoViewController.transactionBlock = [self transactionBlock];
    
    [self containIntegrationViewController:_currentDemoViewController];
    
    self.title = _currentDemoViewController.title;
}

- (BraintreeDemoBaseViewController *)instantiateCurrentIntegrationViewControllerWithAuthorization:(NSString *)authorization {
    return [[BraintreeDemoDropInViewController alloc] initWithAuthorization:authorization];
}

- (void)containIntegrationViewController:(UIViewController *)viewController {
    [self addChildViewController:viewController];

    [self.view addSubview:viewController.view];

    [viewController.view autoPinToTopLayoutGuideOfViewController:self withInset:0];
    [viewController.view autoPinToBottomLayoutGuideOfViewController:self withInset:0];
    [viewController.view autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [viewController.view autoPinEdgeToSuperviewEdge:ALEdgeTrailing];

    [viewController didMoveToParentViewController:self];
}


#pragma mark - Progress and Completion Blocks

- (void (^)(NSString *message))progressBlock {
    // This class is responsible for retaining the progress block
    static id block;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        block = ^(NSString *message){
            [self updateStatus:message];
        };
    });
    return block;
}

- (void (^)(BTPaymentMethodNonce *tokenized))completionBlock {
    // This class is responsible for retaining the completion block
    static id block;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        block = ^(id tokenized){
            self.latestTokenizedPayment = tokenized;
            [self updateStatus:[NSString stringWithFormat:@"Got a nonce. Tap to make a transaction."]];
        };
    });
    return block;
}

- (void (^)(void))transactionBlock {
    // This class is responsible for retaining the completion block
    static id block;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        block = ^(){
            [self tappedStatus];
        };
    });
    return block;
}

#pragma mark IASKSettingsDelegate

- (void)settingsViewControllerDidEnd:(IASKAppSettingsViewController *)sender {
    [sender dismissViewControllerAnimated:YES completion:nil];
    [self reloadIntegration];
}

@end
