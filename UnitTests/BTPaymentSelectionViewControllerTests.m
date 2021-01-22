#import <XCTest/XCTest.h>

#import "BTPaymentSelectionViewController.h"
#import <BraintreeCore/BTConfiguration.h>
#import "UnitTests-Swift.h"

@interface BTPaymentSelectionViewController ()
@property (nonatomic, strong) NSArray *paymentOptionsData;
@property (nonatomic, strong) id application;
@end

@interface BTPaymentSelectionViewControllerTests : XCTestCase

@end

@implementation BTPaymentSelectionViewControllerTests

- (void)test_configurationLoaded_hasCreditCardsInSupportedCardTypes {
    NSError *error = nil;
    NSDictionary *configurationJSON = @{
                                        @"creditCards": @{
                                            @"supportedCardTypes": @[
                                                @"AMEX"
                                            ]
                                        }
                                        };
    BTJSON *json = [[BTJSON alloc] initWithData:[NSJSONSerialization dataWithJSONObject:configurationJSON options:0 error:&error]];
    BTConfiguration *configuration = [[BTConfiguration alloc] initWithJSON:json];
    BTPaymentSelectionViewController *paymentSelectionVC = [[BTPaymentSelectionViewController alloc] init];
    paymentSelectionVC.configuration = configuration;
    [paymentSelectionVC configurationLoaded:configuration error:error];
    XCTAssertTrue([paymentSelectionVC.paymentOptionsData containsObject:@(BTUIKPaymentOptionTypeUnknown)]);
}

- (void)test_configurationLoaded_doesNotHaveCreditCardsInSupportedCardTypes {
    NSError *error = nil;
    NSDictionary *configurationJSON = @{
                                        @"creditCards": @{
                                            @"supportedCardTypes": @[
                                            ]
                                        }
                                        };
    BTJSON *json = [[BTJSON alloc] initWithData:[NSJSONSerialization dataWithJSONObject:configurationJSON options:0 error:&error]];
    BTConfiguration *configuration = [[BTConfiguration alloc] initWithJSON:json];
    BTPaymentSelectionViewController *paymentSelectionVC = [[BTPaymentSelectionViewController alloc] init];
    paymentSelectionVC.configuration = configuration;
    [paymentSelectionVC configurationLoaded:configuration error:error];
    XCTAssertFalse([paymentSelectionVC.paymentOptionsData containsObject:@(BTUIKPaymentOptionTypeUnknown)]);
}

- (void)test_venmoAppInstalled_andMerchantConfiguredForVenmo_hasVenmoInSupportedTypes {
    NSDictionary *configurationJSON = @{
                                        @"payWithVenmo": @{
                                            @"accessToken": @"fake-token"
                                        }
                                        };
    BTJSON *json = [[BTJSON alloc] initWithData:[NSJSONSerialization dataWithJSONObject:configurationJSON options:0 error:nil]];
    BTConfiguration *configuration = [[BTConfiguration alloc] initWithJSON:json];

    BTPaymentSelectionViewController *paymentSelectionVC = [[BTPaymentSelectionViewController alloc] init];
    paymentSelectionVC.configuration = configuration;

    MockAPIClient *mockAPIClient = [[MockAPIClient alloc] initWithAuthorization:@""];
    MockVenmoDriver *mockVenmoDriver = [[MockVenmoDriver alloc] initWithAPIClient:mockAPIClient];
    mockVenmoDriver._isiOSAppAvailableForAppSwitch = YES;
    paymentSelectionVC.venmoDriver = mockVenmoDriver;

    NSError *error = nil;
    [paymentSelectionVC configurationLoaded:configuration error:error];
    XCTAssertTrue([paymentSelectionVC.paymentOptionsData containsObject:@(BTUIKPaymentOptionTypeVenmo)]);
}

- (void)test_venmoAppInstalled_andMerchantNotConfiguredForVenmo_venmoNotInSupportedTypes {
    BTConfiguration *configuration = [[BTConfiguration alloc] initWithJSON:[[BTJSON alloc] init]];

    BTPaymentSelectionViewController *paymentSelectionVC = [[BTPaymentSelectionViewController alloc] init];
    paymentSelectionVC.configuration = configuration;

    FakeApplication *fakeApplication = [[FakeApplication alloc] init];
    paymentSelectionVC.application = fakeApplication;
    NSURL *venmoURL = [NSURL URLWithString:@"com.venmo.touch.v2://x-callback-url/vzero/auth"];
    fakeApplication.canOpenURLWhitelist = @[venmoURL];

    NSError *error = nil;
    [paymentSelectionVC configurationLoaded:configuration error:error];
    XCTAssertFalse([paymentSelectionVC.paymentOptionsData containsObject:@(BTUIKPaymentOptionTypeVenmo)]);
}

- (void)test_venmoAppNotInstalled_andMerchantConfiguredForVenmo_venmoNotInSupportedTypes {
    NSDictionary *configurationJSON = @{
                                        @"payWithVenmo": @{
                                            @"accessToken": @"fake-token"
                                        }
                                        };
    BTJSON *json = [[BTJSON alloc] initWithData:[NSJSONSerialization dataWithJSONObject:configurationJSON options:0 error:nil]];
    BTConfiguration *configuration = [[BTConfiguration alloc] initWithJSON:json];

    BTPaymentSelectionViewController *paymentSelectionVC = [[BTPaymentSelectionViewController alloc] init];
    paymentSelectionVC.configuration = configuration;
    
    NSError *error = nil;
    [paymentSelectionVC configurationLoaded:configuration error:error];
    XCTAssertFalse([paymentSelectionVC.paymentOptionsData containsObject:@(BTUIKPaymentOptionTypeVenmo)]);
}

@end
