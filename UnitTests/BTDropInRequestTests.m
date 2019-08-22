#import <XCTest/XCTest.h>

#import "BTDropInRequest.h"
#import "BTPostalAddress.h"
#import "BraintreePayPal.h"
#import "BraintreePaymentFlow.h"

@interface BTDropInRequestTests : XCTestCase

@end

@implementation BTDropInRequestTests

- (void)test_copyProperties {
    BTThreeDSecureRequest *threeDSecureRequest = [[BTThreeDSecureRequest alloc] init];
    threeDSecureRequest.versionRequested = BTThreeDSecureVersion2;
    threeDSecureRequest.amount = [NSDecimalNumber decimalNumberWithString:@"1.45"];
    threeDSecureRequest.nonce = @"a-nonce";
    threeDSecureRequest.email = @"tester@example.com";
    threeDSecureRequest.mobilePhoneNumber = @"5151234321";

    BTThreeDSecurePostalAddress *billingAddress = [[BTThreeDSecurePostalAddress alloc] init];
    billingAddress.givenName = @"Joe";
    billingAddress.surname = @"Guy";
    billingAddress.phoneNumber = @"12345678";
    billingAddress.streetAddress = @"555 Smith St.";
    billingAddress.extendedAddress = @"#5";
    billingAddress.locality = @"Oakland";
    billingAddress.region = @"CA";
    billingAddress.countryCodeAlpha2 = @"US";
    billingAddress.postalCode = @"54321";
    threeDSecureRequest.billingAddress = billingAddress;

    BTThreeDSecureAdditionalInformation *info = [BTThreeDSecureAdditionalInformation new];
    info.shippingAddress = billingAddress;
    info.shippingMethodIndicator = @"GEN";
    threeDSecureRequest.additionalInformation = info;

    BTDropInRequest *originalRequest = [BTDropInRequest new];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    originalRequest.amount = @"10.02";
#pragma clang diagnostic pop
    
    originalRequest.payPalRequest = [[BTPayPalRequest alloc] initWithAmount:@"10.01"];
    originalRequest.applePayDisabled = YES;
    originalRequest.paypalDisabled = YES;
    originalRequest.venmoDisabled = YES;
    originalRequest.cardDisabled = YES;
    originalRequest.threeDSecureVerification = YES;
    originalRequest.threeDSecureRequest = threeDSecureRequest;
    originalRequest.cardholderNameSetting = BTFormFieldOptional;
    originalRequest.shouldMaskSecurityCode = YES;
    originalRequest.vaultManager = YES;
    originalRequest.vaultCard = NO;
    originalRequest.allowVaultCardOverride = YES;

    BTDropInRequest *copiedRequest = [originalRequest copy];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    XCTAssertEqual(originalRequest.amount, copiedRequest.amount);
#pragma clang diagnostic pop
    
    XCTAssertEqual(originalRequest.payPalRequest, copiedRequest.payPalRequest);
    XCTAssertEqual(originalRequest.applePayDisabled, copiedRequest.applePayDisabled);
    XCTAssertEqual(originalRequest.paypalDisabled, copiedRequest.paypalDisabled);
    XCTAssertEqual(originalRequest.venmoDisabled, copiedRequest.venmoDisabled);
    XCTAssertEqual(originalRequest.cardDisabled, copiedRequest.cardDisabled);
    XCTAssertEqual(originalRequest.threeDSecureVerification, copiedRequest.threeDSecureVerification);
    XCTAssertEqual(originalRequest.cardholderNameSetting, copiedRequest.cardholderNameSetting);
    XCTAssertEqual(originalRequest.shouldMaskSecurityCode, copiedRequest.shouldMaskSecurityCode);
    XCTAssertEqual(originalRequest.vaultManager, copiedRequest.vaultManager);
    XCTAssertEqual(originalRequest.vaultCard, copiedRequest.vaultCard);
    XCTAssertEqual(originalRequest.allowVaultCardOverride, copiedRequest.allowVaultCardOverride);

    XCTAssertEqual(originalRequest.threeDSecureRequest, copiedRequest.threeDSecureRequest);
    XCTAssertEqual(BTThreeDSecureVersion2, copiedRequest.threeDSecureRequest.versionRequested);
    XCTAssertEqual(@"Joe", copiedRequest.threeDSecureRequest.billingAddress.givenName);
    XCTAssertEqual(@"GEN", copiedRequest.threeDSecureRequest.additionalInformation.shippingMethodIndicator);
}

@end
