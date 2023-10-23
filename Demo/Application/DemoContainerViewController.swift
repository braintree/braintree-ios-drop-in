import BraintreeDropIn
import InAppSettingsKit
import SwiftUI

class DemoContainerViewController: UIViewController {
    
    private var statusItem: UIBarButtonItem?
    
    private var currentPaymentMethodNonce: BTPaymentMethodNonce? {
        didSet {
            statusItem?.isEnabled = (currentPaymentMethodNonce != nil)
        }
    }
    
    private var currentViewController: UIViewController? {
        didSet {
            guard let currentVC = currentViewController else {
                updateStatusItem("Demo not available")
                return
            }

            updateStatusItem("Presenting \(type(of: currentVC))")
            title = currentVC.title

            addChild(currentVC)
            view.addSubview(currentVC.view)

            currentVC.view.pinToEdges(of: self)
            currentVC.didMove(toParent: self)

            guard let current = currentVC as? DemoBaseViewController else {
                return
            }

            current.progressBlock = progressBlock
            current.completionBlock = completionBlock
            current.transactionBlock = tappedStatus
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Braintree", comment: "")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                           target: self,
                                                           action: #selector(reloadIntegration))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Settings", comment: ""),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(tappedSettings))
        
        if #available(iOS 13, *) {
            view.backgroundColor = UIColor.systemBackground
        } else {
            view.backgroundColor = UIColor.white
        }
        
        navigationController?.setToolbarHidden(false, animated: false)
        
        let button = UIButton(type: .custom)
        button.setTitle(NSLocalizedString("Ready", comment: ""), for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.frame = navigationController!.navigationBar.bounds
        button.addTarget(self, action: #selector(tappedStatus), for: .touchUpInside)

        if #available(iOS 15, *) {
            navigationController?.toolbar.scrollEdgeAppearance = navigationController?.toolbar.standardAppearance
        }
        
        statusItem = UIBarButtonItem(customView: button)
        statusItem?.isEnabled = false
        
        let flexSpaceLeft = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let flexSpaceRight = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbarItems = [flexSpaceLeft, statusItem!, flexSpaceRight]
        
        reloadIntegration()
    }
    
    @objc func reloadIntegration() {
        if let current = currentViewController {
            current.willMove(toParent: nil)
            current.removeFromParent()
            current.view.removeFromSuperview()
        }
        
        title = NSLocalizedString("Braintree", comment: "")
        
        switch DemoSettings.demoAuthType {
        case .clientToken:
            updateStatusItem("Fetching Client Token...")
            
            DemoMerchantAPIClient.shared.createCustomerAndFetchClientToken { clientToken, error in
                guard let clientToken else {
                    self.updateStatusItem(error?.localizedDescription ?? "An unknown error occurred.")
                    return
                }
                
                self.currentViewController = self.instantiateCurrentViewController(with: clientToken)
            }
        case .tokenizationKey:
            let tokenizationKey: String

            switch DemoSettings.currentEnvironment {
            case .sandbox:
                tokenizationKey = "sandbox_9dbg82cq_dcpspy2brwdjr3qn"
            case .production:
                tokenizationKey = "production_t2wns2y2_dfy45jdj3dxkmz5m"
            default:
                tokenizationKey = "development_testing_integration_merchant_id"
            }
            
            currentViewController = instantiateCurrentViewController(with: tokenizationKey)
        case .mockedPayPalTokenizationKey:
            updateStatusItem("Using Tokenization Key")

            let tokenizationKey: String

            tokenizationKey = "sandbox_q7v35n9n_555d2htrfsnnmfb3"
            currentViewController = instantiateCurrentViewController(with: tokenizationKey)
        case .uiTestHardcodedClientTokenWithCustomerID:
            let uiTestClientTokenWithCustomerID = "eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiJleUowZVhBaU9pSktWMVFpTENKaGJHY2lPaUpGVXpJMU5pSXNJbXRwWkNJNklqSXdNVGd3TkRJMk1UWXRjMkZ1WkdKdmVDSXNJbWx6Y3lJNkltaDBkSEJ6T2k4dllYQnBMbk5oYm1SaWIzZ3VZbkpoYVc1MGNtVmxaMkYwWlhkaGVTNWpiMjBpZlEuZXlKbGVIQWlPakUyT1RneE56ZzBNamtzSW1wMGFTSTZJamcxTVdKaU9XSmxMV05sT1RRdE5EZG1OeTFoWlRObExUSTBOekk1WlRObE1qazBNeUlzSW5OMVlpSTZJbVJqY0hOd2VUSmljbmRrYW5JemNXNGlMQ0pwYzNNaU9pSm9kSFJ3Y3pvdkwyRndhUzV6WVc1a1ltOTRMbUp5WVdsdWRISmxaV2RoZEdWM1lYa3VZMjl0SWl3aWJXVnlZMmhoYm5RaU9uc2ljSFZpYkdsalgybGtJam9pWkdOd2MzQjVNbUp5ZDJScWNqTnhiaUlzSW5abGNtbG1lVjlqWVhKa1gySjVYMlJsWm1GMWJIUWlPblJ5ZFdWOUxDSnlhV2RvZEhNaU9sc2liV0Z1WVdkbFgzWmhkV3gwSWwwc0luTmpiM0JsSWpwYklrSnlZV2x1ZEhKbFpUcFdZWFZzZENKZExDSnZjSFJwYjI1eklqcDdJbU4xYzNSdmJXVnlYMmxrSWpvaU1TSjlmUS5BRS1CVGJ2bnBaN0lnLUExRmt3V2tUaEsxLVhlX0NCUE9Mc0puTlEyVjgyQ0NIUVBscnRtd0RVcnZQbjdxcksxXzhnZ2VZQ0VaTU1rREh6c2twanB2dz9jdXN0b21lcl9pZD0iLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvZGNwc3B5MmJyd2RqcjNxbi9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJncmFwaFFMIjp7InVybCI6Imh0dHBzOi8vcGF5bWVudHMuc2FuZGJveC5icmFpbnRyZWUtYXBpLmNvbS9ncmFwaHFsIiwiZGF0ZSI6IjIwMTgtMDUtMDgiLCJmZWF0dXJlcyI6WyJ0b2tlbml6ZV9jcmVkaXRfY2FyZHMiXX0sImhhc0N1c3RvbWVyIjp0cnVlLCJjbGllbnRBcGlVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvZGNwc3B5MmJyd2RqcjNxbi9jbGllbnRfYXBpIiwiZW52aXJvbm1lbnQiOiJzYW5kYm94IiwibWVyY2hhbnRJZCI6ImRjcHNweTJicndkanIzcW4iLCJhc3NldHNVcmwiOiJodHRwczovL2Fzc2V0cy5icmFpbnRyZWVnYXRld2F5LmNvbSIsImF1dGhVcmwiOiJodHRwczovL2F1dGgudmVubW8uc2FuZGJveC5icmFpbnRyZWVnYXRld2F5LmNvbSIsInZlbm1vIjoib2ZmbGluZSIsImNoYWxsZW5nZXMiOlsiY3Z2IiwicG9zdGFsX2NvZGUiXSwidGhyZWVEU2VjdXJlRW5hYmxlZCI6dHJ1ZSwiYW5hbHl0aWNzIjp7InVybCI6Imh0dHBzOi8vb3JpZ2luLWFuYWx5dGljcy1zYW5kLnNhbmRib3guYnJhaW50cmVlLWFwaS5jb20vZGNwc3B5MmJyd2RqcjNxbiJ9LCJhcHBsZVBheSI6eyJjb3VudHJ5Q29kZSI6IlVTIiwiY3VycmVuY3lDb2RlIjoiVVNEIiwibWVyY2hhbnRJZGVudGlmaWVyIjoibWVyY2hhbnQuY29tLmJyYWludHJlZXBheW1lbnRzLmFwcGxlLXBheS1kZW1vLkJyYWludHJlZS1EZW1vIiwic3RhdHVzIjoibW9jayIsInN1cHBvcnRlZE5ldHdvcmtzIjpbInZpc2EiLCJtYXN0ZXJjYXJkIiwiYW1leCIsImRpc2NvdmVyIiwibWFlc3RybyJdfSwicGF5cGFsRW5hYmxlZCI6dHJ1ZSwiYnJhaW50cmVlX2FwaSI6eyJ1cmwiOiJodHRwczovL3BheW1lbnRzLnNhbmRib3guYnJhaW50cmVlLWFwaS5jb20iLCJhY2Nlc3NfdG9rZW4iOiJleUowZVhBaU9pSktWMVFpTENKaGJHY2lPaUpGVXpJMU5pSXNJbXRwWkNJNklqSXdNVGd3TkRJMk1UWXRjMkZ1WkdKdmVDSXNJbWx6Y3lJNkltaDBkSEJ6T2k4dllYQnBMbk5oYm1SaWIzZ3VZbkpoYVc1MGNtVmxaMkYwWlhkaGVTNWpiMjBpZlEuZXlKbGVIQWlPakUyT1RneE56ZzBNekFzSW1wMGFTSTZJakJsT0dKbU1UaGlMV0prTUdVdE5EZzVZeTA0T0dVM0xUZ3hOemczTWpBME16ZGtaaUlzSW5OMVlpSTZJbVJqY0hOd2VUSmljbmRrYW5JemNXNGlMQ0pwYzNNaU9pSm9kSFJ3Y3pvdkwyRndhUzV6WVc1a1ltOTRMbUp5WVdsdWRISmxaV2RoZEdWM1lYa3VZMjl0SWl3aWJXVnlZMmhoYm5RaU9uc2ljSFZpYkdsalgybGtJam9pWkdOd2MzQjVNbUp5ZDJScWNqTnhiaUlzSW5abGNtbG1lVjlqWVhKa1gySjVYMlJsWm1GMWJIUWlPblJ5ZFdWOUxDSnlhV2RvZEhNaU9sc2lkRzlyWlc1cGVtVWlMQ0p0WVc1aFoyVmZkbUYxYkhRaVhTd2ljMk52Y0dVaU9sc2lRbkpoYVc1MGNtVmxPbFpoZFd4MElsMHNJbTl3ZEdsdmJuTWlPbnQ5ZlEuMlk0OHdOTk05RmN0ZDdYTjdrSVdBNEYzZVYxNW13bUJIRFczVzZZVk1OVmRxSW1VVEZqcEhqUnFQWnhQdUZMMGVSSUYyeDFaNTh2OEtPLXV3MjMwNEEifSwicGF5cGFsIjp7ImJpbGxpbmdBZ3JlZW1lbnRzRW5hYmxlZCI6dHJ1ZSwiZW52aXJvbm1lbnROb05ldHdvcmsiOnRydWUsInVudmV0dGVkTWVyY2hhbnQiOmZhbHNlLCJhbGxvd0h0dHAiOnRydWUsImRpc3BsYXlOYW1lIjoiQWNtZSBXaWRnZXRzLCBMdGQuIChTYW5kYm94KSIsImNsaWVudElkIjoiQWI0VGpySElyNmoxaElVY1RhWlpCYmZMZUFaOXFfUUFSalBhRVU1dnpNMVBSYl9kRTNHTjNaT0tITG9yX2VJZ1pFazNXTzNLMVdUMTlUWDYiLCJiYXNlVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhc3NldHNVcmwiOiJodHRwczovL2NoZWNrb3V0LnBheXBhbC5jb20iLCJkaXJlY3RCYXNlVXJsIjpudWxsLCJlbnZpcm9ubWVudCI6Im9mZmxpbmUiLCJicmFpbnRyZWVDbGllbnRJZCI6Im1hc3RlcmNsaWVudDMiLCJtZXJjaGFudEFjY291bnRJZCI6InN0Y2gybmZkZndzenl0dzUiLCJjdXJyZW5jeUlzb0NvZGUiOiJVU0QifX0="
            currentViewController = instantiateCurrentViewController(with: uiTestClientTokenWithCustomerID)
        case .uiTestHardcodedClientTokenWithoutCustomerID:
            let uiTestClientTokenWithoutCustomerID = "eyJ2ZXJzaW9uIjozLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiIxYzM5N2E5OGZmZGRkNDQwM2VjNzEzYWRjZTI3NTNiMzJlODc2MzBiY2YyN2M3NmM2OWVmZjlkMTE5MjljOTVkfGNyZWF0ZWRfYXQ9MjAxNy0wNC0wNVQwNjowNzowOC44MTUwOTkzMjUrMDAwMFx1MDAyNm1lcmNoYW50X2lkPWRjcHNweTJicndkanIzcW5cdTAwMjZwdWJsaWNfa2V5PTl3d3J6cWszdnIzdDRuYzgiLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvZGNwc3B5MmJyd2RqcjNxbi9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24ifQ=="
            currentViewController = instantiateCurrentViewController(with: uiTestClientTokenWithoutCustomerID)
        }
    }

    func instantiateCurrentViewController(with authorization: String) -> UIViewController? {
        switch DemoSettings.currentUIFramework {
        case .uikit:
            return DemoDropInViewController(authorization: authorization)
        case .swiftui:
            if #available(iOS 13, *) {
                return UIHostingController(rootView: ContentView())
            } else {
                return nil
            }
        }
    }

    func updateStatusItem(_ status: String) {
        let button = statusItem?.customView as? UIButton
        button?.setTitle(status, for: .normal)
        if #available(iOS 13, *) {
            button?.setTitleColor(UIColor.label, for: .normal)
        }
        print(status)
    }
    
    // MARK: - Progress and completion blocks
    
    func progressBlock(_ status: String?) {
        guard let status = status else { return }
        updateStatusItem(status)
    }
    
    func completionBlock(_ nonce: BTPaymentMethodNonce?) {
        currentPaymentMethodNonce = nonce
        updateStatusItem("Got a nonce. Tap to make a transaction.")
    }
    
    // MARK: - Actions
    
    @objc func tappedSettings() {
        let settingsViewController = IASKAppSettingsViewController()
        settingsViewController.delegate = self
        
        let navigationController = UINavigationController(rootViewController: settingsViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc func tappedStatus() {
        print("Tapped status!")
        guard let paymentMethod = currentPaymentMethodNonce else { return }
        
        updateStatusItem("Creating Transaction...")
        
        let merchantAccountId = (paymentMethod.type == "UnionPay") ? "fake_switch_usd" : nil
        
        DemoMerchantAPIClient.shared.makeTransaction(paymentMethodNonce: paymentMethod.nonce, merchantAccountId: merchantAccountId) { (transactionId, error) in
            self.currentPaymentMethodNonce = nil
            
            guard let id = transactionId else {
                self.updateStatusItem(error?.localizedDescription ?? "An unknown error occurred.")
                return
            }
            
            self.updateStatusItem(id)
        }
    }
}

// MARK: - IASKSettingsDelegate
extension DemoContainerViewController: IASKSettingsDelegate {
    func settingsViewControllerDidEnd(_ sender: IASKAppSettingsViewController) {
        sender.dismiss(animated: true)
        reloadIntegration()
    }
}
