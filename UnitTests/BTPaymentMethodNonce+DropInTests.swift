import XCTest
import BraintreeDropIn

class BTPaymentMethodNonceDropInTests: XCTestCase {

    func testPaymentDescription_whenCardNonceWithLastTwo() {
        class MockCardNonce: BTCardNonce {
            override var lastTwo: String? { "11" }
        }

        let cardNonce = MockCardNonce()

        XCTAssertEqual("••• ••11", cardNonce.paymentDescription)
    }

    func testPaymentDescription_whenCardNonceWithoutLastTwo() {
        let cardNonce = BTCardNonce()

        XCTAssertEqual("••• ••", cardNonce.paymentDescription)
    }

    func testPaymentDescription_whenPayPalNonce() {
        class MockPayPalAccountNonce: BTPayPalAccountNonce {
            override var email: String? { "hello@world.com" }
        }

        let payPalNonce = MockPayPalAccountNonce()

        XCTAssertEqual("hello@world.com", payPalNonce.paymentDescription)
    }

    func testPaymentDescription_whenVenmoNonce() {
        class MockVenmoAccountNonce: BTVenmoAccountNonce {
            override var username: String? { "username@example.com" }
        }

        let venmoNonce = MockVenmoAccountNonce()

        XCTAssertEqual("username@example.com", venmoNonce.paymentDescription)
    }

    func testPaymentDescription_whenApplePay() {
        let applePayNonce = BTApplePayCardNonce()
        XCTAssertEqual("Apple Pay", applePayNonce.paymentDescription)
    }

    func testPaymentDescription_whenUnknownNonce() {
        let unknownNonce = BTPaymentMethodNonce()
        XCTAssertEqual("", unknownNonce.paymentDescription)
    }
}
