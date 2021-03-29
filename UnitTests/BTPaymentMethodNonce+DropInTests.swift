import XCTest
import BraintreeDropIn

class BTPaymentMethodNonce_DropInTests: XCTestCase {

    func testPaymentDescription_whenCardNonceWithLastFour() {
        class MockCardNonce: BTCardNonce {
            override var lastFour: String? { "1111" }
        }

        let cardNonce = MockCardNonce()

        XCTAssertEqual("1111", cardNonce.paymentDescription)
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
