/*
 IMPORTANT
 Hardware keyboard should be disabled on simulator for tests to run reliably.
 */

import XCTest

class BraintreeDropIn_TokenizationKey_CardForm_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-TokenizationKey")
        app.launchArguments.append("-ThreeDSecureDefault")
        app.launch()
        sleep(1)
        waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }

    func testDropIn_dismissesWhenCanceled() {
        waitForElementToBeHittable(app.buttons["Cancel"])
        app.buttons["Cancel"].forceTapElement()
        XCTAssertTrue(app.buttons["Canceled 🎲"].exists)
    }

    func testDropIn_displaysPaymentOptions_applePay_card_payPal() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        sleep(1)
        XCTAssertTrue(app.staticTexts["Credit or Debit Card"].exists)
        XCTAssertTrue(app.staticTexts["PayPal"].exists)
        XCTAssertTrue(app.staticTexts["Apple Pay"].exists)
    }

    func testDropIn_cardInput_receivesNonce() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()

        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]

        waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")

        let expirationDateTextField = elementsQuery.textFields["Expiration Date"]
        waitForElementToBeHittable(expirationDateTextField)
        expirationDateTextField.forceTapElement()
        expirationDateTextField.typeText("11/\(Date.nextYear)")

        let securityCodeField = elementsQuery.textFields["CVV"]
        waitForElementToBeHittable(securityCodeField)
        securityCodeField.forceTapElement()
        securityCodeField.typeText("123")

        let postalCodeField = elementsQuery.textFields["12345"]
        waitForElementToBeHittable(postalCodeField)
        postalCodeField.forceTapElement()
        postalCodeField.typeText("12345")

        app.buttons["Add Card"].forceTapElement()

        waitForElementToAppear(app.staticTexts["1111"])

        XCTAssertTrue(app.staticTexts["1111"].exists)
    }

    func testDropIn_cardInput_showsInvalidState_withInvalidCardNumber() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()

        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]

        waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4141414141414141")

        waitForElementToAppear(elementsQuery.staticTexts["You must provide a valid Card Number."])
    }

    func testDropIn_cardInput_hidesInvalidCardNumberState_withDeletion() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()

        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]

        waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4141414141414141")

        waitForElementToAppear(elementsQuery.staticTexts["You must provide a valid Card Number."])

        cardNumberTextField.typeText("\u{8}")

        XCTAssertFalse(elementsQuery.textFields["Invalid: Card Number"].exists)
    }
}

class BraintreeDropIn_securityCodeValidation_CardForm_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-UITestHardcodedClientTokenWithCVVValidationEnabled")
        app.launchArguments.append("-ThreeDSecureDefault")
        app.launch()
        sleep(1)
        let button = app.buttons.containing(NSPredicate(format: "label LIKE '* Payment Method'")).element
        waitForElementToBeHittable(button)
        button.tap()
    }

    func testDropIn_invalidSecurityCode_presentsAlert() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()

        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]

        waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4000000000000002")

        let expirationDateTextField = elementsQuery.textFields["Expiration Date"]
        waitForElementToBeHittable(expirationDateTextField)
        expirationDateTextField.forceTapElement()
        expirationDateTextField.typeText("11/\(Date.nextYear)")

        let securityCodeField = elementsQuery.textFields["CVV"]
        waitForElementToBeHittable(securityCodeField)
        securityCodeField.forceTapElement()
        securityCodeField.typeText("200")

        let postalCodeField = elementsQuery.textFields["12345"]
        waitForElementToBeHittable(postalCodeField)
        postalCodeField.forceTapElement()
        postalCodeField.typeText("12345")

        app.buttons["Add Card"].forceTapElement()

        waitForElementToBeHittable(app.alerts.buttons["OK"])
        XCTAssertTrue(app.alerts.staticTexts["Please review your information and try again."].exists)
        app.alerts.buttons["OK"].tap()

        // Assert: can edit after dismissing alert
        waitForElementToBeHittable(securityCodeField)
        securityCodeField.forceTapElement()
        securityCodeField.typeText("\u{8}1")
    }
}

class BraintreeDropIn_CardDisabled_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-TokenizationKey")
        app.launchArguments.append("-CardDisabled")
        app.launch()
        sleep(1)
        waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }

    func testDropIn_cardDisabledOption_disablesCreditCard() {
        waitForElementToBeHittable(app.staticTexts["PayPal"])
        XCTAssertTrue(app.staticTexts["PayPal"].exists)
        XCTAssertFalse(app.staticTexts["Credit or Debit Card"].exists)
    }
}

class BraintreeDropIn_CardLogosDisabled_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-TokenizationKey")
        app.launchArguments.append("-CardLogosDisabled")
        app.launch()
        sleep(1)
        waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }

    func testDropIn_cardLogosDisabledOption_hidesCardLogos() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()

        let elementsQuery = app.scrollViews.otherElements
        let cardLogoImages = elementsQuery.images.element.exists

        XCTAssertFalse(cardLogoImages)
    }
}

class BraintreeDropIn_CardLogosEnabled_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-TokenizationKey")
        app.launch()
        sleep(1)
        waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }

    func testDropIn_cardLogosEnabledOption_showsCardLogos() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()

        let elementsQuery = app.scrollViews.otherElements
        let cardLogoImages = elementsQuery.images.element.exists

        XCTAssertTrue(cardLogoImages)
    }
}

class BraintreeDropIn_CardForm_RequestOptions_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-TokenizationKey")
        app.launchArguments.append("-ThreeDSecureDefault")
        app.launchArguments.append("-MaskSecurityCode")
        app.launch()
        sleep(1)
        waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }

    func testDropIn_maskSecurityCodeOption_enablesSecureTextEntry() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()

        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]

        waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")

        let securityCodeField = elementsQuery.secureTextFields["CVV"]
        waitForElementToBeHittable(securityCodeField)

        XCTAssertFalse(elementsQuery.textFields["CVV"].exists)
    }
}

class BraintreeDropIn_CardholderNameNotAvailable_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-TokenizationKey")
        app.launchArguments.append("-ThreeDSecureDefault")
        app.launch()
        sleep(1)
        waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }

    func testDropIn_cardholderNameNotAvailable_fieldDoesNotExist() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()

        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]

        waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")

        let expirationDateTextField = elementsQuery.textFields["Expiration Date"]
        waitForElementToBeHittable(expirationDateTextField)

        let cardholderNameField = elementsQuery.textFields["Cardholder Name"]
        XCTAssertFalse(cardholderNameField.exists)
    }
}

class BraintreeDropIn_CardholderNameAvailable_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-TokenizationKey")
        app.launchArguments.append("-ThreeDSecureDefault")
        app.launchArguments.append("-CardholderNameAccepted")
        app.launch()
        sleep(1)

        waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()

        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
    }

    func testDropIn_cardholderNameAvailable_fieldExists() {
        let elementsQuery = app.scrollViews.otherElements

        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")

        let cardholderNameField = elementsQuery.textFields["Cardholder Name"]
        waitForElementToAppear(cardholderNameField)
        XCTAssertTrue(cardholderNameField.exists)
    }

    func testDropIn_cardholderNameAvailable_canAddCardWithoutName() {
        let elementsQuery = app.scrollViews.otherElements

        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")

        let cardholderNameTextField = elementsQuery.textFields["Cardholder Name"]
        cardholderNameTextField.forceTapElement()
        cardholderNameTextField.typeText("\n")

        let expirationDateTextField = elementsQuery.textFields["Expiration Date"]
        waitForElementToBeHittable(expirationDateTextField)
        expirationDateTextField.forceTapElement()
        expirationDateTextField.typeText("11/\(Date.nextYear)")

        let securityCodeField = elementsQuery.textFields["CVV"]
        waitForElementToBeHittable(securityCodeField)
        securityCodeField.forceTapElement()
        securityCodeField.typeText("123")

        let postalCodeField = elementsQuery.textFields["12345"]
        waitForElementToBeHittable(postalCodeField)
        postalCodeField.forceTapElement()
        postalCodeField.typeText("12345")

        XCTAssertTrue(app.buttons["Add Card"].isEnabled)
    }
}

class BraintreeDropIn_CardholderNameRequired_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-TokenizationKey")
        app.launchArguments.append("-ThreeDSecureDefault")
        app.launchArguments.append("-CardholderNameRequired")
        app.launch()
        sleep(1)

        waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()

        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
    }

    func testDropIn_cardholderNameRequired_fieldExists() {
        let elementsQuery = app.scrollViews.otherElements

        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")

        let cardholderNameField = elementsQuery.textFields["Cardholder Name"]
        waitForElementToAppear(cardholderNameField)

        XCTAssertTrue(cardholderNameField.exists)
    }

    func testDropIn_cardholderNameRequired_cannotAddCardWithoutName() {
        let elementsQuery = app.scrollViews.otherElements

        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")

        let cardholderNameTextField = elementsQuery.textFields["Cardholder Name"]
        cardholderNameTextField.forceTapElement()
        cardholderNameTextField.typeText("\n")

        let expirationDateTextField = elementsQuery.textFields["Expiration Date"]
        waitForElementToBeHittable(expirationDateTextField)
        expirationDateTextField.forceTapElement()
        expirationDateTextField.typeText("11/\(Date.nextYear)")

        let securityCodeField = elementsQuery.textFields["CVV"]
        waitForElementToBeHittable(securityCodeField)
        securityCodeField.forceTapElement()
        securityCodeField.typeText("123")

        let postalCodeField = elementsQuery.textFields["12345"]
        waitForElementToBeHittable(postalCodeField)
        postalCodeField.forceTapElement()
        postalCodeField.typeText("12345")

        XCTAssertFalse(app.buttons["Add Card"].isEnabled)
    }

    func testDropIn_cardholderNameRequired_canAddCardWithName() {
        let elementsQuery = app.scrollViews.otherElements

        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")

        let cardholderNameField = elementsQuery.textFields["Cardholder Name"]
        waitForElementToBeHittable(cardholderNameField)
        cardholderNameField.forceTapElement()
        cardholderNameField.typeText("First Last\n")

        let expirationDateTextField = elementsQuery.textFields["Expiration Date"]
        waitForElementToBeHittable(expirationDateTextField)
        expirationDateTextField.forceTapElement()
        expirationDateTextField.typeText("11/\(Date.nextYear)")

        let securityCodeField = elementsQuery.textFields["CVV"]
        waitForElementToBeHittable(securityCodeField)
        securityCodeField.forceTapElement()
        securityCodeField.typeText("123")

        let postalCodeField = elementsQuery.textFields["12345"]
        waitForElementToBeHittable(postalCodeField)
        postalCodeField.forceTapElement()
        postalCodeField.typeText("12345")

        XCTAssertTrue(app.buttons["Add Card"].isEnabled)
    }
}

class BraintreeDropIn_ClientToken_CardForm_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-UITestHardcodedClientTokenWithoutCustomerID")
        app.launchArguments.append("-ThreeDSecureDefault")
        app.launch()
        sleep(1)
        waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }

    func testDropIn_withNoCardNumberEntered_showsNextButton() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()

        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]

        waitForElementToBeHittable(cardNumberTextField)

        XCTAssertTrue(app.buttons["Next"].exists)
    }

    func testDropIn_withCardNumberEntered_showsNextButton() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()

        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]

        waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")

        XCTAssertFalse(app.buttons["Next"].exists)
    }
}

// Note: These tests are flakey. They are only working on iOS 13+ simulators
class BraintreeDropIn_PayPal_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-MockedPayPalTokenizationKey")
        app.launch()
        sleep(1)
        waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }

    func testDropIn_payPal_receivesNonce() {
        // Tap Drop-in PayPal button
        waitForElementToBeHittable(app.staticTexts["PayPal"])
        app.staticTexts["PayPal"].tap()
        sleep(3)

        // Tap "Continue" on alert
        addUIInterruptionMonitor(withDescription: "Alert prompting user that the app wants to use PayPal.com to sign in.") { (alert) -> Bool in
            let continueButton = alert.buttons["Continue"]
            if (alert.buttons["Continue"].exists) {
                continueButton.tap()
            }
            return true
        }
        app.coordinate(withNormalizedOffset: CGVector.zero).tap()

        // Interact with PayPal webview
        let webviewElementsQuery = app.webViews.element.otherElements

        waitForElementToBeHittable(webviewElementsQuery.links["Proceed with Sandbox Purchase"])

        webviewElementsQuery.links["Proceed with Sandbox Purchase"].forceTapElement()

        // Assert on demo
        waitForElementToAppear(app.staticTexts["bt_buyer_us@paypal.com"])
        XCTAssertTrue(app.staticTexts["bt_buyer_us@paypal.com"].exists)
    }

    func testDropIn_payPal_cancelPopupShowsSelectPaymentMethodView() {
        // Tap Drop-in PayPal button
        waitForElementToBeHittable(app.staticTexts["PayPal"])
        app.staticTexts["PayPal"].tap()
        sleep(3)

        // Tap "Continue" on alert
        addUIInterruptionMonitor(withDescription: "Alert prompting user that the app wants to use PayPal.com to sign in.") { (alert) -> Bool in
            let continueButton = alert.buttons["Continue"]
            if (alert.buttons["Continue"].exists) {
                continueButton.tap()
            }
            return true
        }
        app.coordinate(withNormalizedOffset: CGVector.zero).tap()

        // Interact with PayPal webview
        let webviewElementsQuery = app.webViews.element.otherElements
        waitForElementToBeHittable(webviewElementsQuery.links["Cancel Sandbox Purchase"])

        webviewElementsQuery.links["Cancel Sandbox Purchase"].forceTapElement()

        // Assert on demo
        waitForElementToAppear(app.staticTexts["Select Payment Method"])
        XCTAssertTrue(app.staticTexts["Select Payment Method"].exists)
    }
}

// Note: These tests are flakey. They are only working on iOS 13+ simulators
class BraintreeDropIn_PayPal_OneTime_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-PayPalOneTime")
        app.launchArguments.append("-MockedPayPalTokenizationKey")
        app.launch()
        sleep(1)
        waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }

    func testDropIn_payPalOneTimePayment_showsAmount() {
        // Tap Drop-in PayPal button
        waitForElementToBeHittable(app.staticTexts["PayPal"])
        app.staticTexts["PayPal"].tap()
        sleep(3)

        // Tap "Continue" on alert
        addUIInterruptionMonitor(withDescription: "Alert prompting user that the app wants to use PayPal.com to sign in.") { (alert) -> Bool in
            let continueButton = alert.buttons["Continue"]
            if (alert.buttons["Continue"].exists) {
                continueButton.tap()
            }
            return true
        }
        app.coordinate(withNormalizedOffset: CGVector.zero).tap()

        // Interact with PayPal webview
        let webviewElementsQuery = app.webViews.element.otherElements
        waitForElementToAppear(webviewElementsQuery.staticTexts["4.77"])
    }

}

class BraintreeDropIn_PayPal_Disabled_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-TokenizationKey")
        app.launchArguments.append("-DisablePayPal")
        app.launch()
        sleep(1)
        waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }

    func testDropIn_payPal_doesNotShowPayPal_whenDisabled() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        XCTAssertFalse(app.staticTexts["PayPal"].exists)
    }
}

class BraintreeDropIn_ThreeDSecure_2_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-UITestHardcodedClientTokenWithoutCustomerID")
        app.launchArguments.append("-ThreeDSecureRequired")
        app.launchArguments.append("-ThreeDSecureVersion2")
        app.launch()
        sleep(1)

        waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }

    func testDropIn_threeDSecure_2_challengeFlow_challengePresented() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()

        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]

        waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4000000000001091")

        let expirationDateTextField = elementsQuery.textFields["Expiration Date"]
        waitForElementToBeHittable(expirationDateTextField)
        expirationDateTextField.forceTapElement()
        expirationDateTextField.typeText("01/\(Date.threeYearsFromNow)")

        let securityCodeField = elementsQuery.textFields["CVV"]
        waitForElementToBeHittable(securityCodeField)
        securityCodeField.forceTapElement()
        securityCodeField.typeText("123")

        let postalCodeField = elementsQuery.textFields["12345"]
        waitForElementToBeHittable(postalCodeField)
        postalCodeField.forceTapElement()
        postalCodeField.typeText("12345")

        app.buttons["Add Card"].forceTapElement()

        waitForElementToAppear(app.staticTexts["Purchase Authentication"])
    }

    func testDropIn_threeDSecure_2_returnsToPaymentSelectionView_whenCanceled() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()

        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]

        waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4000000000001091")

        let expirationDateTextField = elementsQuery.textFields["Expiration Date"]
        waitForElementToBeHittable(expirationDateTextField)
        expirationDateTextField.forceTapElement()
        expirationDateTextField.typeText("01/\(Date.threeYearsFromNow)")

        let securityCodeField = elementsQuery.textFields["CVV"]
        waitForElementToBeHittable(securityCodeField)
        securityCodeField.forceTapElement()
        securityCodeField.typeText("123")

        let postalCodeField = elementsQuery.textFields["12345"]
        waitForElementToBeHittable(postalCodeField)
        postalCodeField.forceTapElement()
        postalCodeField.typeText("12345")

        app.buttons["Add Card"].forceTapElement()

        waitForElementToAppear(app.staticTexts["Purchase Authentication"], timeout: 20)

        app.navigationBars["Secure Checkout"].buttons["Cancel"].forceTapElement()
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        waitForElementToAppear(app.staticTexts["Select Payment Method"])

        waitForElementToBeHittable(app.buttons["Cancel"])
        app.buttons["Cancel"].forceTapElement()

        waitForElementToAppear(app.buttons["Canceled 🎲"])
        XCTAssertTrue(app.buttons["Canceled 🎲"].exists)
    }
}

class BraintreeDropIn_ThreeDSecure_VaultedPaymentMethod_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-ClientToken")
        app.launchArguments.append("-ThreeDSecureRequired")
        app.launchArguments.append("-ThreeDSecureVersion2")
        app.launchArguments.append("-CreateVaulted3DS2PaymentMethod")
        app.launch()
        sleep(1)

        waitForElementToBeHittable(app.buttons["Change Payment Method"])
        app.buttons["Change Payment Method"].tap()
    }

    func testDropIn_threeDSecure2_withVaultedPaymentMethod_challengePresented() {
        waitForElementToAppear(app.tables.firstMatch.staticTexts["Visa"])
        app.cells.firstMatch.staticTexts["Visa"].tap()

        XCTAssertTrue(app.activityIndicators.firstMatch.exists)
        XCTAssertEqual(0, app.cells.count)

        waitForElementToAppear(app.staticTexts["Purchase Authentication"])
    }
}

class BraintreeDropIn_SaveCardToggleVisibleAndOn_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-UITestHardcodedClientTokenWithoutCustomerID")
        app.launchArguments.append("-ThreeDSecureDefault")
        app.launchArguments.append("-SaveCardToggleVisible")
        app.launch()
        sleep(1)

        waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()

        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
    }

    func testDropIn_saveCardSwitch_isVisible() {
        let elementsQuery = app.scrollViews.otherElements

        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")

        let saveCardSwitch = elementsQuery.switches["Save card"]
        waitForElementToBeHittable(saveCardSwitch)

        XCTAssertEqual("1", saveCardSwitch.value as? String)
    }
}

class BraintreeDropIn_SaveCardToggleVisibleAndOff_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-UITestHardcodedClientTokenWithoutCustomerID")
        app.launchArguments.append("-ThreeDSecureDefault")
        app.launchArguments.append("-SaveCardToggleVisible")
        app.launchArguments.append("-VaultCardIsFalse")
        app.launch()
        sleep(1)

        waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()

        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
    }

    func testDropIn_saveCardSwitch_isVisibleAndOff() {
        let elementsQuery = app.scrollViews.otherElements

        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")

        let saveCardSwitch = elementsQuery.switches["Save card"]
        waitForElementToBeHittable(saveCardSwitch)

        XCTAssertEqual("0", saveCardSwitch.value as? String)
    }
}

class BraintreeDropIn_SaveCardToggleHidden_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-UITestHardcodedClientTokenWithoutCustomerID")
        app.launchArguments.append("-ThreeDSecureDefault")
        app.launch()
        sleep(1)

        waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()

        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
    }

    func testDropIn_saveCardSwitch_isHidden() {
        let elementsQuery = app.scrollViews.otherElements

        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")

        let expirationDateTextField = elementsQuery.textFields["Expiration Date"]
        waitForElementToBeHittable(expirationDateTextField)

        let saveCardSwitch = elementsQuery.switches["Save card"]
        XCTAssertFalse(saveCardSwitch.exists)
    }
}

class BraintreeDropIn_SaveCardToggleHiddenForTokenizationKey_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-TokenizationKey")
        app.launchArguments.append("-ThreeDSecureDefault")
        app.launchArguments.append("-SaveCardToggleVisible")
        app.launch()
        sleep(1)

        waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()

        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
    }

    func testDropIn_saveCardSwitch_isHiddenForTokenizationKey() {
        let elementsQuery = app.scrollViews.otherElements

        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")

        let expirationDateTextField = elementsQuery.textFields["Expiration Date"]
        waitForElementToBeHittable(expirationDateTextField)

        let saveCardSwitch = elementsQuery.switches["Save card"]
        XCTAssertFalse(saveCardSwitch.exists)
    }
}
