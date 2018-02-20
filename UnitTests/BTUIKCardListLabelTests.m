#import <XCTest/XCTest.h>

#import "BTUIKCardListLabel.h"

@interface BTUIKCardListLabelTests : XCTestCase

@end

@implementation BTUIKCardListLabelTests

- (void)test_cardListLabel_removesDuplicates {
    BTUIKCardListLabel *cardListLabel = [[BTUIKCardListLabel alloc] init];
    cardListLabel.availablePaymentOptions = @[@"Visa", @"Visa", @"Discover", @"Visa"];
    XCTAssertTrue([cardListLabel.availablePaymentOptions count] == 2, @"The array should contain 1 instance of Visa and Discover." );
    XCTAssertTrue([cardListLabel.availablePaymentOptions containsObject:@"Visa"]);
    XCTAssertTrue([cardListLabel.availablePaymentOptions containsObject:@"Discover"]);
}

@end
