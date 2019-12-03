import UIKit

@UIApplicationMain
class DemoAppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private let BraintreeDemoAppDelegatePaymentsURLScheme = "com.braintreepayments.DropInDemo.payments"
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let appearanceProxy = UIToolbar.appearance()
        appearanceProxy.barTintColor = UIColor(white: 42.0 / 255.0, alpha: 1.0)
        appearanceProxy.barStyle = .blackTranslucent

        registerUserDefaults()
        
        let rootViewController = DemoContainerViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        guard url.scheme?.lowercased() == BraintreeDemoAppDelegatePaymentsURLScheme.lowercased() else { return true }
        return BTAppSwitch.handleOpen(url, options: options)
    }
    
    private func registerUserDefaults() {
        let testArguments = ProcessInfo.processInfo.arguments
        
        if testArguments.contains("-EnvironmentSandbox") {
            UserDefaults.standard.set(DemoEnvironment.sandbox.rawValue, forKey:DemoSettings.EnvironmentDefaultsKey)
        } else if testArguments.contains("-EnvironmentProduction") {
            UserDefaults.standard.set(DemoEnvironment.production, forKey:DemoSettings.EnvironmentDefaultsKey)
        }
        
        if testArguments.contains("-ThreeDSecureRequired") {
            UserDefaults.standard.set(DemoThreeDSecureRequiredSetting.required.rawValue, forKey:DemoSettings.ThreeDSecureRequiredDefaultsKey)
        } else if testArguments.contains("-ThreeDSecureDefault") {
            UserDefaults.standard.set(DemoThreeDSecureRequiredSetting.requiredIfAttempted.rawValue, forKey:DemoSettings.ThreeDSecureRequiredDefaultsKey)
        }
        
        if testArguments.contains("-ThreeDSecureVersion2") {
            UserDefaults.standard.set(BTThreeDSecureVersion.version2.rawValue, forKey:DemoSettings.ThreeDSecureVersionDefaultsKey)
        } else if testArguments.contains("-ThreeDSecureVersionLegacy") {
            UserDefaults.standard.set(BTThreeDSecureVersion.version1.rawValue, forKey:DemoSettings.ThreeDSecureVersionDefaultsKey)
        }
        
        if testArguments.contains("-TokenizationKey") {
            UserDefaults.standard.set(true, forKey:"BraintreeDemoUseTokenizationKey")
        } else if testArguments.contains("-ClientToken") {
            UserDefaults.standard.set(false, forKey:"BraintreeDemoUseTokenizationKey")
            // Use random users for testing with Client Tokens
            UserDefaults.standard.set(true, forKey:"BraintreeDemoCustomerPresent")
            UserDefaults.standard.set("", forKey:"BraintreeDemoCustomerIdentifier")
        }

        if testArguments.contains("-CreateVaultedPaymentMethod") {
            UserDefaults.standard.set(true, forKey:"BraintreeDemoCreateVaultedPaymentMethod")
        } else {
            UserDefaults.standard.set(false, forKey:"BraintreeDemoCreateVaultedPaymentMethod")
        }

        if testArguments.contains("-CreateVaulted3DS2PaymentMethod") {
            UserDefaults.standard.set(true, forKey:"BraintreeDemoCreateVaulted3DS2PaymentMethod")
        } else {
            UserDefaults.standard.set(false, forKey:"BraintreeDemoCreateVaulted3DS2PaymentMethod")
        }
        
        UserDefaults.standard.set(false, forKey:"BraintreeDemoDisablePayPal")
        if testArguments.contains("-DisablePayPal") {
            UserDefaults.standard.set(true, forKey:"BraintreeDemoDisablePayPal")
        }
        
        UserDefaults.standard.set(false, forKey:"BraintreeDemoDisableVenmo")
        if testArguments.contains("-DisableVenmo") {
            UserDefaults.standard.set(true, forKey:"BraintreeDemoDisableVenmo")
        }
        
        UserDefaults.standard.set(false, forKey:"BraintreeDemoMaskSecurityCode")
        if testArguments.contains("-MaskSecurityCode") {
            UserDefaults.standard.set(true, forKey:"BraintreeDemoMaskSecurityCode")
        }
        
        UserDefaults.standard.set(BTFormFieldSetting.disabled.rawValue, forKey:"BraintreeDemoCardholderNameSetting")
        if testArguments.contains("-CardholderNameAccepted") {
            UserDefaults.standard.set(BTFormFieldSetting.optional.rawValue, forKey:"BraintreeDemoCardholderNameSetting")
        } else if testArguments.contains("-CardholderNameRequired") {
            UserDefaults.standard.set(BTFormFieldSetting.required.rawValue, forKey:"BraintreeDemoCardholderNameSetting")
        }
        
        UserDefaults.standard.set(false, forKey:"BraintreeDemoAllowVaultCardOverrideSetting")
        if testArguments.contains("-SaveCardToggleVisible") {
            UserDefaults.standard.set(true, forKey:"BraintreeDemoAllowVaultCardOverrideSetting")
        }
        
        UserDefaults.standard.set(true, forKey:"BraintreeDemoVaultCardSetting")
        if testArguments.contains("-VaultCardIsFalse") {
            UserDefaults.standard.set(false, forKey:"BraintreeDemoVaultCardSetting")
        }
        
        UserDefaults.standard.removeObject(forKey: "BraintreeTest_ForceVenmoDisplay")
        if testArguments.contains("-ForceVenmo") {
            BTDropInOverrides.displayVenmoOption = true
        }
        
        UserDefaults.standard.removeObject(forKey: "BraintreeDemoSettingsAuthorizationOverride")
        for arg in testArguments {
            if arg.contains("-Authorization:") {
                let testIntegration = arg.replacingOccurrences(of: "-Authorization:", with: "")
                UserDefaults.standard.set(testIntegration, forKey: "BraintreeDemoSettingsAuthorizationOverride")
            }
        }
        
        if testArguments.contains("-BadUrlScheme") {
            BTAppSwitch.setReturnURLScheme("com.braintreepayments.bad.scheme")
        } else {
            BTAppSwitch.setReturnURLScheme(BraintreeDemoAppDelegatePaymentsURLScheme)
        }
        
        let settingsPlist = Bundle.main.url(forResource: "Settings", withExtension: "bundle")!.appendingPathComponent("Root.plist")
        let settingsDictionary = NSDictionary(contentsOf: settingsPlist)!
        let preferences = settingsDictionary["PreferenceSpecifiers"] as! [[String : Any]]
        
        var defaults: [String : Any] = [:]
        
        for preference in preferences {
            guard let key = preference["Key"] as? String else { continue }
            defaults[key] = preference["DefaultValue"]
        }
        UserDefaults.standard.register(defaults: defaults)
    }
}
