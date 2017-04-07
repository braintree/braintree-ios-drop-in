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

@end
