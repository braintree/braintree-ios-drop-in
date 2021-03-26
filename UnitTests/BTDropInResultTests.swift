import XCTest

class BTDropInResultTests_Swift: XCTestCase {

    func testPaymentDescription_whenPaymentOptionTypeIsApplePay() {
        let result = BTDropInResult()
        result.paymentOptionType = .applePay
        XCTAssertEqual(result.paymentDescription, "Apple Pay")
    }

    func testPaymentDescription_whenPaymentOptionTypeIsNotApplePay() {
        class MockPayPalAccountNonce: BTPayPalAccountNonce {
            override var email: String? { "hello@world.com" }
        }

        let result = BTDropInResult()
        result.paymentMethod = MockPayPalAccountNonce()
        result.paymentOptionType = .payPal
        XCTAssertEqual(result.paymentDescription, "hello@world.com")
    }
}
