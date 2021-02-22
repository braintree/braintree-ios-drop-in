import XCTest

class BTUIKAppearance_DropInTests: XCTestCase {

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
        XCTAssertEqual(appearance?.navigationBarTitleTextColor, UIColor.green)
        XCTAssertEqual(appearance?.secondaryTextColor, UIColor.purple)
        XCTAssertEqual(appearance?.placeholderTextColor, UIColor.purple)
        XCTAssertEqual(appearance?.lineColor, UIColor.purple)
        XCTAssertEqual(appearance?.blurStyle, .light)
        XCTAssertEqual(appearance?.activityIndicatorViewStyle, .gray)
    }
}
