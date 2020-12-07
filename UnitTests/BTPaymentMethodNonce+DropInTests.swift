import XCTest
import Braintree
import BraintreeDropIn

class BTPaymentMethodNonceDropInTests: XCTestCase {

    let sharedParser = BTPaymentMethodNonceParser.shared()

    // TODO: - Why three dots + space + two dots + last two? Should it start w/ four dots?
    func testPaymentDescription_whenCardNonceWithLastTwo() {
        let cardJSON = BTJSON(value: [
            "nonce": "fake-nonce",
            "description": "Visa ending in 11",
            "details": [
                "lastTwo" : "11",
                "cardType": "visa"
            ]
        ])
        let cardNonce = sharedParser.parseJSON(cardJSON, withParsingBlockForType: "CreditCard") as? BTCardNonce

        XCTAssertEqual("••• ••11", cardNonce?.paymentDescription)
    }

    // TODO: - check how other SDKs handle cards w/o last two digits
    func testPaymentDescription_whenCardNonceWithoutLastTwo() {
        let cardJSON = BTJSON(value: [
            "nonce": "fake-nonce",
            "description": "Visa ending in 11",
            "details": [
                "cardType": "visa"
            ]
        ])
        let cardNonce = sharedParser.parseJSON(cardJSON, withParsingBlockForType: "CreditCard") as? BTCardNonce

        XCTAssertEqual("••• ••", cardNonce?.paymentDescription)
    }

    func testPaymentDescription_whenPayPalNonce() {
        let payPalJSON = BTJSON(value: [
            "nonce": "fake-nonce",
            "description": "A description",
            "details": [
                "email": "hello@world.com"
            ]
        ])

        let payPalNonce = sharedParser.parseJSON(payPalJSON, withParsingBlockForType: "PayPalAccount") as? BTPayPalAccountNonce

        XCTAssertEqual("hello@world.com", payPalNonce?.paymentDescription)
    }

    func testPaymentDescription_whenVenmoNonce() {
        let venmoJSON = BTJSON(value: [
            "nonce": "fake-nonce",
            "description": "Venmo account",
            "details": [
                "username": "username@example.com",
            ]
        ])

        let venmoNonce = sharedParser.parseJSON(venmoJSON, withParsingBlockForType: "VenmoAccount") as? BTVenmoAccountNonce

        XCTAssertEqual("username@example.com", venmoNonce?.paymentDescription)
    }

    // TODO: - We need to expose the description on BTApplePayCardNonce, use a different value or hard-code the string in Drop-in
    func testPaymentDescription_whenApplePayNonce() {
        let sharedParser = BTPaymentMethodNonceParser.shared()
        let applePayCard = BTJSON(value: [
            "nonce": "fake-nonce",
            "description": "Apple Pay"
        ])

        let applePayNonce = sharedParser.parseJSON(applePayCard, withParsingBlockForType: "ApplePayCard") as? BTApplePayCardNonce

        XCTAssertEqual("Apple Pay", applePayNonce?.paymentDescription)
    }

    func testPaymentDescription_whenUnknownNonce() {
        let unknownNonce = BTPaymentMethodNonce()
        XCTAssertEqual("", unknownNonce.paymentDescription)
    }
}
