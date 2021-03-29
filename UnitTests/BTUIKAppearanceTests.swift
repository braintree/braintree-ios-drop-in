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

    func testConfigure_setsAllProperties() {
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
        uiCustomization.navigationBarTitleTextColor = UIColor.green
        uiCustomization.secondaryTextColor = UIColor.purple
        uiCustomization.placeholderTextColor = UIColor.purple
        uiCustomization.lineColor = UIColor.purple
        uiCustomization.blurStyle = .light
        uiCustomization.activityIndicatorViewStyle = .gray

        uiCustomization.disableDynamicType = true

        let appearance = BTUIKAppearance.sharedInstance()
        appearance?.configure(with: uiCustomization)

        XCTAssertEqual(appearance?.overlayColor, UIColor.purple)
        XCTAssertEqual(appearance?.tintColor, UIColor.purple)
        XCTAssertEqual(appearance?.disabledColor, UIColor.purple)
        XCTAssertEqual(appearance?.errorForegroundColor, UIColor.purple)
        XCTAssertEqual(appearance?.switchThumbTintColor, UIColor.purple)
        XCTAssertEqual(appearance?.switchOnTintColor, UIColor.purple)
        XCTAssertNotNil(appearance?.bodyFont)
        XCTAssertEqual(appearance?.bodyFont, UIFont(name: "Helvetica", size: UIFont.labelFontSize))
        XCTAssertNotNil(appearance?.headlineFont)
        XCTAssertEqual(appearance?.headlineFont, UIFont(name: "Helvetica-Bold", size: UIFont.labelFontSize))
        XCTAssertEqual(appearance?.useBlurs, false)
        XCTAssertEqual(appearance?.postalCodeFormFieldKeyboardType, .decimalPad)

        XCTAssertEqual(appearance?.barBackgroundColor, UIColor.purple)
        XCTAssertEqual(appearance?.formBackgroundColor, UIColor.purple)
        XCTAssertEqual(appearance?.formFieldBackgroundColor, UIColor.purple)
        XCTAssertEqual(appearance?.primaryTextColor, UIColor.purple)
        XCTAssertEqual(appearance?.navigationBarTitleTextColor, UIColor.green)
        XCTAssertEqual(appearance?.secondaryTextColor, UIColor.purple)
        XCTAssertEqual(appearance?.placeholderTextColor, UIColor.purple)
        XCTAssertEqual(appearance?.lineColor, UIColor.purple)
        XCTAssertEqual(appearance?.blurStyle, .light)
        XCTAssertEqual(appearance?.activityIndicatorViewStyle, .gray)
    }

    func testConfigure_withCustomFonts_andDynamicTypeDisabled_setsFonts() {
        let uiCustomization = BTDropInUICustomization(colorScheme: .light)
        uiCustomization.fontFamily = "Helvetica"
        uiCustomization.boldFontFamily = "Helvetica-Bold"
        uiCustomization.disableDynamicType = true

        let appearance = BTUIKAppearance.sharedInstance()
        appearance?.configure(with: uiCustomization)

        XCTAssertEqual(appearance?.bodyFont, UIFont(name: "Helvetica", size: UIFont.labelFontSize))
        XCTAssertEqual(appearance?.staticBodyFont, UIFont(name: "Helvetica", size: UIFont.labelFontSize))
        XCTAssertEqual(appearance?.headlineFont, UIFont(name: "Helvetica-Bold", size: UIFont.labelFontSize))
        XCTAssertEqual(appearance?.staticHeadlineFont, UIFont(name: "Helvetica-Bold", size: UIFont.labelFontSize))
        XCTAssertEqual(appearance?.captionFont, UIFont(name: "Helvetica", size: UIFont.smallSystemFontSize))
        XCTAssertEqual(appearance?.staticCaptionFont, UIFont(name: "Helvetica", size: UIFont.smallSystemFontSize))
        XCTAssertEqual(appearance?.staticTitleFont, UIFont(name: "Helvetica", size: 24))
    }

    func testConfigure_withCustomFonts_andDynamicTypeEnabled_setsFonts() {
        let uiCustomization = BTDropInUICustomization(colorScheme: .light)
        uiCustomization.fontFamily = "Helvetica"
        uiCustomization.boldFontFamily = "Helvetica-Bold"

        let appearance = BTUIKAppearance.sharedInstance()
        appearance?.configure(with: uiCustomization)

        XCTAssertEqual(appearance?.bodyFont, UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: "Helvetica", size: UIFont.labelFontSize)!))
        XCTAssertEqual(appearance?.staticBodyFont, UIFont(name: "Helvetica", size: UIFont.labelFontSize))
        XCTAssertEqual(appearance?.headlineFont, UIFontMetrics(forTextStyle: .headline).scaledFont(for: UIFont(name: "Helvetica-Bold", size: UIFont.labelFontSize)!))
        XCTAssertEqual(appearance?.staticHeadlineFont, UIFont(name: "Helvetica-Bold", size: UIFont.labelFontSize))
        XCTAssertEqual(appearance?.captionFont, UIFontMetrics(forTextStyle: .caption1).scaledFont(for: UIFont(name: "Helvetica", size: UIFont.smallSystemFontSize)!))
        XCTAssertEqual(appearance?.staticCaptionFont, UIFont(name: "Helvetica", size: UIFont.smallSystemFontSize))
        XCTAssertEqual(appearance?.staticTitleFont, UIFont(name: "Helvetica", size: 24))
    }

    func testConfigure_withoutCustomFonts_andDynamicTypeDisabled_setsFonts() {
        let uiCustomization = BTDropInUICustomization(colorScheme: .light)
        uiCustomization.disableDynamicType = true

        let appearance = BTUIKAppearance.sharedInstance()
        appearance?.configure(with: uiCustomization)

        XCTAssertEqual(appearance?.bodyFont, UIFont.systemFont(ofSize: UIFont.labelFontSize))
        XCTAssertEqual(appearance?.staticBodyFont, UIFont.systemFont(ofSize: UIFont.labelFontSize))
        XCTAssertEqual(appearance?.headlineFont, UIFont.boldSystemFont(ofSize: UIFont.labelFontSize))
        XCTAssertEqual(appearance?.staticHeadlineFont, UIFont.boldSystemFont(ofSize: UIFont.labelFontSize))
        XCTAssertEqual(appearance?.captionFont, UIFont.systemFont(ofSize: UIFont.smallSystemFontSize))
        XCTAssertEqual(appearance?.staticCaptionFont, UIFont.systemFont(ofSize: UIFont.smallSystemFontSize))
        XCTAssertEqual(appearance?.staticTitleFont, UIFont.systemFont(ofSize: 24))
    }

    func testConfigure_withoutCustomFonts_andDynamicTypeEnabled_setsFonts() {
        let uiCustomization = BTDropInUICustomization(colorScheme: .light)

        let appearance = BTUIKAppearance.sharedInstance()
        appearance?.configure(with: uiCustomization)

        XCTAssertEqual(appearance?.bodyFont, UIFont.preferredFont(forTextStyle: .body))
        XCTAssertEqual(appearance?.staticBodyFont, UIFont.systemFont(ofSize: UIFont.labelFontSize))
        XCTAssertEqual(appearance?.headlineFont, UIFont.preferredFont(forTextStyle: .headline))
        XCTAssertEqual(appearance?.staticHeadlineFont, UIFont.boldSystemFont(ofSize: UIFont.labelFontSize))
        XCTAssertEqual(appearance?.captionFont, UIFont.preferredFont(forTextStyle: .caption1))
        XCTAssertEqual(appearance?.staticCaptionFont, UIFont.systemFont(ofSize: UIFont.smallSystemFontSize))
        XCTAssertEqual(appearance?.staticTitleFont, UIFont.systemFont(ofSize: 24))
    }
}
