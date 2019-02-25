#import <XCTest/XCTest.h>

#import "BTUIKViewUtil.h"
#import "BTUIKPaymentOptionType.h"
#import "BTUIKVisualAssetType.h"
#import "BTUIKCVVBackVectorArtView.h"
#import "BTUIKCVVFrontVectorArtView.h"

@interface BTUIKViewUtilTests : XCTestCase

@end

@implementation BTUIKViewUtilTests

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
                                  @(BTUIKPaymentOptionTypeHiper),
                                  @(BTUIKPaymentOptionTypeHipercard),
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

- (void)test_getsAssetForAllVisualAssetTypes {
    NSArray *visualAssetTypes = @[
                                                 @(BTUIKVisualAssetTypeUnknown),
                                                 @(BTUIKVisualAssetTypeCVVBack),
                                                 @(BTUIKVisualAssetTypeCVVFront),
                                                 ];
    for (NSNumber *visualAsset in visualAssetTypes) {
        BTUIKVectorArtView *testAsset = [BTUIKViewUtil vectorArtViewForVisualAssetType:[visualAsset integerValue]];
        XCTAssertNotNil(testAsset);
        switch ([visualAsset integerValue]) {
            case 1:
                XCTAssertTrue([testAsset isKindOfClass:[BTUIKCVVBackVectorArtView class]]);
                break;
            case 2:
                XCTAssertTrue([testAsset isKindOfClass:[BTUIKCVVFrontVectorArtView class]]);
                break;
            default:
                XCTAssertTrue([testAsset isKindOfClass:[BTUIKVectorArtView class]]);
                break;
        }
    }
}

@end
