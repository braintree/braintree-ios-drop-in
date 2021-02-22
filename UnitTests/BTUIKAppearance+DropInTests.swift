import XCTest

class BTUIKAppearance_DropInTests: XCTestCase {

    func testConfigure_withLightColorScheme() {
        let uiCustomization = BTDropInUICustomization(colorScheme: .light)
        let appearance = BTUIKAppearance.sharedInstance()
        appearance?.configure(with: uiCustomization)

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

    func testConfigure_withDarkColorScheme() {
        let uiCustomization = BTDropInUICustomization(colorScheme: .dark)
        let appearance = BTUIKAppearance.sharedInstance()
        appearance?.configure(with: uiCustomization)

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

    func testConfigure_withDynamicColorScheme_whenSystemIsInLightMode() {
        if #available(iOS 13, *) {
            let uiCustomization = BTDropInUICustomization(colorScheme: .dynamic)
            let appearance = BTUIKAppearance.sharedInstance()
            appearance?.configure(with: uiCustomization)

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

    func testConfigure_allowsOverridingAllProperties() {
        let uiCustomization = BTDropInUICustomization(colorScheme: .dark)
        uiCustomization.overlayColor = UIColor.purple
        uiCustomization.tintColor = UIColor.purple
        uiCustomization.disabledColor = UIColor.purple
        uiCustomization.errorForegroundColor = UIColor.purple
        uiCustomization.switchThumbTintColor = UIColor.purple
        uiCustomization.switchOnTintColor = UIColor.purple
        uiCustomization.fontFamily = "Helvetica"
        uiCustomization.boldFontFamily = "Helvetica-Bold"
        uiCustomization.useBlurs = false
        uiCustomization.postalCodeFormFieldKeyboardType = .decimalPad

        uiCustomization.barBackgroundColor = UIColor.purple
        uiCustomization.formBackgroundColor = UIColor.purple
        uiCustomization.formFieldBackgroundColor = UIColor.purple
        uiCustomization.primaryTextColor = UIColor.purple
        uiCustomization.secondaryTextColor = UIColor.purple
        uiCustomization.placeholderTextColor = UIColor.purple
        uiCustomization.lineColor = UIColor.purple
        uiCustomization.blurStyle = .light
        uiCustomization.activityIndicatorViewStyle = .gray

        let appearance = BTUIKAppearance.sharedInstance()
        appearance?.configure(with: uiCustomization)

        XCTAssertEqual(appearance?.overlayColor, UIColor.purple)
        XCTAssertEqual(appearance?.tintColor, UIColor.purple)
        XCTAssertEqual(appearance?.disabledColor, UIColor.purple)
        XCTAssertEqual(appearance?.errorForegroundColor, UIColor.purple)
        XCTAssertEqual(appearance?.switchThumbTintColor, UIColor.purple)
        XCTAssertEqual(appearance?.switchOnTintColor, UIColor.purple)
        XCTAssertNotNil(appearance?.font)
        XCTAssertEqual(appearance?.font, UIFont(name: "Helvetica", size: 10))
        XCTAssertNotNil(appearance?.boldFont)
        XCTAssertEqual(appearance?.boldFont, UIFont(name: "Helvetica-Bold", size: 10))
        XCTAssertEqual(appearance?.useBlurs, false)
        XCTAssertEqual(appearance?.postalCodeFormFieldKeyboardType, .decimalPad)

        XCTAssertEqual(appearance?.barBackgroundColor, UIColor.purple)
        XCTAssertEqual(appearance?.formBackgroundColor, UIColor.purple)
        XCTAssertEqual(appearance?.formFieldBackgroundColor, UIColor.purple)
        XCTAssertEqual(appearance?.primaryTextColor, UIColor.purple)
        XCTAssertEqual(appearance?.secondaryTextColor, UIColor.purple)
        XCTAssertEqual(appearance?.placeholderTextColor, UIColor.purple)
        XCTAssertEqual(appearance?.lineColor, UIColor.purple)
        XCTAssertEqual(appearance?.blurStyle, .light)
        XCTAssertEqual(appearance?.activityIndicatorViewStyle, .gray)
    }
}
