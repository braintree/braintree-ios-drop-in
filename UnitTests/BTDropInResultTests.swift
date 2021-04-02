import XCTest

class BTDropInResultTests: XCTestCase {

    override func setUp() {
        super.setUp()
        let userDefaults = UserDefaults(suiteName: #file)!
        userDefaults.removePersistentDomain(forName: #file)
        BTDropInResult.userDefaults = userDefaults
    }

    // MARK: - paymentDescription

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

    // MARK: - fetchDropInResultForAuthorization

    func testFetch_whenCustomerDoesNotHaveVaultedPaymentMethods_returnsNil() {
        let mockAPIClient = MockAPIClient(authType: .clientToken)

        let expectation = self.expectation(description: "Calls completion with nil result")
        BTDropInResult.fetch(with: mockAPIClient) { result, error in
            XCTAssertNil(result)
            XCTAssertNil(error)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0)
    }

    func testFetch_whenErrorOccurs_returnsError() {
        let mockAPIClient = MockAPIClient(authType: .clientToken)
        mockAPIClient.vaultedPaymentMethodNoncesError = NSError(domain: "some-domain", code: 1, userInfo: nil)

        let expectation = self.expectation(description: "Calls completion with error")
        BTDropInResult.fetch(with: mockAPIClient) { result, error in
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0)
    }

    func testFetch_whenVaultedPaymentMethodNoncesExist_returnsResultWithFirstNonce() {
        let mockAPIClient = MockAPIClient(authType: .clientToken)
        mockAPIClient.vaultedPaymentMethodNonces = [
            BTCardNonce(nonce: "card-nonce")!,
            BTPayPalAccountNonce(nonce: "paypal-nonce")!
        ]

        let expectation = self.expectation(description: "Calls completion with error")
        BTDropInResult.fetch(with: mockAPIClient) { result, error in
            XCTAssertEqual(result?.paymentMethod?.nonce, "card-nonce")
            XCTAssertNil(error)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0)
    }

    func testFetch_whenAPIClientIsNil_returnsError() {
        let expectation = self.expectation(description: "Calls completion with authorization error")
        BTDropInResult.fetch(with: nil) { result, error in
            XCTAssertNil(result)
            XCTAssertEqual(error?.localizedDescription, "Invalid authorization")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0)
    }

    func testFetch_whenLastSelectedPaymentTypeIsApplePay_returnsResultWithApplePay() {
        BTDropInResult.userDefaults.set(BTUIKPaymentOptionType.applePay.rawValue, forKey: "BT_dropInLastSelectedPaymentMethodType")

        let mockAPIClient = MockAPIClient(authType: .clientToken)

        let expectation = self.expectation(description: "Calls completion with Apple Pay result")
        BTDropInResult.fetch(with: mockAPIClient) { result, error in
            XCTAssertEqual(result?.paymentOptionType, .applePay)
            XCTAssertNil(error)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0)
    }
}
