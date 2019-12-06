import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let returnURLScheme = "com.braintreepayments.DropInDemoSwiftUI.payments"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        BTAppSwitch.setReturnURLScheme(returnURLScheme)
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        guard url.scheme?.lowercased() == returnURLScheme.lowercased() else { return true }
        return BTAppSwitch.handleOpen(url, options: options)
    }
}
