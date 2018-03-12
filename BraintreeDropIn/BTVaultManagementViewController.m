#import "BTVaultManagementViewController.h"
#import "BTDropInController.h"
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

@interface BTVaultManagementViewController ()
@property (nonatomic, strong) NSArray *paymentMethodNonces;
@end

@implementation BTVaultManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [BTUIKAppearance sharedInstance].formBackgroundColor;
    self.navigationController.navigationBar.barTintColor = [BTUIKAppearance sharedInstance].barBackgroundColor;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName: [BTUIKAppearance sharedInstance].primaryTextColor
                                                                      }];
    self.navigationItem.leftBarButtonItem = [[BTUIKBarButtonItem alloc] initWithTitle:BTUIKLocalizedString(CANCEL_ACTION) style:UIBarButtonItemStylePlain target:self action:@selector(cancelTapped)];
    self.title = BTUIKLocalizedString(EDIT_PAYMENT_METHOD);
    [self showLoadingScreen:YES];
    [self loadConfiguration];
}

- (void)configurationLoaded:(__unused BTConfiguration *)configuration error:(NSError *)error {
    if (!error) {
        [self fetchPaymentMethodsOnCompletion:^{
            // TODO Create/Update tableview
            NSLog(@"%@", self.paymentMethodNonces);
            [self showLoadingScreen:NO];
            [self.view layoutIfNeeded];
        }];
    }
}

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
            self.paymentMethodNonces = [paymentMethodNonces copy];
            if (completionBlock) {
                completionBlock();
            }
        }
    }];
}

#pragma mark - Helper methods

- (void)cancelTapped {
    [self.delegate reloadDropInData];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
