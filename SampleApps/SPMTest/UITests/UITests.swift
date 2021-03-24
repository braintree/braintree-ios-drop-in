import XCTest

class UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments += ["-AppleLanguages", "(es)"]
        app.launch()
    }

    func testDisplaysLocalizedText() throws {
        app.buttons["Launch Drop-in"].tap()
        expectation(for: NSPredicate(format: "exists == true"), evaluatedWith: app.staticTexts["Seleccionar forma de pago"])
        waitForExpectations(timeout: 10.0)
    }
}
