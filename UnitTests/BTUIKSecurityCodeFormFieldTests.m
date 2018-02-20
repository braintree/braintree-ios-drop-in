#import <XCTest/XCTest.h>

#import "BTUIKSecurityCodeFormField.h"

@interface BTUIKSecurityCodeFormFieldTests : XCTestCase

@end

@implementation BTUIKSecurityCodeFormFieldTests

- (void)test_BTUIKSecurityCodeFormField_secureTextEntry_isTrue {
    BTUIKSecurityCodeFormField *securityCodeField = [[BTUIKSecurityCodeFormField alloc] init];
    XCTAssertTrue(securityCodeField.textField.secureTextEntry);
}

@end
