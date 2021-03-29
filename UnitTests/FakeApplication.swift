import UIKit

@objcMembers
class FakeApplication: NSObject {
    var lastOpenURL: URL? = nil
    var openURLWasCalled: Bool = false
    var cannedOpenURLSuccess: Bool = true
    var cannedCanOpenURL: Bool = true
    var canOpenURLWhitelist: [URL] = []

    func openURL(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler completion: ((Bool) -> Void)?) {
        lastOpenURL = url
        openURLWasCalled = true
        completion?(cannedOpenURLSuccess)
    }

    func canOpenURL(_ url: URL) -> Bool {
        for whitelistURL in canOpenURLWhitelist {
            if whitelistURL.scheme == url.scheme {
                return true
            }
        }
        return cannedCanOpenURL
    }
}
