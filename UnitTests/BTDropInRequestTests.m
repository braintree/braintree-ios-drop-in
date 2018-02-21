#import <XCTest/XCTest.h>

#import "BTDropInRequest.h"
#import "BTPostalAddress.h"

@interface BTDropInRequestTests : XCTestCase

@end

@implementation BTDropInRequestTests

- (void)test_copyProperties {
    BTPostalAddress *address = [BTPostalAddress new];
    BTDropInRequest *originalRequest = [BTDropInRequest new];
    originalRequest.amount = @"10.01";
    originalRequest.currencyCode = @"USD";
    originalRequest.noShipping = YES;
    originalRequest.shippingAddress = address;
    originalRequest.additionalPayPalScopes = [NSSet setWithObjects:@"email", nil];
    originalRequest.applePayDisabled = YES;
    originalRequest.paypalDisabled = YES;
    originalRequest.venmoDisabled = YES;
    originalRequest.threeDSecureVerification = YES;
    originalRequest.shouldMaskSecurityCode = YES;

    BTDropInRequest *copiedRequest = [originalRequest copy];

    XCTAssertEqual(originalRequest.amount, copiedRequest.amount);
    XCTAssertEqual(originalRequest.currencyCode, copiedRequest.currencyCode);
    XCTAssertEqual(originalRequest.noShipping, copiedRequest.noShipping);
    XCTAssertEqual(originalRequest.shippingAddress, copiedRequest.shippingAddress);
    XCTAssertEqual(originalRequest.additionalPayPalScopes, copiedRequest.additionalPayPalScopes);
    XCTAssertEqual(originalRequest.applePayDisabled, copiedRequest.applePayDisabled);
    XCTAssertEqual(originalRequest.paypalDisabled, copiedRequest.paypalDisabled);
    XCTAssertEqual(originalRequest.venmoDisabled, copiedRequest.venmoDisabled);
    XCTAssertEqual(originalRequest.threeDSecureVerification, copiedRequest.threeDSecureVerification);
    XCTAssertEqual(originalRequest.shouldMaskSecurityCode, copiedRequest.shouldMaskSecurityCode);
}

@end
