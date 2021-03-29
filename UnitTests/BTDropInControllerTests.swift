import XCTest

class BTDropInControllerTests: XCTestCase {

    func testInitWithAuthorization_whenUICustomizationIsSet_configuresBTUIKAppearance() {
        let uiCustomization = BTDropInUICustomization(colorScheme: .light)
        uiCustomization.lineColor = UIColor.red
        uiCustomization.navigationBarTitleTextColor = UIColor.purple

        let request = BTDropInRequest()
        request.uiCustomization = uiCustomization

        _ = BTDropInController(authorization: "development_tokenization_key", request: request, handler: nil)

        XCTAssertEqual(BTUIKAppearance.sharedInstance()?.lineColor, UIColor.red)
        XCTAssertEqual(BTUIKAppearance.sharedInstance()?.navigationBarTitleTextColor, UIColor.purple)
    }

    func testInitWithAuthorization_whenUICustomizationIsNotSet_configuresBTUIKAppearanceWithDefaultUICustomization() {
        _ = BTDropInController(authorization: "development_tokenization_key", request: BTDropInRequest(), handler: nil)

        XCTAssertEqual(BTUIKAppearance.sharedInstance()?.formFieldBackgroundColor, UIColor.white)
        XCTAssertEqual(BTUIKAppearance.sharedInstance()?.primaryTextColor, UIColor.black)
        XCTAssertEqual(BTUIKAppearance.sharedInstance()?.keyboardAppearance, .light)
    }
}
