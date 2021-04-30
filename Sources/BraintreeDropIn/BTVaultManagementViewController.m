#import "BTVaultManagementViewController.h"
#import "BTDropInPaymentSelectionCell.h"
#import "BTAPIClient_Internal_Category.h"
#import "BTUIKBarButtonItem_Internal_Declaration.h"
#import "BTPaymentMethodNonce+DropIn.h"
#import "BTUIKAppearance.h"

#if __has_include(<Braintree/BraintreeCore.h>) // CocoaPods
#import <Braintree/BraintreeCard.h>
#import <Braintree/BraintreeCore.h>
#else
#import <BraintreeCard/BraintreeCard.h>
#import <BraintreeCore/BraintreeCore.h>
#endif

@interface BTVaultManagementViewController ()
@property (nonatomic, strong) NSArray *paymentMethodNonces;
@property (nonatomic, strong) UITableView *paymentOptionsTableView;
@end

@implementation BTVaultManagementViewController

NSString *const BTGraphQLDeletePaymentMethodFromSingleUseToken = @""
"mutation DeletePaymentMethodFromSingleUseToken($input: DeletePaymentMethodFromSingleUseTokenInput!) {"
"  deletePaymentMethodFromSingleUseToken(input: $input) {"
"    clientMutationId"
"  }"
"}";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [BTUIKAppearance sharedInstance].formBackgroundColor;
    self.navigationController.navigationBar.barTintColor = [BTUIKAppearance sharedInstance].barBackgroundColor;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName: [BTUIKAppearance sharedInstance].primaryTextColor
                                                                      }];
    self.navigationItem.rightBarButtonItem = [[BTUIKBarButtonItem alloc] initWithTitle:BTDropInLocalizedString(DONE_ACTION) style:UIBarButtonItemStylePlain target:self action:@selector(cancelTapped)];
    self.title = BTDropInLocalizedString(EDIT_PAYMENT_METHOD);

    self.paymentOptionsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.paymentOptionsTableView.backgroundColor = [UIColor clearColor];
    [self.paymentOptionsTableView registerClass:[BTDropInPaymentSelectionCell class] forCellReuseIdentifier:@"BTDropInPaymentSelectionCell"];
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.apiClient sendAnalyticsEvent:@"ios.dropin2.manager.appeared"];
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
    static NSString *simpleTableIdentifier = @"BTDropInPaymentSelectionCell";

    BTDropInPaymentSelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier forIndexPath:indexPath];

    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    BTPaymentMethodNonce *paymentMethod = self.paymentMethodNonces[indexPath.row];
    BTDropInPaymentMethodType option = [BTUIKViewUtil paymentMethodTypeForPaymentInfoType:paymentMethod.type];

    cell.detailLabel.text = paymentMethod.paymentDescription;
    cell.label.text = [BTUIKViewUtil nameForPaymentMethodType:option];
    cell.iconView.paymentMethodType = option;
    cell.type = option;

    return cell;
}

- (void)tableView:(__unused UITableView *)tableView commitEditingStyle:(__unused UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(__unused NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        BTPaymentMethodNonce *paymentMethod = self.paymentMethodNonces[indexPath.row];
        // Empty table data and show loading while waiting for success/failure callback
        self.paymentMethodNonces = @[];
        [self.paymentOptionsTableView reloadData];
        [self showLoadingScreen:YES];
        NSDictionary *parameters = @{
                                     @"operationName": @"DeletePaymentMethodFromSingleUseToken",
                                     @"query": BTGraphQLDeletePaymentMethodFromSingleUseToken,
                                     @"variables": @{
                                             @"input": @{ @"singleUseTokenId" : paymentMethod.nonce }
                                             }
                                     };
        [self.apiClient POST:@""
                  parameters:[parameters copy]
                    httpType:BTAPIClientHTTPTypeGraphQLAPI
                  completion:^(__unused BTJSON * _Nullable body, __unused NSHTTPURLResponse * _Nullable response, __unused NSError * _Nullable error)
         {
             [self loadConfiguration];
             if (error) {
                 [self.apiClient sendAnalyticsEvent:@"ios.dropin2.manager.delete.failed"];
                 dispatch_async(dispatch_get_main_queue(), ^{
                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:BTDropInLocalizedString(THERE_WAS_AN_ERROR) preferredStyle:UIAlertControllerStyleAlert];
                     UIAlertAction *alertAction = [UIAlertAction actionWithTitle:BTDropInLocalizedString(TOP_LEVEL_ERROR_ALERT_VIEW_OK_BUTTON_TEXT) style:UIAlertActionStyleDefault handler:nil];
                     [alertController addAction: alertAction];
                     [self presentViewController:alertController animated:YES completion:nil];
                 });
             } else {
                 [self.apiClient sendAnalyticsEvent:@"ios.dropin2.manager.delete.succeeded"];
             }
         }];
    }
}

- (BOOL)tableView:(__unused UITableView *)tableView canEditRowAtIndexPath:(__unused NSIndexPath *)indexPath {
    return YES;
}

-(CGFloat)tableView:(__unused UITableView *)tableView heightForRowAtIndexPath:(__unused NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(__unused UITableView *)tableView numberOfRowsInSection:(__unused NSInteger)section {
    return [self.paymentMethodNonces count];
}

@end
