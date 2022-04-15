#import <BraintreeDropIn/BTDropInController.h>
#import "BTVaultManagementViewController.h"
#import "BTCardFormViewController.h"
#import "BTPaymentSelectionViewController.h"
#import "BTEnrollmentVerificationViewController.h"
#import "BTAPIClient_Internal_Category.h"
#import "BTUIKAppearance.h"
#import "BTUIKViewUtil.h"
#import "BTConfiguration+DropIn.h"
#import "BTDropInResult_Internal.h"

#if __has_include(<Braintree/BraintreeCore.h>) // CocoaPods
#import <Braintree/BraintreeCard.h>
#import <Braintree/BraintreeCore.h>
#import <Braintree/BraintreePaymentFlow.h>
#import <Braintree/BTThreeDSecureResult.h>
#import <Braintree/BraintreeUnionPay.h>
#else
#import <BraintreeCard/BraintreeCard.h>
#import <BraintreeCore/BraintreeCore.h>
#import <BraintreePaymentFlow/BraintreePaymentFlow.h>
#import <BraintreeThreeDSecure/BTThreeDSecureResult.h>
#import <BraintreeUnionPay/BraintreeUnionPay.h>
#endif

#define BT_ANIMATION_SLIDE_SPEED 0.35
#define BT_ANIMATION_TRANSITION_SPEED 0.1
#define BT_HALF_SHEET_MARGIN 5
#define BT_HALF_SHEET_CORNER_RADIUS 12

@interface BTDropInControllerPresentTransition : NSObject <UIViewControllerAnimatedTransitioning>
@end

@interface BTDropInControllerDismissTransition : NSObject <UIViewControllerAnimatedTransitioning>
@end

@interface BTDropInController () <BTDropInControllerDelegate, BTViewControllerPresentingDelegate, BTPaymentSelectionViewControllerDelegate, BTCardFormViewControllerDelegate, UIViewControllerTransitioningDelegate, BTThreeDSecureRequestDelegate>

@property (nonatomic, strong) BTConfiguration *configuration;
@property (nonatomic, strong, readwrite) BTAPIClient *apiClient;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *contentClippingView;
@property (nonatomic, strong) BTPaymentSelectionViewController *paymentSelectionViewController;
@property (nonatomic, strong) UINavigationController *paymentSelectionNavigationController;
@property (nonatomic, strong) NSLayoutConstraint *contentViewTopConstraint;
@property (nonatomic, strong) NSLayoutConstraint *contentViewBottomConstraint;
@property (nonatomic) BOOL useBlur;
@property (nonatomic, copy) NSArray *displayCardTypes;
@property (nonatomic, strong) UIVisualEffectView *blurredContentBackgroundView;
@property (nonatomic, copy, nullable) BTDropInControllerHandler handler;

@end

@implementation BTDropInController

#pragma mark - Lifecycle

- (nullable instancetype)initWithAuthorization:(NSString *)authorization
                                       request:(BTDropInRequest *)request
                                       handler:(BTDropInControllerHandler) handler {
    if (self = [super init]) {
        BTAPIClient *client = [[BTAPIClient alloc] initWithAuthorization:authorization sendAnalyticsEvent:NO];
        self.apiClient = [client copyWithSource:client.metadata.source integration:BTClientMetadataIntegrationDropIn2];

        _dropInRequest = [request copy];
        if (!_apiClient || !_dropInRequest) {
            return nil;
        }
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            self.modalPresentationStyle = UIModalPresentationFormSheet;
            // Customize the iPad size...
            // self.preferredContentSize = CGSizeMake(600, 400);
        } else {
            self.transitioningDelegate = self;
            self.modalPresentationStyle = UIModalPresentationCustom;
        }

        BTDropInUICustomization *defaultCustomization = [[BTDropInUICustomization alloc] initWithColorScheme:BTDropInColorSchemeLight];
        [[BTUIKAppearance sharedInstance] configureWithUICustomization:request.uiCustomization ?: defaultCustomization];
        
        self.useBlur = !UIAccessibilityIsReduceTransparencyEnabled();
        if (![BTUIKAppearance sharedInstance].useBlurs) {
            self.useBlur = NO;
        }
        self.handler = handler;
        self.displayCardTypes = @[];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViews];
    [self setUpChildViewControllers];
    [self setUpConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.paymentSelectionViewController loadConfiguration];
    [self resetDropInState];
    [self loadConfiguration];
    [self.apiClient sendAnalyticsEvent:@"ios.dropin2.appear"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.contentViewTopConstraint.constant = [self calculateContentViewTopConstraintConstant];
    self.contentViewBottomConstraint.constant = -[self sheetInset];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.apiClient sendAnalyticsEvent:@"ios.dropin2.disappear"];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    // before rotating
    [coordinator animateAlongsideTransition:^(__unused id<UIViewControllerTransitionCoordinatorContext> context) {
        // while rotating
        if (self.view.window != nil && !self.isBeingDismissed) {
            [self flexViewAnimated:NO];
            [self.view setNeedsDisplay];
            [self.view setNeedsLayout];
        }
    } completion:^(__unused id<UIViewControllerTransitionCoordinatorContext> context) {
        // after rotating
    }];
}

#pragma mark - Setup

- (void)setUpViews {
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[BTDropInController.self]]
     setTitleTextAttributes:@{NSForegroundColorAttributeName:[BTUIKAppearance sharedInstance].tintColor,
                              NSFontAttributeName:[BTUIKAppearance sharedInstance].bodyFont}
     forState:UIControlStateNormal];
    if ([BTUIKAppearance sharedInstance].tintColor != nil) {
        self.view.tintColor = [BTUIKAppearance sharedInstance].tintColor;
    }
    self.view.opaque = NO;
    self.view.backgroundColor = [BTUIKAppearance sharedInstance].overlayColor;
    self.view.userInteractionEnabled = YES;
    

    self.contentView = [[UIView alloc] init];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentView.backgroundColor = self.useBlur ? [UIColor clearColor] : [BTUIKAppearance sharedInstance].formBackgroundColor;
    self.contentView.layer.cornerRadius = BT_HALF_SHEET_CORNER_RADIUS;
    self.contentView.clipsToBounds = YES;

    [self.view addSubview: self.contentView];
    
    self.contentClippingView = [[UIView alloc] init];
    self.contentClippingView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview: self.contentClippingView];
    self.contentClippingView.backgroundColor = [UIColor clearColor];
    self.contentClippingView.clipsToBounds = YES;
    
    UIBlurEffect *contentEffect = [UIBlurEffect effectWithStyle:[BTUIKAppearance sharedInstance].blurStyle];
    self.blurredContentBackgroundView = [[UIVisualEffectView alloc] initWithEffect:contentEffect];
    self.blurredContentBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    self.blurredContentBackgroundView.hidden = !self.useBlur;
    [self.contentView addSubview:self.blurredContentBackgroundView];
    [self.contentView sendSubviewToBack:self.blurredContentBackgroundView];
}

- (void)setUpChildViewControllers {
    self.paymentSelectionViewController = [[BTPaymentSelectionViewController alloc] initWithAPIClient:self.apiClient request:self.dropInRequest];
    self.paymentSelectionViewController.delegate = self;
    self.paymentSelectionNavigationController = [[UINavigationController alloc] initWithRootViewController:self.paymentSelectionViewController];
    self.paymentSelectionNavigationController.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.paymentSelectionNavigationController.view.hidden = YES;

    [self.contentClippingView addSubview:self.paymentSelectionNavigationController.view];
}

- (void)setUpConstraints {
    NSDictionary *viewBindings = @{
                                   @"view": self,
                                   @"contentView": self.contentView,
                                   @"contentClippingView":self.contentClippingView,
                                   @"paymentSelectionView":self.paymentSelectionNavigationController.view
                                   };

    NSDictionary *metrics = @{@"BT_HALF_SHEET_MARGIN":@([self sheetInset])};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(BT_HALF_SHEET_MARGIN)-[contentView]-(BT_HALF_SHEET_MARGIN)-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:viewBindings]];

    self.contentViewTopConstraint = [self.contentView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor];
    self.contentViewTopConstraint.active = YES;

    self.contentViewBottomConstraint = [self.contentView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor];
    self.contentViewBottomConstraint.active = YES;

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[paymentSelectionView]|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:viewBindings]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[paymentSelectionView]|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:viewBindings]];
    
    [self.blurredContentBackgroundView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
    [self.blurredContentBackgroundView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
    [self.blurredContentBackgroundView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor].active = YES;
    [self.blurredContentBackgroundView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor].active = YES;
    
    [self applyContentViewConstraints];
}

- (void)loadConfiguration {
    [self.apiClient fetchOrReturnRemoteConfiguration:^(BTConfiguration * _Nullable configuration, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.configuration = configuration;
            if (!error) {
                self.paymentSelectionNavigationController.view.hidden = NO;
                self.paymentSelectionNavigationController.view.alpha = 1.0;

                NSMutableArray *paymentMethodTypes = [NSMutableArray new];
                for (NSString *supportedCardType in self.configuration.supportedCardTypes) {
                    BTDropInPaymentMethodType paymentMethodType = [BTUIKViewUtil paymentMethodTypeForPaymentInfoType:supportedCardType];
                    if (paymentMethodType != BTDropInPaymentMethodTypeUnknown) {
                        [paymentMethodTypes addObject: @(paymentMethodType)];
                    }
                }
                self.displayCardTypes = paymentMethodTypes;
            } else {
                if (self.handler) {
                    self.handler(self, nil, error);
                }
            }
        });
    }];
}

#pragma mark - View management and actions

- (void)cardTokenizationCompleted:(BTPaymentMethodNonce *)tokenizedCard error:(NSError *)error sender:(BTCardFormViewController *)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.handler) {
            BTDropInResult *result = [[BTDropInResult alloc] initWithEnvironment:self.configuration.environment];
            if (tokenizedCard != nil) {
                result.paymentMethodType = [BTUIKViewUtil paymentMethodTypeForPaymentInfoType:tokenizedCard.type];
                result.paymentMethod = tokenizedCard;
            } else if (error == nil) {
                result.canceled = YES;
            }
            [sender dismissViewControllerAnimated:YES completion:^{
                if ([self.configuration.json[@"threeDSecureEnabled"] isTrue] && self.dropInRequest.threeDSecureRequest) {
                    [self threeDSecureVerification:tokenizedCard];
                } else {
                    self.handler(self, result, error);
                }
            }];
        }
    });
}

- (void)threeDSecureVerification:(BTPaymentMethodNonce *)tokenizedCard {
    BTPaymentFlowDriver *paymentFlowDriver = [[BTPaymentFlowDriver alloc] initWithAPIClient:self.apiClient];
    paymentFlowDriver.viewControllerPresentingDelegate = self;

    BTThreeDSecureRequest *request = self.dropInRequest.threeDSecureRequest;
    request.nonce = tokenizedCard.nonce;

    if (request.versionRequested == BTThreeDSecureVersion2) {
        request.threeDSecureRequestDelegate = self;
    }

    [self.paymentSelectionViewController showLoadingScreen: YES];
    [paymentFlowDriver startPaymentFlow:request completion:^(BTPaymentFlowResult * _Nonnull result, NSError * _Nonnull error) {
        BTThreeDSecureResult *threeDSecureResult = (BTThreeDSecureResult *)result;
        [self.paymentSelectionViewController showLoadingScreen:NO];
        if (self.handler) {
            BTDropInResult *dropInResult = [[BTDropInResult alloc] initWithEnvironment:self.configuration.environment];
            if (threeDSecureResult.tokenizedCard != nil) {
                dropInResult.paymentMethodType = [BTUIKViewUtil paymentMethodTypeForPaymentInfoType:threeDSecureResult.tokenizedCard.type];
                dropInResult.paymentMethod = threeDSecureResult.tokenizedCard;
            } else if (error != nil && error.code == BTPaymentFlowDriverErrorTypeCanceled) {
                // Show the updated payment selection screen if the user canceled out of the 3DS challenge
                [self reloadDropInData];
                return;
            }
            self.handler(self, dropInResult, error);
        }
    }];
}

- (void)onLookupComplete:(__unused BTThreeDSecureRequest *)request lookupResult:(__unused BTThreeDSecureResult *)result next:(void (^)(void))next {
    next();
}

- (void)showCardForm:(__unused id)sender {
    BTCardFormViewController* vd = [[BTCardFormViewController alloc] initWithAPIClient:self.apiClient request:self.dropInRequest];
    vd.supportedCardTypes = self.displayCardTypes;
    vd.delegate = self;
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:vd];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        navController.modalPresentationStyle = UIModalPresentationPageSheet;
    } else {
        navController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    [self presentViewController:navController animated:YES completion:nil];
}

#pragma mark - UI Helpers

- (float)sheetInset {
    return [self isFormSheet] ? 0 : BT_HALF_SHEET_MARGIN;
}

- (void)flexViewAnimated:(BOOL)animated{
    self.contentViewTopConstraint.constant = [self calculateContentViewTopConstraintConstant];

    [self applyContentViewConstraints];
    
    [self.view setNeedsUpdateConstraints];

    self.contentViewBottomConstraint.constant = -[self sheetInset];

    if (animated) {
        [UIView animateWithDuration:BT_ANIMATION_SLIDE_SPEED delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:4 options:0 animations:^{
            [self.view layoutIfNeeded];
        } completion:nil];
    } else {
        [self.view updateConstraints];
        [self.view layoutIfNeeded];
    }
}

- (void)applyContentViewConstraints {
    NSDictionary *viewBindings = @{@"contentClippingView": self.contentClippingView};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentClippingView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewBindings]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentClippingView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewBindings]];
}

- (void)resetDropInState {
    self.configuration = nil;
    self.paymentSelectionNavigationController.view.hidden = NO;
    self.paymentSelectionNavigationController.view.alpha = 1.0;
}

// No half sheet when in landscape or FormSheet modes.
- (BOOL)supportsHalfSheet {
    if([BTUIKViewUtil isOrientationLandscape] || [self isFormSheet]) {
        return false;
    }
    return true;
}

- (BOOL)isFormSheet {
    return self.modalPresentationStyle == UIModalPresentationFormSheet;
}

- (CGFloat)safeAreaHeight {
    return CGRectGetHeight(self.view.safeAreaLayoutGuide.layoutFrame);
}

- (CGFloat)calculateContentViewTopConstraintConstant {
    if ([self isFormSheet]) {
        return 0;
    } else {
        CGFloat topOffset = [self safeAreaHeight] - [self.paymentSelectionViewController sheetHeight] - [self sheetInset];
        return MAX(BT_HALF_SHEET_MARGIN, topOffset);
    }
}

#pragma mark - UI Preferences

- (BOOL)prefersStatusBarHidden {
    if (self.presentingViewController != nil) {
        return [self.presentingViewController prefersStatusBarHidden];
    }
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.presentingViewController != nil) {
        return [self.presentingViewController preferredStatusBarStyle];
    }
    return UIStatusBarStyleDefault;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

#pragma mark BTViewControllerPresentingDelegate

- (void)paymentDriver:(__unused id)driver requestsPresentationOfViewController:(UIViewController *)viewController {
    // Needed for iPad
    viewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)paymentDriver:(__unused id)driver requestsDismissalOfViewController:(UIViewController *)viewController {
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)selectionCompletedWithPaymentMethodType:(BTDropInPaymentMethodType)type nonce:(BTPaymentMethodNonce *)nonce error:(NSError *)error {
    if (error == nil) {
        [[NSUserDefaults standardUserDefaults] setInteger:type forKey:@"BT_dropInLastSelectedPaymentMethodType"];
        if (self.handler != nil) {
            BTDropInResult *result = [[BTDropInResult alloc] initWithEnvironment:self.configuration.environment];
            result.paymentMethodType = type;
            result.paymentMethod = nonce;
            if ([BTUIKViewUtil isPaymentMethodTypeACreditCard:result.paymentMethodType] && [self.configuration.json[@"threeDSecureEnabled"] isTrue] && self.dropInRequest.threeDSecureRequest) {
                [self.paymentSelectionViewController showLoadingScreen:YES];
                [self threeDSecureVerification:nonce];
            } else {
                self.handler(self, result, error);
            }
        }
    } else {
        if (self.handler != nil) {
            self.handler(self, nil, error);
        }
    }
}

- (void)cancelButtonPressedOnPaymentSelectionViewController:(BTPaymentSelectionViewController *)viewController {
    BTDropInResult *result = [[BTDropInResult alloc] initWithEnvironment:self.configuration.environment];
    result.canceled = YES;
    if (self.handler) {
        self.handler(self, result, nil);
    }
}

- (void)sheetHeightDidChange:(__unused BTPaymentSelectionViewController *)sender {
    if (!self.isBeingDismissed) {
        self.contentViewTopConstraint.constant = [self calculateContentViewTopConstraintConstant];
        self.contentViewBottomConstraint.constant = -[self sheetInset];

        [UIView animateWithDuration:BT_ANIMATION_TRANSITION_SPEED delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:4 options:0 animations:^{
            [self.view layoutIfNeeded];
        } completion:nil];
    }
}

#pragma mark BTDropInControllerDelegate

- (void)reloadDropInData {
    [self.paymentSelectionViewController loadConfiguration];
    [self flexViewAnimated:NO];
    [self.view setNeedsDisplay];
}

- (void)editPaymentMethods:(__unused id)sender {
    BTVaultManagementViewController* vaultManagementViewController = [[BTVaultManagementViewController alloc] initWithAPIClient:self.apiClient request:self.dropInRequest];
    vaultManagementViewController.delegate = self;
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:vaultManagementViewController];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        navController.modalPresentationStyle = UIModalPresentationPageSheet;
    } else {
        navController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    [self presentViewController:navController animated:YES completion:nil];
}

#pragma mark UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(__unused UIViewController *)presented
                                                                  presentingController:(__unused UIViewController *)presenting
                                                                      sourceController:(__unused UIViewController *)source
{
    return [[BTDropInControllerPresentTransition alloc] init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(__unused UIViewController *)dismissed
{
    return [[BTDropInControllerDismissTransition alloc] init];
}

@end

#pragma mark Private Animation Classes

@implementation BTDropInControllerPresentTransition

- (NSTimeInterval)transitionDuration:(__unused id<UIViewControllerContextTransitioning>)transitionContext {
    return BT_ANIMATION_SLIDE_SPEED;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    BTDropInController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:toViewController.view];

    // Move content off screen so it can be animated in when it appears
    CGFloat sh = CGRectGetHeight([[UIScreen mainScreen] bounds]) + [BTUIKViewUtil statusBarHeight];
    toViewController.contentViewBottomConstraint.constant = sh;
    toViewController.contentViewTopConstraint.constant = sh;
    [toViewController.view setNeedsUpdateConstraints];
    [toViewController.view layoutIfNeeded];
    [toViewController flexViewAnimated:YES];
    toViewController.view.alpha = 0;

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toViewController.view.alpha = 1;
    } completion:^(__unused BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end

@implementation BTDropInControllerDismissTransition

- (NSTimeInterval)transitionDuration:(__unused id<UIViewControllerContextTransitioning>)transitionContext {
    return BT_ANIMATION_SLIDE_SPEED;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    BTDropInController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    CGFloat sh = CGRectGetHeight([[UIScreen mainScreen] bounds]);
    fromViewController.contentViewBottomConstraint.constant = sh;
    fromViewController.contentViewTopConstraint.constant = sh;
    [fromViewController.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromViewController.view.alpha = 0;
        [fromViewController.view layoutIfNeeded];
    } completion:^(__unused BOOL finished) {
        [fromViewController.view removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
