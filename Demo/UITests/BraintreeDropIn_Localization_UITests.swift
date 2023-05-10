import XCTest

class BraintreeDropIn_Localization_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
    }

    func testDropIn_displaysSupportedLocalization() {
        app.launchArguments += ["-AppleLanguages", "(es)"]
        app.launch()
        sleep(1)
        waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()

        expectation(for: NSPredicate(format: "exists == true"), evaluatedWith: app.staticTexts["Seleccionar forma de pago"])
        waitForExpectations(timeout: 20)
    }

    func testDropIn_displaysCustomLocalization() {
        app.launchArguments += ["-AppleLanguages", "(cs)"]
        app.launch()
        sleep(1)
        waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()

        expectation(for: NSPredicate(format: "exists == true"), evaluatedWith: app.staticTexts["Zvolte platební metodu"])
        waitForExpectations(timeout: 20)
    }
}
