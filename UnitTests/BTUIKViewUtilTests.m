#import <XCTest/XCTest.h>

#import "BTUIKViewUtil.h"
#import <BraintreeDropIn/BTDropInPaymentMethodType.h>
#import "BTUIKVisualAssetType.h"
#import "BTUIKCVVBackVectorArtView.h"
#import "BTUIKCVVFrontVectorArtView.h"

@interface BTUIKViewUtilTests : XCTestCase

@end

@implementation BTUIKViewUtilTests

- (void)test_isPaymentMethodTypeACreditCard_validCreditCards {
    NSArray *validCreditCards = @[
                                  @(BTDropInPaymentMethodTypeAMEX),
                                  @(BTDropInPaymentMethodTypeDinersClub),
                                  @(BTDropInPaymentMethodTypeDiscover),
                                  @(BTDropInPaymentMethodTypeMasterCard),
                                  @(BTDropInPaymentMethodTypeVisa),
                                  @(BTDropInPaymentMethodTypeJCB),
                                  @(BTDropInPaymentMethodTypeLaser),
                                  @(BTDropInPaymentMethodTypeMaestro),
                                  @(BTDropInPaymentMethodTypeUnionPay),
                                  @(BTDropInPaymentMethodTypeHiper),
                                  @(BTDropInPaymentMethodTypeHipercard),
                                  @(BTDropInPaymentMethodTypeSolo),
                                  @(BTDropInPaymentMethodTypeSwitch),
                                  @(BTDropInPaymentMethodTypeUKMaestro),
                                  ];
    for (NSNumber *creditCard in validCreditCards) {
        XCTAssertTrue([BTUIKViewUtil isPaymentMethodTypeACreditCard:[creditCard integerValue]], @"Payment Option Type with integer value %@", creditCard);
    }
}

- (void)test_isPaymentMethodTypeACreditCard_notACreditCardType {
    NSArray *notACreditCardPaymentMethodType = @[
                                  @(BTDropInPaymentMethodTypeUnknown),
                                  @(BTDropInPaymentMethodTypePayPal),
                                  @(BTDropInPaymentMethodTypeVenmo),
                                  @(BTDropInPaymentMethodTypeApplePay),
                                  ];
    for (NSNumber *notACreditCard in notACreditCardPaymentMethodType) {
        XCTAssertFalse([BTUIKViewUtil isPaymentMethodTypeACreditCard:[notACreditCard integerValue]], @"Payment Option Type with integer value %@", notACreditCard);
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
