#import <XCTest/XCTest.h>

#import "BTUIKViewUtil.h"
#import "BTUIKPaymentOptionType.h"

@interface BTUIKViewUtilTests : XCTestCase

@end

@implementation BTUIKViewUtilTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_isPaymentOptionTypeACreditCard_validCreditCards {
    NSArray *validCreditCards = @[
                                  @(BTUIKPaymentOptionTypeAMEX),
                                  @(BTUIKPaymentOptionTypeDinersClub),
                                  @(BTUIKPaymentOptionTypeDiscover),
                                  @(BTUIKPaymentOptionTypeMasterCard),
                                  @(BTUIKPaymentOptionTypeVisa),
                                  @(BTUIKPaymentOptionTypeJCB),
                                  @(BTUIKPaymentOptionTypeLaser),
                                  @(BTUIKPaymentOptionTypeMaestro),
                                  @(BTUIKPaymentOptionTypeUnionPay),
                                  @(BTUIKPaymentOptionTypeSolo),
                                  @(BTUIKPaymentOptionTypeSwitch),
                                  @(BTUIKPaymentOptionTypeUKMaestro),
                                  ];
    for (NSNumber *creditCard in validCreditCards) {
        XCTAssertTrue([BTUIKViewUtil isPaymentOptionTypeACreditCard:[creditCard integerValue]], @"Payment Option Type with integer value %@", creditCard);
    }
}

- (void)test_isPaymentOptionTypeACreditCard_notACreditCardType {
    NSArray *notACreditCardPaymentOptionType = @[
                                  @(BTUIKPaymentOptionTypeUnknown),
                                  @(BTUIKPaymentOptionTypePayPal),
                                  @(BTUIKPaymentOptionTypeCoinbase),
                                  @(BTUIKPaymentOptionTypeVenmo),
                                  @(BTUIKPaymentOptionTypeApplePay),
                                  ];
    for (NSNumber *notACreditCard in notACreditCardPaymentOptionType) {
        XCTAssertFalse([BTUIKViewUtil isPaymentOptionTypeACreditCard:[notACreditCard integerValue]], @"Payment Option Type with integer value %@", notACreditCard);
    }
}
@end
