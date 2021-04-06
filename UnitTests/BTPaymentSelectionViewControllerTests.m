#import <XCTest/XCTest.h>

#import "BTPaymentSelectionViewController.h"
#import "BTUIKAppearance.h"
#import <BraintreeCore/BTConfiguration.h>
#import "UnitTests-Swift.h"

@interface BTPaymentSelectionViewController ()
@property (nonatomic, strong) NSArray *paymentOptionsData;
@property (nonatomic, strong) id application;
@end

@interface BTPaymentSelectionViewControllerTests : XCTestCase

@end

@implementation BTPaymentSelectionViewControllerTests

- (void)setUp {
    [super setUp];
    BTDropInUICustomization *uiCustomization = [[BTDropInUICustomization alloc] initWithColorScheme:BTDropInColorSchemeLight];
    [[BTUIKAppearance sharedInstance] configureWithUICustomization:uiCustomization];
}

- (void)test_initWithAPIClient_setsAllProperties {
    BTDropInRequest *dropInRequest = [[BTDropInRequest alloc] init];
    MockAPIClient *mockAPIClient = [[MockAPIClient alloc] initWithAuthorization: @"development_client_key"];
    BTPaymentSelectionViewController *selectionVC = [[BTPaymentSelectionViewController alloc] initWithAPIClient:mockAPIClient request:dropInRequest];

    XCTAssertNotNil(selectionVC.venmoDriver);
    XCTAssertNotNil(selectionVC.apiClient);
    XCTAssertNotNil(selectionVC.dropInRequest);
}

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
    XCTAssertTrue([paymentSelectionVC.paymentOptionsData containsObject:@(BTDropInPaymentMethodTypeUnknown)]);
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
    XCTAssertFalse([paymentSelectionVC.paymentOptionsData containsObject:@(BTDropInPaymentMethodTypeUnknown)]);
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
    XCTAssertTrue([paymentSelectionVC.paymentOptionsData containsObject:@(BTDropInPaymentMethodTypeVenmo)]);
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
    XCTAssertFalse([paymentSelectionVC.paymentOptionsData containsObject:@(BTDropInPaymentMethodTypeVenmo)]);
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
    XCTAssertFalse([paymentSelectionVC.paymentOptionsData containsObject:@(BTDropInPaymentMethodTypeVenmo)]);
}

#pragma mark - paymentMethodNonces

- (void)testPaymentMethodNonces_doesNotContainDisabledPaymentMethods {
    BTDropInRequest *request = [BTDropInRequest new];
    request.paypalDisabled = YES;

    MockAPIClient *mockAPIClient = [[MockAPIClient alloc] initWithAuthorization: @"eyJ2ZXJzaW9uIjozLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiIxYzM5N2E5OGZmZGRkNDQwM2VjNzEzYWRjZTI3NTNiMzJlODc2MzBiY2YyN2M3NmM2OWVmZjlkMTE5MjljOTVkfGNyZWF0ZWRfYXQ9MjAxNy0wNC0wNVQwNjowNzowOC44MTUwOTkzMjUrMDAwMFx1MDAyNm1lcmNoYW50X2lkPWRjcHNweTJicndkanIzcW5cdTAwMjZwdWJsaWNfa2V5PTl3d3J6cWszdnIzdDRuYzgiLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvZGNwc3B5MmJyd2RqcjNxbi9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24ifQ=="];
    mockAPIClient.vaultedPaymentMethodNonces = @[
        [[BTPayPalAccountNonce alloc] init],
        [[BTCardNonce alloc] init]
    ];

    BTPaymentSelectionViewController *selectionVC = [[BTPaymentSelectionViewController alloc] initWithAPIClient:mockAPIClient request:request];

    NSDictionary *configurationJSON = @{
        @"creditCards": @{
                @"supportedCardTypes": @[@"Visa"]
        },
        @"paypalEnabled": @YES
    };
    BTJSON *json = [[BTJSON alloc] initWithData:[NSJSONSerialization dataWithJSONObject:configurationJSON
                                                                                options:0
                                                                                  error:nil]];
    BTConfiguration *configuration = [[BTConfiguration alloc] initWithJSON:json];
    selectionVC.configuration = configuration;
    [selectionVC configurationLoaded:configuration error:nil];

    XCTAssertEqual(selectionVC.paymentMethodNonces.count, 1);
    XCTAssertTrue([selectionVC.paymentMethodNonces[0] isKindOfClass:BTCardNonce.class]);
}

@end
