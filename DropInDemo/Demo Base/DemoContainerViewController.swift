import UIKit

class DemoContainerViewController: UIViewController {
    
    private var statusItem: UIBarButtonItem?
    
    private var currentPaymentMethodNonce: BTPaymentMethodNonce? {
        didSet {
            statusItem?.isEnabled = (currentPaymentMethodNonce != nil)
        }
    }
    
    private var currentViewController: DemoBaseViewController? {
        didSet {
            guard let current = currentViewController else {
                updateStatusItem("Demo not available")
                return
            }

            current.progressBlock = progressBlock
            current.completionBlock = completionBlock
            current.transactionBlock = tappedStatus
            
            updateStatusItem("Presenting \(current.self)")
            title = current.title
            
            addChild(current)
            view.addSubview(current.view)
            
            current.view.pinToEdges(of: self)
            current.didMove(toParent: self)
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
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.frame = navigationController!.navigationBar.bounds
        button.addTarget(self, action: #selector(tappedStatus), for: .touchUpInside)
        
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
        
        if let auth = DemoSettings.authorizationOverride {
            currentViewController = DemoDropInViewController(authorization: auth)
        } else if DemoSettings.useTokenizationKey {
            updateStatusItem("Using Tokenization Key")
            
            let tokenizationKey: String
            switch DemoSettings.currentEnvironment {
            case .sandbox:
                tokenizationKey = "sandbox_9dbg82cq_dcpspy2brwdjr3qn"
            case .production:
                tokenizationKey = "production_t2wns2y2_dfy45jdj3dxkmz5m"
            default:
                tokenizationKey = "development_testing_integration_merchant_id"
            }
            
            currentViewController = DemoDropInViewController(authorization: tokenizationKey)
        } else {
            updateStatusItem("Fetching Client Token...")
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            DemoMerchantAPIClient.shared.createCustomerAndFetchClientToken { (clientToken, error) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                guard let token = clientToken else {
                    self.updateStatusItem(error?.localizedDescription ?? "An unknown error occurred.")
                    return
                }
                
                self.currentViewController = DemoDropInViewController(authorization: token)
            }
        }
    }
    
    func updateStatusItem(_ status: String) {
        let button = statusItem?.customView as? UIButton
        button?.setTitle(status, for: .normal)
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
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let merchantAccountId = (paymentMethod.type == "UnionPay") ? "fake_switch_usd" : nil
        
        DemoMerchantAPIClient.shared.makeTransaction(paymentMethodNonce: paymentMethod.nonce, merchantAccountId: merchantAccountId) { (transactionId, error) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
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
    func settingsViewControllerDidEnd(_ sender: IASKAppSettingsViewController!) {
        sender.dismiss(animated: true)
        reloadIntegration()
    }
}
