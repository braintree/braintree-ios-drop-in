import XCTest

class BTUIKAppearanceTests: XCTestCase {

    func testLightColorScheme() {
        let appearance = BTUIKAppearance.sharedInstance()
        appearance?.colorScheme = .light

        XCTAssertEqual(appearance?.overlayColor, UIColor.btuik_color(fromHex:"000000", alpha:0.5))
        XCTAssertEqual(appearance?.tintColor, UIColor.btuik_color(fromHex:"2489F6", alpha:1.0))
        XCTAssertEqual(appearance?.disabledColor, UIColor.lightGray)
        XCTAssertEqual(appearance?.errorForegroundColor, UIColor.btuik_color(fromHex:"ff3b30", alpha:1.0))
        XCTAssertEqual(appearance?.switchThumbTintColor, UIColor.white)
        XCTAssertEqual(appearance?.switchOnTintColor, UIColor.green)
        XCTAssertEqual(appearance?.font, UIFont.systemFont(ofSize:10))
        XCTAssertEqual(appearance?.boldFont, UIFont.boldSystemFont(ofSize:10))
        XCTAssertEqual(appearance?.useBlurs, true)
        XCTAssertEqual(appearance?.postalCodeFormFieldKeyboardType, .default)

        XCTAssertEqual(appearance?.barBackgroundColor, UIColor.white)
        XCTAssertEqual(appearance?.formBackgroundColor, UIColor.btuik_color(fromHex:"EFEFF4", alpha:1.0))
        XCTAssertEqual(appearance?.formFieldBackgroundColor,  UIColor.white)
        XCTAssertEqual(appearance?.primaryTextColor, UIColor.black)
        XCTAssertEqual(appearance?.secondaryTextColor, UIColor.btuik_color(fromHex:"666666", alpha:1.0))
        XCTAssertEqual(appearance?.placeholderTextColor, UIColor.lightGray)
        XCTAssertEqual(appearance?.lineColor, UIColor.btuik_color(fromHex:"BFBFBF", alpha:1.0))
        XCTAssertEqual(appearance?.blurStyle, .extraLight)
        XCTAssertEqual(appearance?.activityIndicatorViewStyle, .gray)
    }
    
    func testDarkColorScheme() {
        let appearance = BTUIKAppearance.sharedInstance()
        appearance?.colorScheme = .dark
        
        XCTAssertEqual(appearance?.overlayColor, UIColor.btuik_color(fromHex: "000000", alpha: 0.5))
        XCTAssertEqual(appearance?.tintColor, UIColor.btuik_color(fromHex: "2489F6", alpha:1.0))
        XCTAssertEqual(appearance?.disabledColor, UIColor.lightGray)
        XCTAssertEqual(appearance?.errorForegroundColor, UIColor.btuik_color(fromHex: "ff3b30", alpha:1.0))
        XCTAssertEqual(appearance?.switchThumbTintColor, UIColor.white)
        XCTAssertEqual(appearance?.switchOnTintColor, UIColor.green)
        XCTAssertEqual(appearance?.font, UIFont.systemFont(ofSize:10))
        XCTAssertEqual(appearance?.boldFont, UIFont.boldSystemFont(ofSize:10))
        XCTAssertEqual(appearance?.useBlurs, true)
        XCTAssertEqual(appearance?.postalCodeFormFieldKeyboardType, .default)

        XCTAssertEqual(appearance?.barBackgroundColor, UIColor.btuik_color(fromHex:"222222", alpha:1.0))
        XCTAssertEqual(appearance?.formBackgroundColor, UIColor.btuik_color(fromHex:"222222", alpha:1.0))
        XCTAssertEqual(appearance?.formFieldBackgroundColor, UIColor.btuik_color(fromHex:"333333", alpha:1.0))
        XCTAssertEqual(appearance?.primaryTextColor, UIColor.white)
        XCTAssertEqual(appearance?.secondaryTextColor, UIColor.btuik_color(fromHex:"999999", alpha:1.0))
        XCTAssertEqual(appearance?.placeholderTextColor, UIColor.btuik_color(fromHex:"8E8E8E", alpha:1.0))
        XCTAssertEqual(appearance?.lineColor, UIColor.btuik_color(fromHex:"666666", alpha:1.0))
        XCTAssertEqual(appearance?.blurStyle, .dark)
        XCTAssertEqual(appearance?.activityIndicatorViewStyle, .white)
    }
    
    func testDynamicColorScheme_whenSystemIsInLightMode() {
        if #available(iOS 13, *) {
            let appearance = BTUIKAppearance.sharedInstance()
            appearance?.colorScheme = .dynamic
            
            XCTAssertEqual(appearance?.overlayColor, UIColor.black.withAlphaComponent(0.5));
            XCTAssertEqual(appearance?.tintColor, UIColor.systemBlue);
            XCTAssertEqual(appearance?.disabledColor, UIColor.systemGray);
            XCTAssertEqual(appearance?.errorForegroundColor, UIColor.systemRed);
            XCTAssertEqual(appearance?.switchThumbTintColor, UIColor.white);
            XCTAssertEqual(appearance?.switchOnTintColor, UIColor.systemGreen);
            XCTAssertEqual(appearance?.font, UIFont.systemFont(ofSize:10));
            XCTAssertEqual(appearance?.boldFont, UIFont.boldSystemFont(ofSize:10));
            XCTAssertEqual(appearance?.useBlurs, true);
            XCTAssertEqual(appearance?.postalCodeFormFieldKeyboardType, .default);

            XCTAssertEqual(appearance?.barBackgroundColor, UIColor.systemBackground)
            XCTAssertEqual(appearance?.formBackgroundColor, UIColor.systemGroupedBackground);
            XCTAssertEqual(appearance?.formFieldBackgroundColor, UIColor.secondarySystemGroupedBackground);
            XCTAssertEqual(appearance?.primaryTextColor, UIColor.label);
            XCTAssertEqual(appearance?.secondaryTextColor, UIColor.secondaryLabel);
            XCTAssertEqual(appearance?.placeholderTextColor, UIColor.placeholderText);
            XCTAssertEqual(appearance?.lineColor, UIColor.separator);
            XCTAssertEqual(appearance?.blurStyle, .systemMaterial);
            XCTAssertEqual(appearance?.activityIndicatorViewStyle, .medium);
        }
    }
    
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
        XCTAssertEqual(BTUIKAppearance.styledNavigationTitleLabel().textColor, UIColor.green);
    }

    func testSettingFontFamily_returnsCorrectFont() {
        BTUIKAppearance.sharedInstance().fontFamily = "Verdana";
        XCTAssertEqual(BTUIKAppearance.sharedInstance().font.fontName, "Verdana");
    }

    func testSettingBoldFontFamily_returnsCorrectBoldFont() {
        BTUIKAppearance.sharedInstance().boldFontFamily = "Courier-Bold";
        XCTAssertEqual(BTUIKAppearance.sharedInstance().boldFont.fontName, "Courier-Bold");
    }

    func testDefaultFontFamily_returnsSystemFont() {
        XCTAssertEqual(BTUIKAppearance.sharedInstance().font, UIFont.systemFont(ofSize:10.0));
    }

    func testDefaultBoldFontFamily_returnsBoldSystemFont() {
        XCTAssertEqual(BTUIKAppearance.sharedInstance().boldFont, UIFont.boldSystemFont(ofSize:10.0));
    }
}
