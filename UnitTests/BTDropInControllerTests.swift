import XCTest

class BTDropInControllerTests: XCTestCase {
    
    func testInitWithAuthorization_createsThreeDSecureRequest_whenAmountIsSet_andThreeDSecureIsRequested() {
        let dropInRequest = BTDropInRequest()
        dropInRequest.amount = "12.54"
        dropInRequest.threeDSecureVerification = true
        
        let dropInController = BTDropInController(authorization: "development_tokenization_key",
                                                  request: dropInRequest,
                                                  handler: nil)
        
        XCTAssertEqual(dropInController?.dropInRequest.threeDSecureRequest?.amount, NSDecimalNumber(string: "12.54"))
    }
    
    func testInitWithAuthorization_doesNotCreateThreeDSecureRequest_whenThreeDSecureIsNotRequested() {
        let dropInRequest = BTDropInRequest()
        dropInRequest.amount = "12.54"
        dropInRequest.threeDSecureVerification = false
        
        let dropInController = BTDropInController(authorization: "development_tokenization_key",
                                                  request: dropInRequest,
                                                  handler: nil)
        
        XCTAssertNil(dropInController?.dropInRequest.threeDSecureRequest)
    }
    
    func testInitWithAuthorization_doesNotCreateThreeDSecureRequest_whenAmountIsNotSet() {
        let dropInRequest = BTDropInRequest()
        dropInRequest.threeDSecureVerification = true
        
        let dropInController = BTDropInController(authorization: "development_tokenization_key",
                                                  request: dropInRequest,
                                                  handler: nil)
        
        XCTAssertNil(dropInController?.dropInRequest.threeDSecureRequest)
    }
    
    func testInitWithAuthorization_doesNotOverrideThreeDSecureRequest_whenThreeDSecureRequestAlreadyExists() {
        let dropInRequest = BTDropInRequest()
        dropInRequest.amount = "12.54"
        dropInRequest.threeDSecureVerification = true
        
        let threeDSecureRequest = BTThreeDSecureRequest()
        threeDSecureRequest.amount = NSDecimalNumber(string: "100.34")
        dropInRequest.threeDSecureRequest = threeDSecureRequest
        
        let dropInController = BTDropInController(authorization: "development_tokenization_key",
                                                  request: dropInRequest,
                                                  handler: nil)
        
        XCTAssertEqual(dropInController?.dropInRequest.threeDSecureRequest?.amount, NSDecimalNumber(string: "100.34"))
    }
}
