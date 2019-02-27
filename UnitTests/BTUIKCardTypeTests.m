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
    [sampleCards addObject:@[@"6764111111111116", @"Maestro"]];
    [sampleCards addObject:@[@"560000000003", @"Maestro"]];
    [sampleCards addObject:@[@"5600000000000000002", @"Maestro"]];
    [sampleCards addObject:@[@"570000000002", @"Maestro"]];
    [sampleCards addObject:@[@"5700000000000000018", @"Maestro"]];
    [sampleCards addObject:@[@"580000000001", @"Maestro"]];
    [sampleCards addObject:@[@"5800000000000000008", @"Maestro"]];
    [sampleCards addObject:@[@"590000000000", @"Maestro"]];
    [sampleCards addObject:@[@"5900000000000000006", @"Maestro"]];

    // Union Pay
    [sampleCards addObject:@[@"6240888888888885", @"UnionPay"]];
    [sampleCards addObject:@[@"6240888888888885127", @"UnionPay"]];

    // Hiper
    // Testing partial card number due to lack of complete test card numbers
    [sampleCards addObject:@[@"6370950000000005", @"Hiper"]];
    [sampleCards addObject:@[@"637568", @"Hiper"]];
    [sampleCards addObject:@[@"637599", @"Hiper"]];
    [sampleCards addObject:@[@"637609", @"Hiper"]];
    [sampleCards addObject:@[@"637612", @"Hiper"]];


    // Hipercard
    [sampleCards addObject:@[@"6062820524845321", @"Hipercard"]];

    for (NSArray *cardInfo in sampleCards) {
        NSString *cardNumber = [cardInfo objectAtIndex:0];
        NSString *cardBrand = [cardInfo objectAtIndex:1];
        BTUIKCardType *card = [BTUIKCardType cardTypeForNumber:cardNumber];
        XCTAssertEqualObjects([card brand], cardBrand);
        XCTAssertGreaterThanOrEqual((int)[[BTUIKCardType possibleCardTypesForNumber:cardNumber] count], 1);

        // Ensure that cards are found for short numbers
        BTUIKCardType *shortCard = [BTUIKCardType cardTypeForNumber:[cardNumber substringToIndex:6]];
        XCTAssertEqualObjects([shortCard brand], cardBrand);
        NSArray *possibleCardsUsingShortNumber = [BTUIKCardType possibleCardTypesForNumber:[cardNumber substringToIndex:4]];
        XCTAssertGreaterThanOrEqual((int)[possibleCardsUsingShortNumber count], 1);
    }
}

@end
