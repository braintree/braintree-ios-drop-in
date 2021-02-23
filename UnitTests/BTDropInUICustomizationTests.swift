import XCTest

class BTDropInUICustomizationTests: XCTestCase {

    func testInit_withLightColorScheme() {
        let uiCustomization = BTDropInUICustomization(colorScheme: .light)

        XCTAssertTrue(uiCustomization.useBlurs)
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
        XCTAssertFalse(uiCustomization.disableDynamicType)
    }

    func testInit_withDarkColorScheme() {
        let uiCustomization = BTDropInUICustomization(colorScheme: .dark)

        XCTAssertTrue(uiCustomization.useBlurs)
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
        XCTAssertFalse(uiCustomization.disableDynamicType)
    }

    func testInit_withDynamicColorScheme_whenSystemIsInLightMode() {
        if #available(iOS 13, *) {
            let uiCustomization = BTDropInUICustomization(colorScheme: .dynamic)

            XCTAssertTrue(uiCustomization.useBlurs)
            XCTAssertEqual(uiCustomization.postalCodeFormFieldKeyboardType, .default);

            XCTAssertEqual(uiCustomization.barBackgroundColor, UIColor.systemBackground)
            XCTAssertEqual(uiCustomization.formBackgroundColor, UIColor.systemGroupedBackground)
            XCTAssertEqual(uiCustomization.formFieldBackgroundColor, UIColor.secondarySystemGroupedBackground)
            XCTAssertEqual(uiCustomization.primaryTextColor, UIColor.label)
            XCTAssertEqual(uiCustomization.secondaryTextColor, UIColor.secondaryLabel)
            XCTAssertEqual(uiCustomization.placeholderTextColor, UIColor.placeholderText)
            XCTAssertEqual(uiCustomization.lineColor, UIColor.separator)
            XCTAssertEqual(uiCustomization.blurStyle, .systemMaterial)
            XCTAssertEqual(uiCustomization.activityIndicatorViewStyle, .medium)

            XCTAssertEqual(uiCustomization.overlayColor, UIColor.black.withAlphaComponent(0.5))
            XCTAssertEqual(uiCustomization.tintColor, UIColor.systemBlue)
            XCTAssertEqual(uiCustomization.disabledColor, UIColor.systemGray)
            XCTAssertEqual(uiCustomization.errorForegroundColor, UIColor.systemRed)
            XCTAssertEqual(uiCustomization.switchThumbTintColor, UIColor.white)
            XCTAssertEqual(uiCustomization.switchOnTintColor, UIColor.systemGreen)

            XCTAssertNil(uiCustomization.fontFamily)
            XCTAssertNil(uiCustomization.boldFontFamily)
            XCTAssertNil(uiCustomization.navigationBarTitleTextColor)
            XCTAssertFalse(uiCustomization.disableDynamicType)
        }
    }

    func testCustomFonts_withDynamicTypeDisabled() {
        let uiCustomization = BTDropInUICustomization(colorScheme: .light)
        uiCustomization.fontFamily = "Helvetica"
        uiCustomization.boldFontFamily = "Helvetica-Bold"
        uiCustomization.disableDynamicType = true

        XCTAssertEqual(uiCustomization.bodyFont, UIFont(name: "Helvetica", size: UIFont.labelFontSize))
        XCTAssertEqual(uiCustomization.headlineFont, UIFont(name: "Helvetica-Bold", size: UIFont.labelFontSize))
        XCTAssertEqual(uiCustomization.subheadlineFont, UIFont(name: "Helvetica", size: UIFont.systemFontSize))
        XCTAssertEqual(uiCustomization.captionFont, UIFont(name: "Helvetica", size: UIFont.smallSystemFontSize))
        XCTAssertEqual(uiCustomization.staticTitleFont, UIFont(name: "Helvetica", size: 24))
    }

    func testCustomFonts_withDynamicTypeEnabled() {
        let uiCustomization = BTDropInUICustomization(colorScheme: .light)
        uiCustomization.fontFamily = "Helvetica"
        uiCustomization.boldFontFamily = "Helvetica-Bold"

        XCTAssertEqual(uiCustomization.bodyFont, UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: "Helvetica", size: UIFont.labelFontSize)!))
        XCTAssertEqual(uiCustomization.headlineFont, UIFontMetrics(forTextStyle: .headline).scaledFont(for: UIFont(name: "Helvetica-Bold", size: UIFont.labelFontSize)!))
        XCTAssertEqual(uiCustomization.subheadlineFont, UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: UIFont(name: "Helvetica", size: UIFont.systemFontSize)!))
        XCTAssertEqual(uiCustomization.captionFont, UIFontMetrics(forTextStyle: .caption1).scaledFont(for: UIFont(name: "Helvetica", size: UIFont.smallSystemFontSize)!))
        XCTAssertEqual(uiCustomization.staticTitleFont, UIFontMetrics(forTextStyle: .title2).scaledFont(for: UIFont(name: "Helvetica", size: 24)!))
    }

    func testSystemFonts_withDynamicTypeDisabled() {
        let uiCustomization = BTDropInUICustomization(colorScheme: .light)
        uiCustomization.disableDynamicType = true

        XCTAssertEqual(uiCustomization.bodyFont, UIFont.systemFont(ofSize: UIFont.labelFontSize))
        XCTAssertEqual(uiCustomization.headlineFont, UIFont.boldSystemFont(ofSize: UIFont.labelFontSize))
        XCTAssertEqual(uiCustomization.subheadlineFont, UIFont.systemFont(ofSize: UIFont.systemFontSize))
        XCTAssertEqual(uiCustomization.captionFont, UIFont.systemFont(ofSize: UIFont.smallSystemFontSize))
        XCTAssertEqual(uiCustomization.staticTitleFont, UIFont.systemFont(ofSize: 24))
    }

    func testSystemFonts_withDynamicTypeEnabled() {
        let uiCustomization = BTDropInUICustomization(colorScheme: .light)

        XCTAssertEqual(uiCustomization.bodyFont, UIFont.preferredFont(forTextStyle: .body))
        XCTAssertEqual(uiCustomization.headlineFont, UIFont.preferredFont(forTextStyle: .headline))
        XCTAssertEqual(uiCustomization.subheadlineFont, UIFont.preferredFont(forTextStyle: .subheadline))
        XCTAssertEqual(uiCustomization.captionFont, UIFont.preferredFont(forTextStyle: .caption1))
        XCTAssertEqual(uiCustomization.staticTitleFont, UIFont.preferredFont(forTextStyle: .title2))
    }
}
