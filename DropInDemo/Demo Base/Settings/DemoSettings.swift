import Foundation

@objc
enum DemoEnvironment: Int {
    case sandbox
    case production
    case custom
}

@objc
enum DemoThreeDSecureRequiredSetting: Int {
    case requiredIfAttempted
    case required
    case optional
}

@objc
class DemoSettings: NSObject {

    @objc static let EnvironmentDefaultsKey = "BraintreeDemoSettingsEnvironmentDefaultsKey"
    @objc static let CustomEnvironmentURLDefaultsKey = "BraintreeDemoSettingsCustomEnvironmentURLDefaultsKey"
    @objc static let ThreeDSecureRequiredDefaultsKey = "BraintreeDemoSettingsThreeDSecureRequiredDefaultsKey"
    @objc static let ThreeDSecureVersionDefaultsKey = "BraintreeDemoSettingsThreeDSecureVersionDefaultsKey"
    
    @objc
    static var currentEnvironment: DemoEnvironment {
        return DemoEnvironment(rawValue: UserDefaults.standard.integer(forKey: EnvironmentDefaultsKey)) ?? DemoEnvironment.sandbox
    }
    
    @objc
    static var currentEnvironmentName: String {
        switch currentEnvironment {
        case .sandbox:
            return "Sandbox"
        case .production:
            return "Production"
        case .custom:
            guard var name = UserDefaults.standard.string(forKey: CustomEnvironmentURLDefaultsKey) else {
                return "(invalid)"
            }
            name = name.replacingOccurrences(of: "http://", with: "")
            name = name.replacingOccurrences(of: "https://", with: "")
            return name
        }
    }
    
    @objc
    static var currentEnvironmentURLString: String {
        switch currentEnvironment {
        case .sandbox:
            return "https://braintree-sample-merchant.herokuapp.com"
        case .production:
            return "https://executive-sample-merchant.herokuapp.com"
        case .custom:
            return UserDefaults.standard.string(forKey: EnvironmentDefaultsKey) ?? ""
        }
    }
    
    @objc
    static var authorizationOverride: String? {
        return UserDefaults.standard.string(forKey: "BraintreeDemoSettingsAuthorizationOverride")
    }
    
    @objc
    static var useTokenizationKey: Bool {
        return UserDefaults.standard.bool(forKey: "BraintreeDemoUseTokenizationKey")
    }
    
    @objc
    static var threeDSecureRequiredStatus: DemoThreeDSecureRequiredSetting {
        return DemoThreeDSecureRequiredSetting(rawValue: UserDefaults.standard.integer(forKey: ThreeDSecureRequiredDefaultsKey)) ?? .requiredIfAttempted
    }
    
    @objc
    static var threeDSecureRequestedVersion: BTThreeDSecureVersion {
        return BTThreeDSecureVersion(rawValue: UserDefaults.standard.integer(forKey: ThreeDSecureVersionDefaultsKey)) ?? .version2
    }
    
    @objc
    static var useModalPresentation: Bool {
        return UserDefaults.standard.bool(forKey: "BraintreeDemoChooserViewControllerShouldUseModalPresentationDefaultsKey")
    }
    
    @objc
    static var customerPresent: Bool {
        return UserDefaults.standard.bool(forKey: "BraintreeDemoCustomerPresent")
    }
    
    @objc
    static var customerIdentifier: String? {
        return UserDefaults.standard.string(forKey: "BraintreeDemoCustomerIdentifier")
    }
    
    @objc
    static var paypalDisabled: Bool {
        return UserDefaults.standard.bool(forKey: "BraintreeDemoDisablePayPal")
    }
    
    @objc
    static var venmoDisabled: Bool {
        return UserDefaults.standard.bool(forKey: "BraintreeDemoDisableVenmo")
    }
    
    @objc
    static var maskSecurityCode: Bool {
        return UserDefaults.standard.bool(forKey: "BraintreeDemoMaskSecurityCode")
    }
    
    @objc
    static var cardholderNameSetting: BTFormFieldSetting {
        return BTFormFieldSetting(rawValue: UserDefaults.standard.integer(forKey: "BraintreeDemoCardholderNameSetting")) ?? .disabled
    }
    
    @objc
    static var vaultCardSetting: Bool {
        return UserDefaults.standard.bool(forKey: "BraintreeDemoVaultCardSetting")
    }
    
    @objc
    static var allowVaultCardOverrideSetting: Bool {
        return UserDefaults.standard.bool(forKey: "BraintreeDemoAllowVaultCardOverrideSetting")
    }
    
    @objc
    static var colorSchemeSetting: BTUIKColorScheme {
        get {
            return BTUIKColorScheme(rawValue: UserDefaults.standard.integer(forKey: "BraintreeDemoColorSchemeSetting")) ?? .light
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "BraintreeDemoColorSchemeSetting")
        }
    }
    
    static var applePayMerchantIdentifier: String? {
        switch (currentEnvironment) {
        case .sandbox:
            return "merchant.com.braintreepayments.sandbox.Braintree-Demo"
        case .production:
            return "merchant.com.braintreepayments.Braintree-Demo"
        case .custom:
            return nil
        }
    }
}
