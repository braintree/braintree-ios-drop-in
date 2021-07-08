import Foundation
@testable import PayPalDataCollector

class MockPPDataCollector: PPDataCollector {

    public static var didCollectDeviceData = false

    override class func collectPayPalDeviceData() -> String {
        didCollectDeviceData = true
        return "{\"correlation_id\":\"fake-client-metadata\"}"
    }
}
