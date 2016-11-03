#import <XCTest/XCTest.h>
#import "BTUIKCardType.h"

@interface BTUIKCardTypeTests : XCTestCase

@end

@implementation BTUIKCardTypeTests

- (void)testMaestroCards {
    NSArray *possibleCards = [BTUIKCardType possibleCardTypesForNumber:@"6020"];
    XCTAssertEqual([possibleCards count], (NSUInteger)1, @"");
    BTUIKCardType *card = [possibleCards objectAtIndex:0];
    XCTAssertEqualObjects([card brand], @"Maestro");
}

@end
