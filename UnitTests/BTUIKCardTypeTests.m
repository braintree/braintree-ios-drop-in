#import <XCTest/XCTest.h>
#import "BTUIKCardType.h"
#import "BTUIKViewUtil.h"

@interface BTUIKCardTypeTests : XCTestCase

@end

@implementation BTUIKCardTypeTests

- (void)test_cardSamples {
    NSMutableArray *sampleCards = [NSMutableArray array];
    [sampleCards addObject:@[@"4111111111111111", @"Visa"]];
    [sampleCards addObject:@[@"4005519200000004", @"Visa"]];
    [sampleCards addObject:@[@"4009348888881881", @"Visa"]];
    [sampleCards addObject:@[@"4012000033330026", @"Visa"]];
    [sampleCards addObject:@[@"4012000077777777", @"Visa"]];
    [sampleCards addObject:@[@"4012888888881881", @"Visa"]];
    [sampleCards addObject:@[@"4217651111111119", @"Visa"]];
    [sampleCards addObject:@[@"4500600000000061", @"Visa"]];

    // MasterCard
    [sampleCards addObject:@[@"5555555555554444", @"MasterCard"]];
    [sampleCards addObject:@[@"5105105105105100", @"MasterCard"]];
    [sampleCards addObject:@[@"2221000000000009", @"MasterCard"]];
    [sampleCards addObject:@[@"2223000048400011", @"MasterCard"]];
    [sampleCards addObject:@[@"2230000000000008", @"MasterCard"]];
    [sampleCards addObject:@[@"2300000000000003", @"MasterCard"]];
    [sampleCards addObject:@[@"2500000000000001", @"MasterCard"]];
    [sampleCards addObject:@[@"2600000000000000", @"MasterCard"]];
    [sampleCards addObject:@[@"2700000000000009", @"MasterCard"]];
    [sampleCards addObject:@[@"2720990000000007", @"MasterCard"]];

    // Discover
    [sampleCards addObject:@[@"6011111111111117", @"Discover"]];
    [sampleCards addObject:@[@"6011000990139424", @"Discover"]];

    // Amex
    [sampleCards addObject:@[@"378282246310005", @"American Express"]];
    [sampleCards addObject:@[@"371449635398431", @"American Express"]];

    // Diner's club
    [sampleCards addObject:@[@"30000000000004", @"Diners Club"]];

    // JCB
    [sampleCards addObject:@[@"3530111333300000", @"JCB"]];
    [sampleCards addObject:@[@"3566002020360505", @"JCB"]];

    // Maestro
    [sampleCards addObject:@[@"5018000000000009", @"Maestro"]];
    [sampleCards addObject:@[@"5018000000000000122", @"Maestro"]];
    [sampleCards addObject:@[@"6703000000000007", @"Maestro"]];
    [sampleCards addObject:@[@"6020111111111116", @"Maestro"]];

    // Union Pay
    [sampleCards addObject:@[@"6240888888888885", @"UnionPay"]];
    [sampleCards addObject:@[@"6240888888888885127", @"UnionPay"]];

    for (NSArray *cardInfo in sampleCards) {
        BTUIKCardType *card = [BTUIKCardType cardTypeForNumber:[cardInfo objectAtIndex:0]];
        XCTAssertEqualObjects([card brand], [cardInfo objectAtIndex:1]);
    }
}

@end
