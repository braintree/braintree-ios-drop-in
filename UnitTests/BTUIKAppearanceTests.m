#import <XCTest/XCTest.h>

#import "BTUIKAppearance.h"

@interface BTUIKAppearanceTests : XCTestCase

@end

@implementation BTUIKAppearanceTests

- (void)test_navigationTitleTextColor_defaultsToPrimaryTextColor_whenNotSet {
    [BTUIKAppearance sharedInstance].primaryTextColor = [UIColor purpleColor];
    [BTUIKAppearance sharedInstance].navigationBarTitleTextColor = nil;
    XCTAssertEqual([BTUIKAppearance sharedInstance].navigationBarTitleTextColor, [BTUIKAppearance sharedInstance].primaryTextColor);
}

- (void)test_navigationTitleTextColor_returnsWhenSet {
    [BTUIKAppearance sharedInstance].primaryTextColor = [UIColor yellowColor];
    [BTUIKAppearance sharedInstance].navigationBarTitleTextColor = [UIColor brownColor];
    XCTAssertEqual([BTUIKAppearance sharedInstance].navigationBarTitleTextColor, [UIColor brownColor]);
}

- (void)test_styledNavigationTitleLabel_returnsLabelWithCorrectColor {
    [BTUIKAppearance sharedInstance].primaryTextColor = [UIColor whiteColor];
    [BTUIKAppearance sharedInstance].navigationBarTitleTextColor = [UIColor greenColor];
    XCTAssertEqual([BTUIKAppearance styledNavigationTitleLabel].textColor, [UIColor greenColor]);
}

- (void)test_settingFontFamily_returnsCorrectFont {
    [BTUIKAppearance sharedInstance].fontFamily = @"Verdana";
    XCTAssert([[BTUIKAppearance sharedInstance].font.fontName isEqualToString:@"Verdana"]);
}

- (void)test_settingBoldFontFamily_returnsCorrectBoldFont {
    [BTUIKAppearance sharedInstance].boldFontFamily = @"Courier-Bold";
    XCTAssert([[BTUIKAppearance sharedInstance].boldFont.fontName isEqualToString:@"Courier-Bold"]);
}

- (void)test_defaultFontFamily_returnsSystemFont {
    XCTAssertEqual([BTUIKAppearance sharedInstance].font, [UIFont systemFontOfSize:10.0]);
}

- (void)test_defaultBoldFontFamily_returnsBoldSystemFont {
    XCTAssertEqual([BTUIKAppearance sharedInstance].boldFont, [UIFont boldSystemFontOfSize:10.0]);
}

@end
