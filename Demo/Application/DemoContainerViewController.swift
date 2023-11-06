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
        case .uiTestHardcodedClientTokenWithoutCustomerID:
            let uiTestClientTokenWithoutCustomerID = "eyJ2ZXJzaW9uIjozLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiIxYzM5N2E5OGZmZGRkNDQwM2VjNzEzYWRjZTI3NTNiMzJlODc2MzBiY2YyN2M3NmM2OWVmZjlkMTE5MjljOTVkfGNyZWF0ZWRfYXQ9MjAxNy0wNC0wNVQwNjowNzowOC44MTUwOTkzMjUrMDAwMFx1MDAyNm1lcmNoYW50X2lkPWRjcHNweTJicndkanIzcW5cdTAwMjZwdWJsaWNfa2V5PTl3d3J6cWszdnIzdDRuYzgiLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvZGNwc3B5MmJyd2RqcjNxbi9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24ifQ=="
            currentViewController = instantiateCurrentViewController(with: uiTestClientTokenWithoutCustomerID)
        case .uiTestHardcodedClientTokenwithCVVValidationEnabled:
            let uiTestClientTokenWithCVV = "eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiI2ZGE5Y2VhMzVkNGNlMjkxNGI3YzBiOGRiN2M5OWU4MjVmYTQ5ZTY5OTNiYWM4YmE3MTQwYjdiZjI0ODc4NGQ0fGNyZWF0ZWRfYXQ9MjAxOC0wMy0xMlQyMTo0MzoxMS4wOTI1MzAxNDcrMDAwMCZjdXN0b21lcl9pZD01ODA3NDE3NzEmbWVyY2hhbnRfaWQ9aGg0Y3BjMzl6cTRyZ2pjZyZwdWJsaWNfa2V5PXEzanRzcTNkM3Aycmg1dnQiLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvaGg0Y3BjMzl6cTRyZ2pjZy9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJncmFwaFFMVXJsIjoiaHR0cHM6Ly9wYXltZW50cy5zYW5kYm94LmJyYWludHJlZS1hcGkuY29tL2dyYXBocWwiLCJjaGFsbGVuZ2VzIjpbImN2diJdLCJlbnZpcm9ubWVudCI6InNhbmRib3giLCJjbGllbnRBcGlVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvaGg0Y3BjMzl6cTRyZ2pjZy9jbGllbnRfYXBpIiwiYXNzZXRzVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhdXRoVXJsIjoiaHR0cHM6Ly9hdXRoLnZlbm1vLnNhbmRib3guYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhbmFseXRpY3MiOnsidXJsIjoiaHR0cHM6Ly9jbGllbnQtYW5hbHl0aWNzLnNhbmRib3guYnJhaW50cmVlZ2F0ZXdheS5jb20vaGg0Y3BjMzl6cTRyZ2pjZyJ9LCJ0aHJlZURTZWN1cmVFbmFibGVkIjp0cnVlLCJwYXlwYWxFbmFibGVkIjp0cnVlLCJwYXlwYWwiOnsiZGlzcGxheU5hbWUiOiJidCIsImNsaWVudElkIjoiQVZRSmY5YS1iNmptWUZnaW9OcEkyaTU3cnNRa0hqUlpadjRkOURaTFRVMG5CU3Vma2h3QUNBWnhqMGxkdTg1amFzTTAyakZSUEthVElOQ04iLCJwcml2YWN5VXJsIjoiaHR0cDovL2V4YW1wbGUuY29tL3BwIiwidXNlckFncmVlbWVudFVybCI6Imh0dHA6Ly9leGFtcGxlLmNvbS90b3MiLCJiYXNlVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhc3NldHNVcmwiOiJodHRwczovL2NoZWNrb3V0LnBheXBhbC5jb20iLCJkaXJlY3RCYXNlVXJsIjpudWxsLCJhbGxvd0h0dHAiOnRydWUsImVudmlyb25tZW50Tm9OZXR3b3JrIjpmYWxzZSwiZW52aXJvbm1lbnQiOiJvZmZsaW5lIiwidW52ZXR0ZWRNZXJjaGFudCI6ZmFsc2UsImJyYWludHJlZUNsaWVudElkIjoibWFzdGVyY2xpZW50MyIsImJpbGxpbmdBZ3JlZW1lbnRzRW5hYmxlZCI6dHJ1ZSwibWVyY2hhbnRBY2NvdW50SWQiOiJjNXljdzJzdnlrbnp3anR6IiwiY3VycmVuY3lJc29Db2RlIjoiVVNEIn0sIm1lcmNoYW50SWQiOiJoaDRjcGMzOXpxNHJnamNnIiwidmVubW8iOiJvZmYiLCJicmFpbnRyZWVfYXBpIjp7InVybCI6Imh0dHBzOi8vcGF5bWVudHMuc2FuZGJveC5icmFpbnRyZWUtYXBpLmNvbSIsImFjY2Vzc190b2tlbiI6InNhbmRib3hfNmRkdG13X3B6YjZ3cF93ZHdoY3lfOWhnNm5iX2N5NiJ9fQ=="
            currentViewController = instantiateCurrentViewController(with: uiTestClientTokenWithCVV)
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
