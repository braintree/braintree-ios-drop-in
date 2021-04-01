@objcMembers class MockAPIClient: BTAPIClient {

    var vaultedPaymentMethodNonces: [BTPaymentMethodNonce]?

    @objc override func fetchPaymentMethodNonces(_ defaultFirst: Bool, completion: @escaping ([BTPaymentMethodNonce]?, Error?) -> Void) {
        completion(vaultedPaymentMethodNonces, nil)
    }
}
