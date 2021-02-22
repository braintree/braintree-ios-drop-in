import XCTest

class BTDropInControllerTests: XCTestCase {

    func testInitWithAuthorization_whenUICustomizationIsSet_configuresBTUIKAppearance() {
        let uiCustomization = BTDropInUICustomization(colorScheme: .light)
        uiCustomization.lineColor = UIColor.systemRed

        let request = BTDropInRequest()
        request.uiCustomization = uiCustomization

        _ = BTDropInController(authorization: "development_tokenization_key", request: request, handler: nil)

        XCTAssertEqual(BTUIKAppearance.sharedInstance()?.lineColor, UIColor.systemRed)
    }

    func testInitWithAuthorization_when_UICustomizationIsNotSet_configuresBTUIKAppearanceWithDefaults() {
        _ = BTDropInController(authorization: "development_tokenization_key", request: BTDropInRequest(), handler: nil)

        XCTAssertEqual(BTUIKAppearance.sharedInstance()?.formFieldBackgroundColor, UIColor.white)
    }
}
