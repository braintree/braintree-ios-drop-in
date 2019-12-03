import Foundation

enum DemoEnvironment: Int {
    case sandbox
    case production
    case custom
}

enum DemoThreeDSecureRequiredSetting: Int {
    case requiredIfAttempted
    case required
    case optional
}

class DemoSettings {
    
    static let EnvironmentDefaultsKey = "BraintreeDemoSettingsEnvironmentDefaultsKey"
    static let CustomEnvironmentURLDefaultsKey = "BraintreeDemoSettingsCustomEnvironmentURLDefaultsKey"
    static let ThreeDSecureRequiredDefaultsKey = "BraintreeDemoSettingsThreeDSecureRequiredDefaultsKey"
    static let ThreeDSecureVersionDefaultsKey = "BraintreeDemoSettingsThreeDSecureVersionDefaultsKey"
    
    static var currentEnvironment: DemoEnvironment {
        return DemoEnvironment(rawValue: UserDefaults.standard.integer(forKey: EnvironmentDefaultsKey)) ?? DemoEnvironment.sandbox
    }
    
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
    
    static var authorizationOverride: String? {
        return UserDefaults.standard.string(forKey: "BraintreeDemoSettingsAuthorizationOverride")
    }
    
    static var useTokenizationKey: Bool {
        return UserDefaults.standard.bool(forKey: "BraintreeDemoUseTokenizationKey")
    }
    
    static var threeDSecureRequiredStatus: DemoThreeDSecureRequiredSetting {
        return DemoThreeDSecureRequiredSetting(rawValue: UserDefaults.standard.integer(forKey: ThreeDSecureRequiredDefaultsKey)) ?? .requiredIfAttempted
    }
    
    static var threeDSecureRequestedVersion: BTThreeDSecureVersion {
        return BTThreeDSecureVersion(rawValue: UserDefaults.standard.integer(forKey: ThreeDSecureVersionDefaultsKey)) ?? .version2
    }
    
    static var useModalPresentation: Bool {
        return UserDefaults.standard.bool(forKey: "BraintreeDemoChooserViewControllerShouldUseModalPresentationDefaultsKey")
    }
    
    static var customerPresent: Bool {
        return UserDefaults.standard.bool(forKey: "BraintreeDemoCustomerPresent")
    }
    
    static var customerIdentifier: String? {
        return UserDefaults.standard.string(forKey: "BraintreeDemoCustomerIdentifier")
    }

    @objc
    static var createVaultedPaymentMethod: Bool {
        return UserDefaults.standard.bool(forKey: "BraintreeDemoCreateVaultedPaymentMethod")
    }

    @objc
    static var createVaulted3DS2PaymentMethod: Bool {
        return UserDefaults.standard.bool(forKey: "BraintreeDemoCreateVaulted3DS2PaymentMethod")
    }
    
    static var paypalDisabled: Bool {
        return UserDefaults.standard.bool(forKey: "BraintreeDemoDisablePayPal")
    }
    
    static var venmoDisabled: Bool {
        return UserDefaults.standard.bool(forKey: "BraintreeDemoDisableVenmo")
    }
    
    static var maskSecurityCode: Bool {
        return UserDefaults.standard.bool(forKey: "BraintreeDemoMaskSecurityCode")
    }
    
    static var cardholderNameSetting: BTFormFieldSetting {
        return BTFormFieldSetting(rawValue: UserDefaults.standard.integer(forKey: "BraintreeDemoCardholderNameSetting")) ?? .disabled
    }
    
    static var vaultCardSetting: Bool {
        return UserDefaults.standard.bool(forKey: "BraintreeDemoVaultCardSetting")
    }
    
    static var allowVaultCardOverrideSetting: Bool {
        return UserDefaults.standard.bool(forKey: "BraintreeDemoAllowVaultCardOverrideSetting")
    }
    
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
