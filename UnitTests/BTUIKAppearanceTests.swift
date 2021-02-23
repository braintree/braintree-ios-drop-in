import XCTest

class BTUIKAppearanceTests: XCTestCase {

    func testNavigationTitleTextColor_defaultsToPrimaryTextColor_whenNotSet() {
        BTUIKAppearance.sharedInstance().primaryTextColor = UIColor.purple
        BTUIKAppearance.sharedInstance().navigationBarTitleTextColor = nil;
        XCTAssertEqual(BTUIKAppearance.sharedInstance().navigationBarTitleTextColor, BTUIKAppearance.sharedInstance().primaryTextColor);
    }

    func testNavigationTitleTextColor_returnsWhenSet() {
        BTUIKAppearance.sharedInstance().primaryTextColor = UIColor.yellow
        BTUIKAppearance.sharedInstance().navigationBarTitleTextColor = UIColor.brown
        XCTAssertEqual(BTUIKAppearance.sharedInstance().navigationBarTitleTextColor, UIColor.brown);
    }

    func testStyledNavigationTitleLabel_returnsLabelWithCorrectColor() {
        BTUIKAppearance.sharedInstance().primaryTextColor = UIColor.white
        BTUIKAppearance.sharedInstance().navigationBarTitleTextColor = UIColor.green
        XCTAssertEqual(BTUIKAppearance.styledNavigationTitleLabel().textColor, UIColor.green)
    }
}
