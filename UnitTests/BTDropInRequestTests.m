#import <XCTest/XCTest.h>

#import "BTDropInRequest.h"
#import "BTPostalAddress.h"

@interface BTDropInRequestTests : XCTestCase

@end

@implementation BTDropInRequestTests

- (void)test_copyProperties {
    BTDropInRequest *originalRequest = [BTDropInRequest new];
    originalRequest.amount = @"10.02";
    originalRequest.payPalRequest = [[BTPayPalRequest alloc] initWithAmount:@"10.01"];
    originalRequest.applePayDisabled = YES;
    originalRequest.paypalDisabled = YES;
    originalRequest.venmoDisabled = YES;
    originalRequest.threeDSecureVerification = YES;
    originalRequest.shouldMaskSecurityCode = YES;
    originalRequest.vaultManager = YES;

    BTDropInRequest *copiedRequest = [originalRequest copy];

    XCTAssertEqual(@"10.02", copiedRequest.amount);
    XCTAssertEqual(originalRequest.payPalRequest, copiedRequest.payPalRequest);
    XCTAssertEqual(@"10.01", copiedRequest.payPalRequest.amount);
    XCTAssertEqual(YES, copiedRequest.applePayDisabled);
    XCTAssertEqual(YES, copiedRequest.paypalDisabled);
    XCTAssertEqual(YES, copiedRequest.venmoDisabled);
    XCTAssertEqual(YES, copiedRequest.threeDSecureVerification);
    XCTAssertEqual(YES, copiedRequest.shouldMaskSecurityCode);
    XCTAssertEqual(YES, copiedRequest.vaultManager);
}

@end
