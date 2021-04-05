import XCTest

class BTDropInResultTests_Swift: XCTestCase {

    func testPaymentDescription_whenPaymentMethodTypeIsApplePay() {
        let result = BTDropInResult()
        result.paymentMethodType = .applePay
        XCTAssertEqual(result.paymentDescription, "Apple Pay")
    }

    func testPaymentDescription_whenPaymentMethodTypeIsNotApplePay() {
        class MockPayPalAccountNonce: BTPayPalAccountNonce {
            override var email: String? { "hello@world.com" }
        }

        let result = BTDropInResult()
        result.paymentMethod = MockPayPalAccountNonce()
        result.paymentMethodType = .payPal
        XCTAssertEqual(result.paymentDescription, "hello@world.com")
    }
}
