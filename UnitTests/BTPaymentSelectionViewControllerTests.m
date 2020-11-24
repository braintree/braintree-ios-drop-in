#import <XCTest/XCTest.h>

#import "BTPaymentSelectionViewController.h"
#import "BTConfiguration.h"
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

- (void)test_venmoAppInstalled_hasVenmoInSupportedTypes {
    NSError *error = nil;
    BTPaymentSelectionViewController *paymentSelectionVC = [[BTPaymentSelectionViewController alloc] init];
    BTConfiguration *config = [[BTConfiguration alloc] initWithJSON:[[BTJSON alloc] init]];
    paymentSelectionVC.configuration = config;
    paymentSelectionVC.application = [[FakeApplication alloc] init];
    NSURL *venmoURL = [NSURL URLWithString:@"com.venmo.touch.v2://x-callback-url/vzero/auth"];
    ((FakeApplication *)paymentSelectionVC.application).canOpenURLWhitelist = @[venmoURL];

    [paymentSelectionVC configurationLoaded:config error:error];
    XCTAssertFalse([paymentSelectionVC.paymentOptionsData containsObject:@(BTUIKPaymentOptionTypeVenmo)]);
}

@end
