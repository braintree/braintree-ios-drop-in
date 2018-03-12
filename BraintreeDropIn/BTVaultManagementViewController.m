#import "BTVaultManagementViewController.h"
#import "BTDropInController.h"
#import "BTDropInPaymentSeletionCell.h"
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
@property (nonatomic, strong) UITableView *paymentOptionsTableView;
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


    self.paymentOptionsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    //[self.paymentOptionsTableView addObserver:self forKeyPath:@"contentSize" options:0 context:NULL];
    self.paymentOptionsTableView.backgroundColor = [UIColor clearColor];
    [self.paymentOptionsTableView registerClass:[BTDropInPaymentSeletionCell class] forCellReuseIdentifier:@"BTDropInPaymentSeletionCell"];
    self.paymentOptionsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.paymentOptionsTableView.delegate = self;
    self.paymentOptionsTableView.dataSource = self;
    self.paymentOptionsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.paymentOptionsTableView setAlwaysBounceVertical:NO];

    [self.view addSubview:self.paymentOptionsTableView];

    NSDictionary *viewBindings = @{@"paymentOptionsTableView": self.paymentOptionsTableView};

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[paymentOptionsTableView]|"
                                                                      options:0
                                                                      metrics:[BTUIKAppearance metrics]
                                                                        views:viewBindings]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[paymentOptionsTableView]|"
                                                                      options:0
                                                                      metrics:[BTUIKAppearance metrics]
                                                                        views:viewBindings]];

    [self.paymentOptionsTableView setEditing:YES animated:NO];
    [self showLoadingScreen:YES];
    [self loadConfiguration];
}

- (void)configurationLoaded:(__unused BTConfiguration *)configuration error:(NSError *)error {
    if (!error) {
        [self fetchPaymentMethodsOnCompletion:^{
            [self.paymentOptionsTableView reloadData];
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

#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(__unused UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"BTDropInPaymentSeletionCell";

    BTDropInPaymentSeletionCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];

    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    BTPaymentMethodNonce *paymentMethod = self.paymentMethodNonces[indexPath.row];
    BTUIKPaymentOptionType option = [BTUIKViewUtil paymentOptionTypeForPaymentInfoType:paymentMethod.type];

    cell.label.text = paymentMethod.localizedDescription;
    if ([paymentMethod isKindOfClass:[BTCardNonce class]]) {
        cell.label.attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"••• ••%@", ((BTCardNonce*)paymentMethod).lastTwo ?: @""]];
    }
    cell.iconView.paymentOptionType = option;
    cell.type = option;

    return cell;
}

- (void)tableView:(__unused UITableView *)tableView commitEditingStyle:(__unused UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(__unused NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //BTPaymentMethodNonce *paymentMethod = self.paymentMethodNonces[indexPath.row];
        // Show loading while bubbling event and waiting for success/failure callback
        // Then update UI...
        NSMutableArray *mutablePaymentMethodNonces = [NSMutableArray arrayWithArray:self.paymentMethodNonces];
        [mutablePaymentMethodNonces removeObjectAtIndex:indexPath.row];
        self.paymentMethodNonces = [mutablePaymentMethodNonces copy];
        [self.paymentOptionsTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (BOOL)tableView:(__unused UITableView *)tableView canEditRowAtIndexPath:(__unused NSIndexPath *)indexPath {
    return YES;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    BTDropInPaymentSeletionCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}

-(CGFloat)tableView:(__unused UITableView *)tableView heightForRowAtIndexPath:(__unused NSIndexPath *)indexPath {
    return 44.0;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(__unused UITableView *)tableView numberOfRowsInSection:(__unused NSInteger)section {
    return [self.paymentMethodNonces count];
}

@end
