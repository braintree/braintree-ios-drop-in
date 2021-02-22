import XCTest

class BTDropInUICustomizationTests: XCTestCase {

    func testInit_withLightColorScheme() {
        let uiCustomization = BTDropInUICustomization(colorScheme: .light)

        XCTAssertEqual(uiCustomization.useBlurs, true)
        XCTAssertEqual(uiCustomization.postalCodeFormFieldKeyboardType, .default)

        XCTAssertEqual(uiCustomization.barBackgroundColor, UIColor.white)
        XCTAssertEqual(uiCustomization.formBackgroundColor, UIColor.btuik_color(fromHex:"EFEFF4", alpha:1.0))
        XCTAssertEqual(uiCustomization.formFieldBackgroundColor,  UIColor.white)
        XCTAssertEqual(uiCustomization.primaryTextColor, UIColor.black)
        XCTAssertEqual(uiCustomization.secondaryTextColor, UIColor.btuik_color(fromHex:"666666", alpha:1.0))
        XCTAssertEqual(uiCustomization.placeholderTextColor, UIColor.lightGray)
        XCTAssertEqual(uiCustomization.lineColor, UIColor.btuik_color(fromHex:"BFBFBF", alpha:1.0))
        XCTAssertEqual(uiCustomization.blurStyle, .extraLight)
        XCTAssertEqual(uiCustomization.activityIndicatorViewStyle, .gray)

        XCTAssertEqual(uiCustomization.overlayColor, UIColor.btuik_color(fromHex:"000000", alpha:0.5))
        XCTAssertEqual(uiCustomization.tintColor, UIColor.btuik_color(fromHex:"2489F6", alpha:1.0))
        XCTAssertEqual(uiCustomization.disabledColor, UIColor.lightGray)
        XCTAssertEqual(uiCustomization.errorForegroundColor, UIColor.btuik_color(fromHex:"ff3b30", alpha:1.0))
        XCTAssertEqual(uiCustomization.switchThumbTintColor, UIColor.white)
        XCTAssertEqual(uiCustomization.switchOnTintColor, UIColor.green)
        XCTAssertEqual(uiCustomization.keyboardAppearance, .light)

        XCTAssertNil(uiCustomization.fontFamily)
        XCTAssertNil(uiCustomization.boldFontFamily)
        XCTAssertNil(uiCustomization.navigationBarTitleTextColor)
    }

    func testInit_withDarkColorScheme() {
        let uiCustomization = BTDropInUICustomization(colorScheme: .dark)

        XCTAssertEqual(uiCustomization.useBlurs, true)
        XCTAssertEqual(uiCustomization.postalCodeFormFieldKeyboardType, .default)

        XCTAssertEqual(uiCustomization.barBackgroundColor, UIColor.btuik_color(fromHex:"222222", alpha:1.0))
        XCTAssertEqual(uiCustomization.formBackgroundColor, UIColor.btuik_color(fromHex:"222222", alpha:1.0))
        XCTAssertEqual(uiCustomization.formFieldBackgroundColor, UIColor.btuik_color(fromHex:"333333", alpha:1.0))
        XCTAssertEqual(uiCustomization.primaryTextColor, UIColor.white)
        XCTAssertEqual(uiCustomization.secondaryTextColor, UIColor.btuik_color(fromHex:"999999", alpha:1.0))
        XCTAssertEqual(uiCustomization.placeholderTextColor, UIColor.btuik_color(fromHex:"8E8E8E", alpha:1.0))
        XCTAssertEqual(uiCustomization.lineColor, UIColor.btuik_color(fromHex:"666666", alpha:1.0))
        XCTAssertEqual(uiCustomization.blurStyle, .dark)
        XCTAssertEqual(uiCustomization.activityIndicatorViewStyle, .white)

        XCTAssertEqual(uiCustomization.overlayColor, UIColor.btuik_color(fromHex: "000000", alpha: 0.5))
        XCTAssertEqual(uiCustomization.tintColor, UIColor.btuik_color(fromHex: "2489F6", alpha:1.0))
        XCTAssertEqual(uiCustomization.disabledColor, UIColor.lightGray)
        XCTAssertEqual(uiCustomization.errorForegroundColor, UIColor.btuik_color(fromHex: "ff3b30", alpha:1.0))
        XCTAssertEqual(uiCustomization.switchThumbTintColor, UIColor.white)
        XCTAssertEqual(uiCustomization.switchOnTintColor, UIColor.green)

        XCTAssertNil(uiCustomization.fontFamily)
        XCTAssertNil(uiCustomization.boldFontFamily)
        XCTAssertNil(uiCustomization.navigationBarTitleTextColor)
    }

    func testInit_withDynamicColorScheme_whenSystemIsInLightMode() {
        if #available(iOS 13, *) {
            let uiCustomization = BTDropInUICustomization(colorScheme: .dynamic)
            let appearance = BTUIKAppearance.sharedInstance()
            appearance?.configure(with: uiCustomization)

            XCTAssertEqual(appearance?.useBlurs, true)
            XCTAssertEqual(appearance?.postalCodeFormFieldKeyboardType, .default);

            XCTAssertEqual(appearance?.barBackgroundColor, UIColor.systemBackground)
            XCTAssertEqual(appearance?.formBackgroundColor, UIColor.systemGroupedBackground)
            XCTAssertEqual(appearance?.formFieldBackgroundColor, UIColor.secondarySystemGroupedBackground)
            XCTAssertEqual(appearance?.primaryTextColor, UIColor.label)
            XCTAssertEqual(appearance?.secondaryTextColor, UIColor.secondaryLabel)
            XCTAssertEqual(appearance?.placeholderTextColor, UIColor.placeholderText)
            XCTAssertEqual(appearance?.lineColor, UIColor.separator)
            XCTAssertEqual(appearance?.blurStyle, .systemMaterial)
            XCTAssertEqual(appearance?.activityIndicatorViewStyle, .medium)

            XCTAssertEqual(appearance?.overlayColor, UIColor.black.withAlphaComponent(0.5))
            XCTAssertEqual(appearance?.tintColor, UIColor.systemBlue)
            XCTAssertEqual(appearance?.disabledColor, UIColor.systemGray)
            XCTAssertEqual(appearance?.errorForegroundColor, UIColor.systemRed)
            XCTAssertEqual(appearance?.switchThumbTintColor, UIColor.white)
            XCTAssertEqual(appearance?.switchOnTintColor, UIColor.systemGreen)

            XCTAssertNil(uiCustomization.fontFamily)
            XCTAssertNil(uiCustomization.boldFontFamily)
            XCTAssertNil(uiCustomization.navigationBarTitleTextColor)
        }
    }
}
