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
    
    func testDropIn_dismissesWhenCancelled() {
        waitForElementToBeHittable(app.buttons["Cancel"])
        app.buttons["Cancel"].forceTapElement()
        XCTAssertTrue(app.buttons["Cancelled🎲"].exists)
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
        
        waitForElementToBeHittable(app.staticTexts[Date.getNextYear()])
        app.staticTexts["11"].forceTapElement()
        app.staticTexts[Date.getNextYear()].forceTapElement()
        
        let securityCodeField = elementsQuery.textFields["CVV"]
        waitForElementToBeHittable(securityCodeField)
        securityCodeField.forceTapElement()
        securityCodeField.typeText("123")
        
        let postalCodeField = elementsQuery.textFields["12345"]
        waitForElementToBeHittable(postalCodeField)
        postalCodeField.forceTapElement()
        postalCodeField.typeText("12345")
        
        app.buttons["Add Card"].forceTapElement()
        
        waitForElementToAppear(app.staticTexts["ending in 11"])
        
        XCTAssertTrue(app.staticTexts["ending in 11"].exists)
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
        app.launchArguments.append("-ThreeDSecureDefault")
        // NOTE: This sandbox client token has CVV validation enabled.
        app.launchArguments.append("-Authorization:eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiI2ZGE5Y2VhMzVkNGNlMjkxNGI3YzBiOGRiN2M5OWU4MjVmYTQ5ZTY5OTNiYWM4YmE3MTQwYjdiZjI0ODc4NGQ0fGNyZWF0ZWRfYXQ9MjAxOC0wMy0xMlQyMTo0MzoxMS4wOTI1MzAxNDcrMDAwMCZjdXN0b21lcl9pZD01ODA3NDE3NzEmbWVyY2hhbnRfaWQ9aGg0Y3BjMzl6cTRyZ2pjZyZwdWJsaWNfa2V5PXEzanRzcTNkM3Aycmg1dnQiLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvaGg0Y3BjMzl6cTRyZ2pjZy9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJncmFwaFFMVXJsIjoiaHR0cHM6Ly9wYXltZW50cy5zYW5kYm94LmJyYWludHJlZS1hcGkuY29tL2dyYXBocWwiLCJjaGFsbGVuZ2VzIjpbImN2diJdLCJlbnZpcm9ubWVudCI6InNhbmRib3giLCJjbGllbnRBcGlVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvaGg0Y3BjMzl6cTRyZ2pjZy9jbGllbnRfYXBpIiwiYXNzZXRzVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhdXRoVXJsIjoiaHR0cHM6Ly9hdXRoLnZlbm1vLnNhbmRib3guYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhbmFseXRpY3MiOnsidXJsIjoiaHR0cHM6Ly9jbGllbnQtYW5hbHl0aWNzLnNhbmRib3guYnJhaW50cmVlZ2F0ZXdheS5jb20vaGg0Y3BjMzl6cTRyZ2pjZyJ9LCJ0aHJlZURTZWN1cmVFbmFibGVkIjp0cnVlLCJwYXlwYWxFbmFibGVkIjp0cnVlLCJwYXlwYWwiOnsiZGlzcGxheU5hbWUiOiJidCIsImNsaWVudElkIjoiQVZRSmY5YS1iNmptWUZnaW9OcEkyaTU3cnNRa0hqUlpadjRkOURaTFRVMG5CU3Vma2h3QUNBWnhqMGxkdTg1amFzTTAyakZSUEthVElOQ04iLCJwcml2YWN5VXJsIjoiaHR0cDovL2V4YW1wbGUuY29tL3BwIiwidXNlckFncmVlbWVudFVybCI6Imh0dHA6Ly9leGFtcGxlLmNvbS90b3MiLCJiYXNlVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhc3NldHNVcmwiOiJodHRwczovL2NoZWNrb3V0LnBheXBhbC5jb20iLCJkaXJlY3RCYXNlVXJsIjpudWxsLCJhbGxvd0h0dHAiOnRydWUsImVudmlyb25tZW50Tm9OZXR3b3JrIjpmYWxzZSwiZW52aXJvbm1lbnQiOiJvZmZsaW5lIiwidW52ZXR0ZWRNZXJjaGFudCI6ZmFsc2UsImJyYWludHJlZUNsaWVudElkIjoibWFzdGVyY2xpZW50MyIsImJpbGxpbmdBZ3JlZW1lbnRzRW5hYmxlZCI6dHJ1ZSwibWVyY2hhbnRBY2NvdW50SWQiOiJjNXljdzJzdnlrbnp3anR6IiwiY3VycmVuY3lJc29Db2RlIjoiVVNEIn0sIm1lcmNoYW50SWQiOiJoaDRjcGMzOXpxNHJnamNnIiwidmVubW8iOiJvZmYiLCJicmFpbnRyZWVfYXBpIjp7InVybCI6Imh0dHBzOi8vcGF5bWVudHMuc2FuZGJveC5icmFpbnRyZWUtYXBpLmNvbSIsImFjY2Vzc190b2tlbiI6InNhbmRib3hfNmRkdG13X3B6YjZ3cF93ZHdoY3lfOWhnNm5iX2N5NiJ9fQ==")
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

        waitForElementToBeHittable(app.staticTexts[Date.getNextYear()])
        app.staticTexts["11"].forceTapElement()
        app.staticTexts[Date.getNextYear()].forceTapElement()

        let securityCodeField = elementsQuery.textFields["CVV"]
        waitForElementToBeHittable(securityCodeField)
        securityCodeField.forceTapElement()
        securityCodeField.typeText("200")

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
    
    func testDropIn_cardholderNameNotAvailable_fieldDoesntExist() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        
        waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")
        
        waitForElementToBeHittable(app.staticTexts[Date.getNextYear()])
        
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
        cardholderNameTextField.typeText("\n")
        
        waitForElementToBeHittable(app.staticTexts[Date.getNextYear()])
        app.staticTexts["11"].forceTapElement()
        app.staticTexts[Date.getNextYear()].forceTapElement()
        
        let securityCodeField = elementsQuery.textFields["CVV"]
        waitForElementToBeHittable(securityCodeField)
        securityCodeField.forceTapElement()
        securityCodeField.typeText("123")
        
        let postalCodeField = elementsQuery.textFields["12345"]
        waitForElementToBeHittable(postalCodeField)
        postalCodeField.forceTapElement()
        postalCodeField.typeText("12345")
        
        app.buttons["Add Card"].forceTapElement()
        
        waitForElementToAppear(app.staticTexts["ending in 11"])
        
        XCTAssertTrue(app.staticTexts["ending in 11"].exists)
        
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
        cardholderNameTextField.typeText("\n")

        waitForElementToBeHittable(app.staticTexts[Date.getNextYear()])
        app.staticTexts["11"].forceTapElement()
        app.staticTexts[Date.getNextYear()].forceTapElement()

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
        cardholderNameField.typeText("First Last\n")

        waitForElementToBeHittable(app.staticTexts[Date.getNextYear()])
        app.staticTexts["11"].forceTapElement()
        app.staticTexts[Date.getNextYear()].forceTapElement()

        let securityCodeField = elementsQuery.textFields["CVV"]
        waitForElementToBeHittable(securityCodeField)
        securityCodeField.forceTapElement()
        securityCodeField.typeText("123")

        let postalCodeField = elementsQuery.textFields["12345"]
        waitForElementToBeHittable(postalCodeField)
        postalCodeField.forceTapElement()
        postalCodeField.typeText("12345")

        app.buttons["Add Card"].forceTapElement()

        waitForElementToAppear(app.staticTexts["ending in 11"])

        XCTAssertTrue(app.staticTexts["ending in 11"].exists)
    }
}

class BraintreeDropIn_ClientToken_CardForm_UITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-ClientToken")
        app.launchArguments.append("-ThreeDSecureDefault")
        app.launch()
        sleep(1)
        waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }
    
    func testDropIn_cardInput_receivesNonce() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        
        waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")
        waitForElementToBeHittable(app.staticTexts[Date.getNextYear()])
        app.staticTexts["11"].forceTapElement()
        app.staticTexts[Date.getNextYear()].forceTapElement()
        
        let securityCodeField = app.scrollViews.otherElements.textFields["CVV"]
        waitForElementToBeHittable(securityCodeField)
        securityCodeField.forceTapElement()
        securityCodeField.typeText("123")
        
        let postalCodeField = app.scrollViews.otherElements.textFields["12345"]
        waitForElementToBeHittable(postalCodeField)
        postalCodeField.forceTapElement()
        postalCodeField.typeText("12345")
        
        app.buttons["Add Card"].forceTapElement()
        
        waitForElementToAppear(app.staticTexts["ending in 11"])
        
        XCTAssertTrue(app.staticTexts["ending in 11"].exists)
    }
    
    func testDropIn_nonUnionPayCardNumber_showsNextButton() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
        
        XCTAssertTrue(app.buttons["Next"].exists)
    }
    
    func testDropIn_hidesValidateButtonAfterCardNumberEntered() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        
        waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")
        
        XCTAssertFalse(app.buttons["Next"].exists)
    }
    
    func pendDropIn_showsSpinnerDuringUnionPayCapabilitiesFetch() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        
        waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("6212345678901232")
        
        waitForElementToBeHittable(app.buttons["Next"])
        app.buttons["Next"].forceTapElement()
        XCTAssertTrue(app.activityIndicators.count == 1 && app.activityIndicators["In progress"].exists)
    }
    
    func pendDropIn_unionPayCardNumber_receivesNonce() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        
        waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("6212345678901232")
        
        waitForElementToBeHittable(app.buttons["Next"])
        app.buttons["Next"].forceTapElement()
        
        let expiryTextField = elementsQuery.textFields["MM/YYYY"]
        waitForElementToBeHittable(expiryTextField)
        
        waitForElementToBeHittable(app.staticTexts[Date.getNextYear()])
        app.staticTexts["11"].forceTapElement()
        app.staticTexts[Date.getNextYear()].forceTapElement()
        
        elementsQuery.textFields["Security Code"].typeText("565")
        app.typeText("65")
        
        app.staticTexts["Mobile Number"].forceTapElement()
        app.typeText("1235566543")
        
        app.buttons["Add Card"].forceTapElement()
        
        waitForElementToBeHittable(app.alerts.buttons["OK"])
        app.alerts.buttons["OK"].tap()
        
        waitForElementToBeHittable(app.textFields["SMS Code"])
        app.textFields["SMS Code"].forceTapElement()
        app.typeText("12345")
        
        waitForElementToBeHittable(app.buttons["Confirm"])
        app.buttons["Confirm"].forceTapElement()
        
        waitForElementToAppear(app.staticTexts["ending in 32"])
        
        XCTAssertTrue(app.staticTexts["ending in 32"].exists)
    }

}


class BraintreeDropIn_PayPal_UITests: XCTestCase {
    
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
    
    func testDropIn_paypal_showsPayPal() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        XCTAssertTrue(app.staticTexts["PayPal"].exists)
    }
    
    func testDropIn_paypal_receivesNonce() {
        if #available(iOS 11.0, *) {
            // SFSafariAuthenticationSession flow cannot be fully automated, so returning early
            return
        }
        
        waitForElementToBeHittable(app.staticTexts["PayPal"])
        app.staticTexts["PayPal"].tap()
        sleep(3)
        
        let webviewElementsQuery = app.webViews.element.otherElements
        
        waitForElementToBeHittable(webviewElementsQuery.links["Proceed with Sandbox Purchase"])
        
        webviewElementsQuery.links["Proceed with Sandbox Purchase"].forceTapElement()
        
        waitForElementToAppear(app.staticTexts["bt_buyer_us@paypal.com"])
        
        XCTAssertTrue(app.staticTexts["bt_buyer_us@paypal.com"].exists)
    }

    func testDropIn_paypal_cancelPopupShowsSelectPaymentMethodView() {
        if #available(iOS 11.0, *) {
            return
        }

        waitForElementToBeHittable(app.staticTexts["PayPal"])
        app.staticTexts["PayPal"].tap()
        sleep(3)

        let webviewElementsQuery = app.webViews.element.otherElements

        waitForElementToBeHittable(webviewElementsQuery.links["Cancel Sandbox Purchase"])

        webviewElementsQuery.links["Cancel Sandbox Purchase"].forceTapElement()

        waitForElementToAppear(app.staticTexts["Select Payment Method"])

        XCTAssertTrue(app.staticTexts["Select Payment Method"].exists)
    }
}

class BraintreeDropIn_PayPal_OneTime_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-PayPalOneTime")
        app.launchArguments.append("-TokenizationKey")
        app.launch()
        sleep(1)
        waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }

    func testDropIn_paypal_showAmount_receivesNonce() {
        if #available(iOS 11.0, *) {
            // SFSafariAuthenticationSession flow cannot be fully automated, so returning early
            return
        }

        waitForElementToBeHittable(app.staticTexts["PayPal"])
        app.staticTexts["PayPal"].tap()
        sleep(3)

        let webviewElementsQuery = app.webViews.element.otherElements

        waitForElementToAppear(webviewElementsQuery.staticTexts["4.77"])

        waitForElementToBeHittable(webviewElementsQuery.links["Proceed with Sandbox Purchase"])

        webviewElementsQuery.links["Proceed with Sandbox Purchase"].forceTapElement()

        waitForElementToAppear(app.staticTexts["bt_buyer_us@paypal.com"])

        XCTAssertTrue(app.staticTexts["bt_buyer_us@paypal.com"].exists)
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
    
    func testDropIn_paypal_doesNotShowPayPal_whenDisabled() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        XCTAssertFalse(app.staticTexts["PayPal"].exists)
    }
}

class BraintreeDropIn_ThreeDSecure_UITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-ClientToken")
        app.launchArguments.append("-ThreeDSecureRequired")
        app.launchArguments.append("-ThreeDSecureVersionLegacy")
        app.launch()
        sleep(1)
        waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }
    
    func testDropIn_threeDSecure_showsThreeDSecureWebview_andTransacts() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        
        waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")
        
        waitForElementToBeHittable(app.staticTexts[Date.getNextYear()])
        app.staticTexts["11"].forceTapElement()
        app.staticTexts[Date.getNextYear()].forceTapElement()
        
        let securityCodeField = elementsQuery.textFields["CVV"]
        waitForElementToBeHittable(securityCodeField)
        securityCodeField.forceTapElement()
        securityCodeField.typeText("123")
        
        let postalCodeField = elementsQuery.textFields["12345"]
        waitForElementToBeHittable(postalCodeField)
        postalCodeField.forceTapElement()
        postalCodeField.typeText("12345")
        
        app.buttons["Add Card"].forceTapElement()
        
        waitForElementToAppear(app.staticTexts["Added Protection"], timeout: 20)
        
        let textField = app.secureTextFields.element(boundBy: 0)
        waitForElementToBeHittable(textField)
        textField.forceTapElement()
        sleep(2)
        textField.typeText("1234")
        
        app.buttons["Submit"].forceTapElement()
        
        waitForElementToAppear(app.staticTexts["ending in 11"])
        
        XCTAssertTrue(app.staticTexts["ending in 11"].exists)
        
        waitForElementToBeHittable(app.buttons["Complete Purchase"])
        app.buttons["Complete Purchase"].forceTapElement()
        
        let existsPredicate = NSPredicate(format: "label LIKE 'created*'")
        
        waitForElementToAppear(app.buttons.containing(existsPredicate).element(boundBy: 0))
    }

    func testDropIn_threeDSecure_returnsToPaymentSelectionView_whenCanceled() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        
        waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")
        
        waitForElementToBeHittable(app.staticTexts[Date.getNextYear()])
        app.staticTexts["11"].forceTapElement()
        app.staticTexts[Date.getNextYear()].forceTapElement()
        
        let securityCodeField = elementsQuery.textFields["CVV"]
        waitForElementToBeHittable(securityCodeField)
        securityCodeField.forceTapElement()
        securityCodeField.typeText("123")
        
        let postalCodeField = elementsQuery.textFields["12345"]
        waitForElementToBeHittable(postalCodeField)
        postalCodeField.forceTapElement()
        postalCodeField.typeText("12345")
        
        app.buttons["Add Card"].forceTapElement()
        
        waitForElementToAppear(app.staticTexts["Added Protection"], timeout: 20)
        
        app.buttons["Done"].forceTapElement()
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        waitForElementToAppear(app.staticTexts["Select Payment Method"])

        waitForElementToBeHittable(app.buttons["Cancel"])
        app.buttons["Cancel"].forceTapElement()

        waitForElementToAppear(app.buttons["Cancelled🎲"])
        XCTAssertTrue(app.buttons["Cancelled🎲"].exists)
    }
    
    func testDropIn_threeDSecure_tokenizationError_showsAlert() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        
        waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4687380000000008")
        
        waitForElementToBeHittable(app.staticTexts[Date.getNextYear()])
        app.staticTexts["01"].forceTapElement()
        app.staticTexts[Date.getNextYear()].forceTapElement()
        
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

class BraintreeDropIn_ThreeDSecure_2_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-ClientToken")
        app.launchArguments.append("-ThreeDSecureRequired")
        app.launchArguments.append("-ThreeDSecureVersion2")
        app.launch()
        sleep(1)

        waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }

    func testDropIn_threeDSecure_2_frictionlessFlow_andTransacts() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()

        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]

        waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4000000000001000")

        waitForElementToBeHittable(app.staticTexts[Date.getNextYear()])
        app.staticTexts["01"].forceTapElement()
        app.staticTexts[Date.getThreeYearsFromNow()].forceTapElement()

        let securityCodeField = elementsQuery.textFields["CVV"]
        waitForElementToBeHittable(securityCodeField)
        securityCodeField.forceTapElement()
        securityCodeField.typeText("123")

        let postalCodeField = elementsQuery.textFields["12345"]
        waitForElementToBeHittable(postalCodeField)
        postalCodeField.forceTapElement()
        postalCodeField.typeText("12345")

        app.buttons["Add Card"].forceTapElement()

        waitForElementToAppear(app.staticTexts["ending in 00"])

        XCTAssertTrue(app.staticTexts["ending in 00"].exists)

        waitForElementToBeHittable(app.buttons["Complete Purchase"])
        app.buttons["Complete Purchase"].forceTapElement()

        let existsPredicate = NSPredicate(format: "label LIKE 'created*'")

        waitForElementToAppear(app.buttons.containing(existsPredicate).element(boundBy: 0))
    }

    func testDropIn_threeDSecure_2_challengeFlow_andTransacts() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()

        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]

        waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4000000000001091")

        waitForElementToBeHittable(app.staticTexts[Date.getNextYear()])
        app.staticTexts["01"].forceTapElement()
        app.staticTexts[Date.getThreeYearsFromNow()].forceTapElement()

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

        let textField = app.textFields.element(boundBy: 0)
        waitForElementToBeHittable(textField)
        textField.forceTapElement()
        sleep(2)
        textField.typeText("1234")

        app.buttons["SUBMIT"].forceTapElement()

        waitForElementToAppear(app.staticTexts["ending in 91"])

        XCTAssertTrue(app.staticTexts["ending in 91"].exists)

        waitForElementToBeHittable(app.buttons["Complete Purchase"])
        app.buttons["Complete Purchase"].forceTapElement()

        let existsPredicate = NSPredicate(format: "label LIKE 'created*'")

        waitForElementToAppear(app.buttons.containing(existsPredicate).element(boundBy: 0))
    }

    func testDropIn_threeDSecure_2_returnsToPaymentSelectionView_whenCanceled() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()

        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]

        waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4000000000001091")

        waitForElementToBeHittable(app.staticTexts[Date.getNextYear()])
        app.staticTexts["01"].forceTapElement()
        app.staticTexts[Date.getThreeYearsFromNow()].forceTapElement()

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

        waitForElementToAppear(app.buttons["Cancelled🎲"])
        XCTAssertTrue(app.buttons["Cancelled🎲"].exists)
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
    
    func testDropIn_threeDSecure_2_challengeFlow_withVaultedPaymentMethod() {
        waitForElementToBeHittable(app.collectionViews.cells.firstMatch)
        app.collectionViews.cells.firstMatch.tap()
        
        XCTAssertTrue(app.activityIndicators.firstMatch.exists)
        XCTAssertEqual(0, app.cells.count)
        
        waitForElementToAppear(app.staticTexts["Purchase Authentication"], timeout: 20)
        
        let textField = app.textFields.element(boundBy: 0)
        waitForElementToBeHittable(textField)
        textField.forceTapElement()
        sleep(2)
        textField.typeText("1234")
        
        app.buttons["SUBMIT"].forceTapElement()
        
        waitForElementToAppear(app.staticTexts["ending in 91"])
        
        XCTAssertTrue(app.staticTexts["ending in 91"].exists)
    }
}

class BraintreeDropIn_Venmo_Disabled_UITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-TokenizationKey")
        app.launchArguments.append("-ForceVenmo")
        app.launchArguments.append("-DisableVenmo")
        app.launch()
        sleep(1)
        waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }
    
    func testDropIn_venmo_doesNotShow_whenDisabled() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        XCTAssertFalse(app.staticTexts["Venmo"].exists)
    }
}

class BraintreeDropIn_Venmo_UITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-TokenizationKey")
        app.launchArguments.append("-ForceVenmo")
        app.launch()
        sleep(1)
        waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }
    
    func testDropIn_venmo_doesShow() {
        waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        XCTAssertTrue(app.staticTexts["Venmo"].exists)
    }
}

class BraintreeDropIn_Error_UITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-TokenizationKey")
        app.launchArguments.append("-BadUrlScheme")
        app.launch()
        sleep(1)
        waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }
    
    func testDropIn_paypal_receivesError_whenUrlSchemeIsIncorrect() {
        waitForElementToBeHittable(app.staticTexts["PayPal"])
        app.staticTexts["PayPal"].tap()
        sleep(3)
        
        let existsPredicate = NSPredicate(format: "label LIKE '*Application does not support One Touch callback*'")
        
        waitForElementToAppear(app.buttons.containing(existsPredicate).element(boundBy: 0))
    }
}

class BraintreeDropIn_SaveCardToggleVisibleAndOn_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-ClientToken")
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
        app.launchArguments.append("-ClientToken")
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
        app.launchArguments.append("-ClientToken")
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

        waitForElementToBeHittable(app.staticTexts[Date.getNextYear()])

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

        waitForElementToBeHittable(app.staticTexts[Date.getNextYear()])

        let saveCardSwitch = elementsQuery.switches["Save card"]
        XCTAssertFalse(saveCardSwitch.exists)
    }
}
