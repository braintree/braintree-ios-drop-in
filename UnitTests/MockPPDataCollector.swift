import Foundation
@testable import PayPalDataCollector

class MockPPDataCollector: PPDataCollector {

    public static var didCollectDeviceData = false
    
    public static var isSandbox: Bool = false

    override class func collectPayPalDeviceData() -> String {
        didCollectDeviceData = true
        return "{\"correlation_id\":\"fake-client-metadata\"}"
    }
    
    override class func collectPayPalDeviceData(isSandbox: Bool) -> String {
        MockPPDataCollector.isSandbox = isSandbox
        didCollectDeviceData = true
        return "{\"correlation_id\":\"fake-client-metadata\"}"
    }
}
