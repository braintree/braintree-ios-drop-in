/*
 IMPORTANT
 Hardware keyboard should be disabled on simulator for tests to run reliably.
 */

import XCTest

class BraintreeDropIn_EditMode_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-CreateVaultedPaymentMethod")
        app.launchArguments.append("-ClientToken")
        app.launch()
        sleep(1)
        self.waitForElementToBeHittable(app.buttons["Change Payment Method"])
        app.buttons["Change Payment Method"].tap()
    }

    func testDropIn_canDisplay_editScreen() {
        self.waitForElementToBeHittable(app.buttons["Edit"])
        app.buttons["Edit"].forceTapElement()

        self.waitForElementToAppear(app.staticTexts["Edit Payment Methods"])
    }

    func testDropIn_editScreen_returnsToPaymentSelection() {
        self.waitForElementToBeHittable(app.buttons["Edit"])
        app.buttons["Edit"].forceTapElement()

        self.waitForElementToBeHittable(app.buttons["Done"])
        app.buttons["Done"].forceTapElement()

        self.waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        self.waitForElementToAppear(app.staticTexts["Select Payment Method"])
    }
}

class BraintreeDropIn_EditMode_Disabled_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-CreateVaultedPaymentMethod")
        app.launchArguments.append("-DisableEditMode")
        app.launchArguments.append("-ClientToken")
        app.launch()
        sleep(1)
        self.waitForElementToBeHittable(app.buttons["Change Payment Method"])
        app.buttons["Change Payment Method"].tap()
    }

    func testDropIn_doesNotDisplay_editScreen() {
        self.waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])

        XCTAssertFalse(app.buttons["Edit"].exists)
    }
}
