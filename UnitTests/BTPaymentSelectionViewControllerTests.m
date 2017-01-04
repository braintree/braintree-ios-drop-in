#import <XCTest/XCTest.h>

#import "BTPaymentSelectionViewController.h"
#import "BTConfiguration.h"

@interface BTPaymentSelectionViewController ()
@property (nonatomic, strong) NSArray *paymentOptionsData;
@end

@interface BTPaymentSelectionViewControllerTests : XCTestCase

@end

@implementation BTPaymentSelectionViewControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
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

@end
