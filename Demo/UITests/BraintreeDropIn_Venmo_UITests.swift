import XCTest

class Venmo_UITests: XCTestCase {

    var demoApp: XCUIApplication!
    var mockVenmo: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        mockVenmo = XCUIApplication(bundleIdentifier: "com.braintreepayments.MockVenmo")
        mockVenmo.activate()

        demoApp = XCUIApplication(bundleIdentifier: "com.braintreepayments.DropInDemo")
        demoApp.launchArguments.append("-EnvironmentSandbox")
        demoApp.launchArguments.append("-TokenizationKey")
        demoApp.launch()

        waitForElementToAppear(demoApp.buttons["Add Payment Method"])
        demoApp.buttons["Add Payment Method"].tap()
    }

    func testTokenizeVenmo_whenAuthorizationSuccessful_returnsNonce() {
        waitForElementToBeHittable(demoApp.staticTexts["Venmo"])
        demoApp.staticTexts["Venmo"].tap()

        waitForElementToAppear(mockVenmo.buttons["SUCCESS"])
        mockVenmo.buttons["SUCCESS"].tap()

        waitForElementToAppear(demoApp.staticTexts["@fake-venmo-username"])
    }

    func testTokenizeVenmo_whenErrorOccurs_returnsError() {
        waitForElementToBeHittable(demoApp.staticTexts["Venmo"])
        demoApp.staticTexts["Venmo"].tap()

        waitForElementToAppear(mockVenmo.buttons["ERROR"])
        mockVenmo.buttons["ERROR"].tap()

        waitForElementToAppear(demoApp.staticTexts["Add Payment Method"])
    }

    func testTokenizeVenmo_whenUserCancels_returnsCancel() {
        waitForElementToBeHittable(demoApp.staticTexts["Venmo"])
        demoApp.staticTexts["Venmo"].tap()

        waitForElementToAppear(mockVenmo.buttons["Cancel"])
        mockVenmo.buttons["Cancel"].tap()

        waitForElementToAppear(demoApp.staticTexts["Add Payment Method"])
    }
}

