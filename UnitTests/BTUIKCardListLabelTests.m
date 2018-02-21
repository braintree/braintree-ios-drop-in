#import <XCTest/XCTest.h>

#import "BTUIKCardListLabel.h"

@interface BTUIKCardListLabelTests : XCTestCase

@end

@implementation BTUIKCardListLabelTests

- (void)test_cardListLabel_removesDuplicates {
    BTUIKCardListLabel *cardListLabel = [[BTUIKCardListLabel alloc] init];
    cardListLabel.availablePaymentOptions = @[@"Visa", @"Visa", @"Discover", @"Visa"];
    XCTAssertEqual([cardListLabel.availablePaymentOptions count], (NSUInteger)2);
    XCTAssertTrue([cardListLabel.availablePaymentOptions containsObject:@"Visa"]);
    XCTAssertTrue([cardListLabel.availablePaymentOptions containsObject:@"Discover"]);
}

@end
