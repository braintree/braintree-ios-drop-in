#import <XCTest/XCTest.h>

#import <BraintreeDropIn/BraintreeDropIn.h>
#import <BraintreeCore/BTPostalAddress.h>
#import <BraintreePayPal/BraintreePayPal.h>
#import <BraintreePaymentFlow/BraintreePaymentFlow.h>
#import <BraintreeThreeDSecure/BraintreeThreeDSecure.h>

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
    
    originalRequest.payPalRequest = [[BTPayPalCheckoutRequest alloc] initWithAmount:@"10.01"];
    originalRequest.applePayDisabled = YES;
    originalRequest.paypalDisabled = YES;
    originalRequest.venmoDisabled = YES;
    originalRequest.cardDisabled = YES;
    originalRequest.threeDSecureRequest = threeDSecureRequest;
    originalRequest.cardholderNameSetting = BTFormFieldOptional;
    originalRequest.shouldMaskSecurityCode = YES;
    originalRequest.vaultManager = YES;
    originalRequest.vaultCard = NO;
    originalRequest.allowVaultCardOverride = YES;
    originalRequest.vaultVenmo = NO;

    BTDropInRequest *copiedRequest = [originalRequest copy];
    
    XCTAssertEqual(originalRequest.payPalRequest, copiedRequest.payPalRequest);
    XCTAssertEqual(originalRequest.applePayDisabled, copiedRequest.applePayDisabled);
    XCTAssertEqual(originalRequest.paypalDisabled, copiedRequest.paypalDisabled);
    XCTAssertEqual(originalRequest.venmoDisabled, copiedRequest.venmoDisabled);
    XCTAssertEqual(originalRequest.cardDisabled, copiedRequest.cardDisabled);
    XCTAssertEqual(originalRequest.cardholderNameSetting, copiedRequest.cardholderNameSetting);
    XCTAssertEqual(originalRequest.shouldMaskSecurityCode, copiedRequest.shouldMaskSecurityCode);
    XCTAssertEqual(originalRequest.vaultManager, copiedRequest.vaultManager);
    XCTAssertEqual(originalRequest.vaultCard, copiedRequest.vaultCard);
    XCTAssertEqual(originalRequest.allowVaultCardOverride, copiedRequest.allowVaultCardOverride);
    XCTAssertEqual(originalRequest.vaultVenmo, copiedRequest.vaultVenmo);

    XCTAssertEqual(originalRequest.threeDSecureRequest, copiedRequest.threeDSecureRequest);
    XCTAssertEqual(BTThreeDSecureVersion2, copiedRequest.threeDSecureRequest.versionRequested);
    XCTAssertEqual(@"Joe", copiedRequest.threeDSecureRequest.billingAddress.givenName);
    XCTAssertEqual(@"GEN", copiedRequest.threeDSecureRequest.additionalInformation.shippingMethodIndicator);
}

@end
