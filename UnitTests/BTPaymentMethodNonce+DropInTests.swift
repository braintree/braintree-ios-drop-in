import XCTest
import BraintreeDropIn

class BTPaymentMethodNonce_DropInTests: XCTestCase {

    // MARK: - paymentDescription

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

    // MARK: - shouldDisplayVaultedNonce

    // MARK: - Card

    func testShouldDisplay_whenCardEnabledInRequest_andCardEnabledInConfig_returnsTrue() {
        let request = BTDropInRequest()
        let configJSON = BTJSON(value: [
            "creditCards" : [
                "supportedCardTypes" : ["Visa"]
            ]
        ])
        let config = BTConfiguration(json: configJSON)

        let nonce = BTCardNonce()
        XCTAssertTrue(nonce.shouldDisplayVaultedNonce(for: request, config: config))
    }

    func testShouldDisplay_whenCardDisabledInRequest_andCardEnabledInConfig_returnFalse() {
        let request = BTDropInRequest()
        request.cardDisabled = true
        let configJSON = BTJSON(value: [
            "creditCards" : [
                "supportedCardTypes" : ["Visa"]
            ]
        ])
        let config = BTConfiguration(json: configJSON)

        let nonce = BTCardNonce()
        XCTAssertFalse(nonce.shouldDisplayVaultedNonce(for: request, config: config))
    }

    func testShouldDisplay_whenCardEnabledInRequest_andCardDisabledInConfig_returnsFalse() {
        let request = BTDropInRequest()
        let configJSON = BTJSON(value: ["paypalEnabled" : true])
        let config = BTConfiguration(json: configJSON)

        let nonce = BTCardNonce()
        XCTAssertFalse(nonce.shouldDisplayVaultedNonce(for: request, config: config))
    }

    // MARK: - PayPal

    func testShouldDisplay_whenPayPalEnabledInRequest_andPayPalEnabledInConfig_returnsTrue() {
        let request = BTDropInRequest()
        let configJSON = BTJSON(value: ["paypalEnabled" : true])
        let config = BTConfiguration(json: configJSON)

        let nonce = BTPayPalAccountNonce()
        XCTAssertTrue(nonce.shouldDisplayVaultedNonce(for: request, config: config))
    }

    func testShouldDisplay_whenPayPalDisabledInRequest_andPayPalEnabledInConfig_returnFalse() {
        let request = BTDropInRequest()
        request.paypalDisabled = true
        let configJSON = BTJSON(value: ["paypalEnabled" : true])
        let config = BTConfiguration(json: configJSON)

        let nonce = BTPayPalAccountNonce()
        XCTAssertFalse(nonce.shouldDisplayVaultedNonce(for: request, config: config))
    }

    func testShouldDisplay_whenPayPalEnabledInRequest_andPayPalDisabledInConfig_returnsFalse() {
        let request = BTDropInRequest()
        let configJSON = BTJSON(value: ["paypalEnabled" : false])
        let config = BTConfiguration(json: configJSON)

        let nonce = BTPayPalAccountNonce()
        XCTAssertFalse(nonce.shouldDisplayVaultedNonce(for: request, config: config))
    }

    // MARK: - Venmo

    func testShouldDisplay_whenVenmoEnabledInRequest_andVenmoEnabledInConfig_returnsTrue() {
        let request = BTDropInRequest()
        let configJSON = BTJSON(value: ["payWithVenmo" : ["accessToken" : "some-token"]])
        let config = BTConfiguration(json: configJSON)

        let nonce = BTVenmoAccountNonce()
        XCTAssertTrue(nonce.shouldDisplayVaultedNonce(for: request, config: config))
    }

    func testShouldDisplay_whenVenmoDisabledInRequest_andVenmoEnabledInConfig_returnFalse() {
        let request = BTDropInRequest()
        request.venmoDisabled = true
        let configJSON = BTJSON(value: ["payWithVenmo" : ["accessToken" : "some-token"]])
        let config = BTConfiguration(json: configJSON)

        let nonce = BTVenmoAccountNonce()
        XCTAssertFalse(nonce.shouldDisplayVaultedNonce(for: request, config: config))
    }

    func testShouldDisplay_whenVenmoEnabledInRequest_andVenmoDisabledInConfig_returnsFalse() {
        let request = BTDropInRequest()
        let configJSON = BTJSON(value: ["payWithVenmo" : ["accessToken" : nil] as [String : Any?]])
        let config = BTConfiguration(json: configJSON)

        let nonce = BTVenmoAccountNonce()
        XCTAssertFalse(nonce.shouldDisplayVaultedNonce(for: request, config: config))
    }

    // MARK: - Apple Pay

    func testShouldDisplay_whenApplePayEnabledInRequest_andApplePayEnabledInConfig_returnsTrue() {
        let request = BTDropInRequest()
        let configJSON = BTJSON(value: ["applePay" : ["status" : "on"]])
        let config = BTConfiguration(json: configJSON)

        let nonce = BTApplePayCardNonce()
        XCTAssertTrue(nonce.shouldDisplayVaultedNonce(for: request, config: config))
    }

    func testShouldDisplay_whenApplePayDisabledInRequest_andApplePayEnabledInConfig_returnFalse() {
        let request = BTDropInRequest()
        request.applePayDisabled = true
        let configJSON = BTJSON(value: ["applePay" : ["status" : "on"]])
        let config = BTConfiguration(json: configJSON)

        let nonce = BTApplePayCardNonce()
        XCTAssertFalse(nonce.shouldDisplayVaultedNonce(for: request, config: config))
    }

    func testShouldDisplay_whenApplePayEnabledInRequest_andApplePayDisabledInConfig_returnsFalse() {
        let request = BTDropInRequest()
        let configJSON = BTJSON(value: ["applePay" : ["status" : "off"]])
        let config = BTConfiguration(json: configJSON)

        let nonce = BTApplePayCardNonce()
        XCTAssertFalse(nonce.shouldDisplayVaultedNonce(for: request, config: config))
    }

    // MARK: - Unknown

    func testShouldDisplay_whenUnknownNonce_returnsTrue() {
        let request = BTDropInRequest()
        let config = BTConfiguration(json: BTJSON())

        let nonce = BTPaymentMethodNonce()
        XCTAssertTrue(nonce.shouldDisplayVaultedNonce(for: request, config: config))
    }
}
