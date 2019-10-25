import UIKit
import PassKit

class DemoDropInViewController: DemoBaseViewController {
    
    private var paymentMethodTypeIcon = BTUIKPaymentOptionCardView()
    private var paymentMethodTypeLabel = UILabel()
    private var cartLabel = UILabel()
    private var itemLabel = UILabel()
    private var priceLabel = UILabel()
    private var paymentMethodHeaderLabel = UILabel()
    private var dropInButton = UIButton()
    private var purchaseButton = UIButton()
    private var colorSchemeLabel = UILabel()
    private var colorSchemeSegmentedControl = UISegmentedControl()
    
    private let authorization: String
    private var useApplePay: Bool = false
    private var selectedNonce: BTPaymentMethodNonce?
    private var checkoutConstraints: [NSLayoutConstraint] = []
    
    private var secondaryLabelColor: UIColor = {
        if #available(iOS 13, *) {
            return UIColor.secondaryLabel
        } else {
            return UIColor.gray
        }
    }()
    
    override init(authorization: String) {
        self.authorization = authorization
        super.init(authorization: authorization)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updatePaymentMethodNonce(_ nonce: BTPaymentMethodNonce?) {
        paymentMethodTypeLabel.isHidden = (nonce == nil)
        paymentMethodTypeIcon.isHidden = (nonce == nil)
        if let nonce = nonce {
            let paymentMethodType = BTUIKViewUtil.paymentOptionType(forPaymentInfoType: nonce.type)
            paymentMethodTypeIcon.paymentOptionType = paymentMethodType
            paymentMethodTypeLabel.text = nonce.localizedDescription
        }
        updatePaymentMethodConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartLabel.text = NSLocalizedString("CART", comment: "")
        cartLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        cartLabel.textColor = secondaryLabelColor
        cartLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cartLabel)
        
        itemLabel.text = NSLocalizedString("1 Sock", comment: "")
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(itemLabel)
        
        priceLabel.text = NSLocalizedString("$10", comment: "")
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(priceLabel)
        
        paymentMethodHeaderLabel.text = NSLocalizedString("PAYMENT METHODS", comment: "")
        paymentMethodHeaderLabel.textColor = secondaryLabelColor
        paymentMethodHeaderLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        paymentMethodHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(paymentMethodHeaderLabel)
        
        dropInButton.setTitle(NSLocalizedString("Select Payment Method", comment: ""), for: .normal)
        dropInButton.setTitleColor(view.tintColor, for: .normal)
        dropInButton.translatesAutoresizingMaskIntoConstraints = false
        dropInButton.addTarget(self, action: #selector(tappedToShowDropIn), for: .touchUpInside)
        view.addSubview(dropInButton)
        
        purchaseButton.setTitle(NSLocalizedString("Complete Purchase", comment: ""), for: .normal)
        purchaseButton.setTitleColor(UIColor.white, for: .normal)
        purchaseButton.setTitleColor(UIColor.white.withAlphaComponent(0.8), for: .highlighted)
        purchaseButton.backgroundColor = view.tintColor
        purchaseButton.translatesAutoresizingMaskIntoConstraints = false
        purchaseButton.layer.cornerRadius = 4.0
        purchaseButton.addTarget(self, action: #selector(purchaseButtonPressed), for: .touchUpInside)
        view.addSubview(purchaseButton)
        
        paymentMethodTypeIcon.isHidden = true
        paymentMethodTypeIcon.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(paymentMethodTypeIcon)
        
        paymentMethodTypeLabel.isHidden = true
        paymentMethodTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(paymentMethodTypeLabel)
        
        colorSchemeLabel.text = NSLocalizedString("COLOR SCHEME", comment: "")
        colorSchemeLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        colorSchemeLabel.textColor = secondaryLabelColor
        colorSchemeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(colorSchemeLabel)
        
        let colorSchemes: [String]
        if #available(iOS 13, *) {
            colorSchemes = ["Light", "Dark", "Dynamic"]
        } else {
            colorSchemes = ["Light", "Dark"]
        }
        
        colorSchemeSegmentedControl = UISegmentedControl(items: colorSchemes)
        colorSchemeSegmentedControl.selectedSegmentIndex = DemoSettings.colorSchemeSetting.rawValue
        colorSchemeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        colorSchemeSegmentedControl.addTarget(self, action: #selector(tappedColorSchemeSegmentedControl(_:)), for: .valueChanged)
        view.addSubview(colorSchemeSegmentedControl)
        
        updatePaymentMethodConstraints()
        fetchPaymentMethods()
    }
    
    func fetchPaymentMethods() {
        progressBlock?("Fetching customer's payment methods...")
        useApplePay = false
        
        BTDropInResult.fetch(forAuthorization: authorization) { (result, error) in
            guard let result = result, error == nil else {
                self.progressBlock?("Error: \(error!.localizedDescription)")
                print("Error: \(error!)")
                return
            }
            
            self.progressBlock?("Ready for checkout...")
            if result.paymentOptionType == .applePay {
                self.setupApplePay()
            } else {
                self.useApplePay = false
                self.selectedNonce = result.paymentMethod
                self.updatePaymentMethodNonce(self.selectedNonce)
            }
        }
    }
    
    func setupApplePay() {
        paymentMethodTypeLabel.isHidden = false
        paymentMethodTypeIcon.isHidden = false
        paymentMethodTypeIcon.paymentOptionType = .applePay
        paymentMethodTypeLabel.text = NSLocalizedString("Apple Pay", comment: "")
        
        useApplePay = true
        updatePaymentMethodConstraints()
    }
    
    // MARK: - Constraints
    
    func updatePaymentMethodConstraints() {
        NSLayoutConstraint.deactivate(checkoutConstraints)
        
        let viewBindings: [String : Any] = [
            "view": self,
            "cartLabel": cartLabel,
            "itemLabel": itemLabel,
            "priceLabel": priceLabel,
            "paymentMethodHeaderLabel": paymentMethodHeaderLabel,
            "dropInButton": dropInButton,
            "paymentMethodTypeIcon": paymentMethodTypeIcon,
            "paymentMethodTypeLabel": paymentMethodTypeLabel,
            "purchaseButton":purchaseButton,
            "colorSchemeLabel": colorSchemeLabel,
            "colorSchemeSegmentedControl":colorSchemeSegmentedControl
        ]
        
        var newConstraints: [NSLayoutConstraint] = []

        newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[cartLabel]-|", options: .alignAllLeft, metrics: nil, views: viewBindings)
        newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[purchaseButton]-|", options: .alignAllLeft, metrics: nil, views: viewBindings)
        newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(20)-[cartLabel]-[itemLabel]-[paymentMethodHeaderLabel]", options: .alignAllLeft, metrics: nil, views: viewBindings)
        newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[itemLabel]-[priceLabel]-|", options: .alignAllTop, metrics: nil, views: viewBindings)
        newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[paymentMethodHeaderLabel]-|", options: .alignAllLeft, metrics: nil, views: viewBindings)
        newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[colorSchemeLabel]-|", options: .alignAllLeft, metrics: nil, views: viewBindings)
        
        if !paymentMethodTypeIcon.isHidden && !paymentMethodTypeLabel.isHidden {
            newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[paymentMethodHeaderLabel]-[paymentMethodTypeIcon(29)]-[dropInButton]", options: .alignAllLeft, metrics: nil, views: viewBindings)
            newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[paymentMethodTypeIcon(45)]-[paymentMethodTypeLabel]", options: .alignAllCenterY, metrics: nil, views: viewBindings)
            newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[dropInButton]-|", options: .alignAllLeft, metrics: nil, views: viewBindings)
            
            dropInButton.setTitle(NSLocalizedString("Change Payment Method", comment: ""), for: .normal)
            purchaseButton.backgroundColor = view.tintColor
            purchaseButton.isEnabled = true
        } else {
            newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[paymentMethodHeaderLabel]-[dropInButton]", options: .alignAllLeft, metrics: nil, views: viewBindings)
            newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[dropInButton]-|", options: .alignAllLeft, metrics: nil, views: viewBindings)
            
            dropInButton.setTitle(NSLocalizedString("Add Payment Method", comment: ""), for: .normal)
            purchaseButton.backgroundColor = secondaryLabelColor
            purchaseButton.isEnabled = false
        }
        
        newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[dropInButton]-(20)-[purchaseButton]-(20)-[colorSchemeLabel]-[colorSchemeSegmentedControl]", options: .alignAllLeft, metrics:nil, views: viewBindings)
        newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[colorSchemeSegmentedControl]-|", options: .alignAllLeft, metrics:nil, views: viewBindings)
        
        checkoutConstraints = newConstraints
        view.addConstraints(checkoutConstraints)
    }
    
    // MARK: - Button Handlers
    
    @objc func tappedColorSchemeSegmentedControl(_ segmentedControl: UISegmentedControl) {
        DemoSettings.colorSchemeSetting = BTUIKColorScheme(rawValue: segmentedControl.selectedSegmentIndex)!
    }
    
    @objc func purchaseButtonPressed() {
        if useApplePay {
            guard let merchantIdentifier = DemoSettings.applePayMerchantIdentifier else {
                progressBlock?("Direct Apple Pay integration does not support custom environments in this Demo App")
                return
            }
            
            let paymentRequest = PKPaymentRequest()
            paymentRequest.paymentSummaryItems = [PKPaymentSummaryItem(label: "Socks", amount: 10.00)]
            paymentRequest.supportedNetworks = [.visa, .masterCard, .amex, .discover]
            paymentRequest.merchantCapabilities = .capability3DS
            paymentRequest.currencyCode = "USD"
            paymentRequest.countryCode = "US"
            paymentRequest.merchantIdentifier = merchantIdentifier
            
            guard let applePayController = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest) else {
                progressBlock?("Unable to initialize PKPaymentAuthorizationViewController")
                return
            }
            applePayController.delegate = self
            
            progressBlock?("Presenting Apple Pay Sheet")
            present(applePayController, animated: true)
        } else if DemoSettings.threeDSecureRequiredStatus == .required && nonceRequiresThreeDSecureVerification(selectedNonce) {
            performThreeDSecureVerification()
        } else {
            completionBlock?(self.selectedNonce)
            transactionBlock?()
        }
    }
    
    @objc func tappedToShowDropIn() {
        BTUIKAppearance.sharedInstance()?.colorScheme = DemoSettings.colorSchemeSetting
        
        let dropInRequest = BTDropInRequest()
        dropInRequest.vaultManager = !ProcessInfo.processInfo.arguments.contains("-DisableEditMode")
        BTUIKLocalizedString.setCustomTranslations(["cs"])
        
        dropInRequest.paypalDisabled = DemoSettings.paypalDisabled
        dropInRequest.venmoDisabled = DemoSettings.venmoDisabled
        dropInRequest.cardDisabled = ProcessInfo.processInfo.arguments.contains("-CardDisabled")
        dropInRequest.shouldMaskSecurityCode = DemoSettings.maskSecurityCode
        dropInRequest.cardholderNameSetting = DemoSettings.cardholderNameSetting
        dropInRequest.vaultCard = DemoSettings.vaultCardSetting
        dropInRequest.allowVaultCardOverride = DemoSettings.allowVaultCardOverrideSetting
        
        if ProcessInfo.processInfo.arguments.contains("-PayPalOneTime") {
            dropInRequest.payPalRequest = BTPayPalRequest(amount: "4.77")
        }
        
        if DemoSettings.threeDSecureRequiredStatus == .required {
            let billingAddress = BTThreeDSecurePostalAddress()
            billingAddress.givenName = "Jill"
            billingAddress.surname = "Doe"
            billingAddress.streetAddress = "555 Smith St."
            billingAddress.extendedAddress = "#5"
            billingAddress.locality = "Oakland"
            billingAddress.region = "CA"
            billingAddress.countryCodeAlpha2 = "US"
            billingAddress.postalCode = "12345"
            billingAddress.phoneNumber = "8101234567"
            
            let threeDSecureRequest = BTThreeDSecureRequest()
            threeDSecureRequest.amount = 10.32
            threeDSecureRequest.versionRequested = DemoSettings.threeDSecureRequestedVersion
            threeDSecureRequest.email = "test@example.com"
            threeDSecureRequest.shippingMethod = "01"
            threeDSecureRequest.billingAddress = billingAddress
            
            dropInRequest.threeDSecureVerification = true
            dropInRequest.threeDSecureRequest = threeDSecureRequest
        }
        
        let dropInController = BTDropInController(authorization: authorization, request: dropInRequest) { (dropInController, result, error) in
            guard let result = result, error == nil else {
                self.progressBlock?("Error: \(error!.localizedDescription)")
                print("Error: \(error!)")
                return
            }
            
            if result.isCancelled {
                self.progressBlock?("Cancelled🎲")
            } else if result.paymentOptionType == .applePay {
                self.progressBlock?("Ready for checkout...")
                self.setupApplePay()
            } else {
                self.useApplePay = false
                self.selectedNonce = result.paymentMethod
                self.progressBlock?("Ready for checkout...")
                self.updatePaymentMethodNonce(result.paymentMethod)
            }
            
            print(dropInController)
            dropInController.dismiss(animated: true, completion: nil)
        }
        
        guard let dropIn = dropInController else {
            progressBlock?("Unable to initialize BTDropInController")
            return
        }
        
        present(dropIn, animated: true, completion: nil)
    }
    
    // MARK: - ThreeDSecure Verification
    
        
    func performThreeDSecureVerification() {
        guard let apiClient = BTAPIClient(authorization: authorization) else { return }
        guard let nonce = selectedNonce?.nonce else { return }
        
        let threeDSecureRequest = BTThreeDSecureRequest()
        threeDSecureRequest.amount = 10.00
        threeDSecureRequest.nonce = nonce

        let paymentFlowDriver = BTPaymentFlowDriver(apiClient: apiClient)
        paymentFlowDriver.viewControllerPresentingDelegate = self
        
        paymentFlowDriver.startPaymentFlow(threeDSecureRequest) { (result, error) in
            self.selectedNonce = nil
            
            if let error = error {
                if (error as NSError).code == BTPaymentFlowDriverErrorType.canceled.rawValue {
                    // User cancelled 3DS flow and nonce was consumed
                    self.updatePaymentMethodNonce(self.selectedNonce)
                    self.fetchPaymentMethods()
                    return
                }
                
                // An error occurred and nonce was consumed
                self.updatePaymentMethodNonce(self.selectedNonce)
                self.fetchPaymentMethods()
                self.progressBlock?(error.localizedDescription)
                return
            }
        
            // TODO: - handle casting failure here?
            let threeDSecureResult = result as! BTThreeDSecureResult
            self.selectedNonce = threeDSecureResult.tokenizedCard
            self.updatePaymentMethodNonce(self.selectedNonce)
            
            self.completionBlock?(self.selectedNonce)
            self.transactionBlock?()
        }
    }
    
    // TODO: - inline this?
    func nonceRequiresThreeDSecureVerification(_ nonce: BTPaymentMethodNonce?) -> Bool {
        guard let cardNonce = nonce as? BTCardNonce else {
            return false
        }
        return !cardNonce.threeDSecureInfo.wasVerified
    }
}

// MARK: - PKPaymentAuthorizationControllerDelegate
extension DemoDropInViewController: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController,
                                            didSelect shippingMethod: PKShippingMethod,
                                            completion: @escaping (PKPaymentAuthorizationStatus, [PKPaymentSummaryItem]) -> Void) {
        let testItem = PKPaymentSummaryItem(label: "SOME ITEM", amount: 10.00)
        if shippingMethod.identifier == "fast" {
            completion(.success, [testItem,
                                  PKPaymentSummaryItem(label: "SHIPPING", amount: shippingMethod.amount),
                                  PKPaymentSummaryItem(label: "BRAINTREE", amount: testItem.amount.adding(shippingMethod.amount))])
        } else if shippingMethod.identifier == "fail" {
            completion(.failure, [testItem])
        } else {
            completion(.success, [testItem])
        }
    }
    
    @available(iOS 11.0, *)
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController,
                                            didAuthorizePayment payment: PKPayment,
                                            handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        progressBlock?("Apple Pay Did Authorize Payment")
        guard let apiClient = BTAPIClient(authorization: authorization) else { return }
        let applePayClient = BTApplePayClient(apiClient: apiClient)
        
        applePayClient.tokenizeApplePay(payment) { (tokenizedPaymentMethod, error) in
            guard let paymentMethod = tokenizedPaymentMethod, error == nil else {
                self.progressBlock?(error!.localizedDescription)
                completion(PKPaymentAuthorizationResult(status: .failure, errors: nil))
                return
            }
            
            self.completionBlock?(paymentMethod)
            completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
        }
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController,
                                            didAuthorizePayment payment: PKPayment,
                                            completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        progressBlock?("Apple Pay Did Authorize Payment")
        guard let apiClient = BTAPIClient(authorization: authorization) else { return }
        let applePayClient = BTApplePayClient(apiClient: apiClient)
        
        applePayClient.tokenizeApplePay(payment) { (tokenizedPaymentMethod, error) in
            guard let paymentMethod = tokenizedPaymentMethod, error == nil else {
                self.progressBlock?(error!.localizedDescription)
                completion(.failure)
                return
            }
            
            self.completionBlock?(paymentMethod)
            completion(.success)
        }
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func paymentAuthorizationViewControllerWillAuthorizePayment(_ controller: PKPaymentAuthorizationViewController) {
        progressBlock?("Apple Pay will Authorize Payment")
    }
}

// MARK: - BTViewControllerPresentingDelegate
extension DemoDropInViewController: BTViewControllerPresentingDelegate {
    func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
    
    func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
        dismiss(animated: true, completion: nil)
    }
}
