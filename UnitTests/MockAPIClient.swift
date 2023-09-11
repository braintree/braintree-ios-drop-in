@objcMembers class MockAPIClient: BTAPIClient {

    enum Authorization {
        case clientToken, tokenizationKey
    }

    var vaultedPaymentMethodNonces: [BTPaymentMethodNonce]?
    var vaultedPaymentMethodNoncesError: Error?

    convenience init(authType: Authorization) {
        switch authType {
        case .clientToken:
            self.init(authorization: "eyJ2ZXJzaW9uIjozLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiIxYzM5N2E5OGZmZGRkNDQwM2VjNzEzYWRjZTI3NTNiMzJlODc2MzBiY2YyN2M3NmM2OWVmZjlkMTE5MjljOTVkfGNyZWF0ZWRfYXQ9MjAxNy0wNC0wNVQwNjowNzowOC44MTUwOTkzMjUrMDAwMFx1MDAyNm1lcmNoYW50X2lkPWRjcHNweTJicndkanIzcW5cdTAwMjZwdWJsaWNfa2V5PTl3d3J6cWszdnIzdDRuYzgiLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvZGNwc3B5MmJyd2RqcjNxbi9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24ifQ==")!
        case .tokenizationKey:
            self.init(authorization: "development_tokenization_key")!
        }
    }

    @objc override func fetchPaymentMethodNonces(_ defaultFirst: Bool, completion: @escaping ([BTPaymentMethodNonce]?, Error?) -> Void) {
        completion(vaultedPaymentMethodNonces, vaultedPaymentMethodNoncesError)
    }
    
    @objc override func fetchOrReturnRemoteConfiguration(_ completionBlock: @escaping (BTConfiguration?, Error?) -> Void) {
        let fakeConfigBody = """
        {
            "assetsUrl": "https://assets.braintreegateway.com",
            "environment": "sandbox",
            "merchantId": "fake-id"
        }
        """.data(using: .utf8)!
        
        completionBlock(BTConfiguration(json: BTJSON(data: fakeConfigBody)), nil)
    }
}
