import UIKit
import PassKit

class DemoDropInViewController: DemoBaseViewController {
    
    private var demoView = DemoDropInView()
    
    private let authorization: String
    private var didSelectApplePay: Bool = false
    private var selectedNonce: BTPaymentMethodNonce?
    
    override init(authorization: String) {
        self.authorization = authorization
        super.init(authorization: authorization)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = demoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        demoView.setUpSubviews()
        demoView.updatePaymentMethodConstraints()
                
        demoView.dropInButton.addTarget(self, action: #selector(presentDropInController), for: .touchUpInside)
        demoView.purchaseButton.addTarget(self, action: #selector(completePurchase), for: .touchUpInside)
        demoView.colorSchemeSegmentedControl.addTarget(self, action: #selector(updateColorScheme(_:)), for: .valueChanged)
        
        fetchPaymentMethods()
    }
    
    // MARK: - Button Handlers
    
    @objc func presentDropInController() {
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
                self.progressBlock?("Ready for checkout...")
                self.didSelectApplePay = false
                self.selectedNonce = result.paymentMethod
                self.updatePaymentMethodNonce(result.paymentMethod)
            }
            
            dropInController.dismiss(animated: true, completion: nil)
        }
        
        guard let dropIn = dropInController else {
            progressBlock?("Unable to initialize BTDropInController")
            return
        }
        
        present(dropIn, animated: true, completion: nil)
    }
    
    @objc func completePurchase() {
        if didSelectApplePay {
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
                progressBlock?("Unable to initialize PKPaymentAuthorizationViewController for Apple Pay")
                return
            }
            applePayController.delegate = self
            
            progressBlock?("Presenting Apple Pay Sheet")
            present(applePayController, animated: true)
        } else if DemoSettings.threeDSecureRequiredStatus == .required, (selectedNonce as? BTCardNonce)?.threeDSecureInfo.wasVerified == false {
            performThreeDSecureVerification()
        } else {
            completionBlock?(self.selectedNonce)
            transactionBlock?()
        }
    }
    
    @objc func updateColorScheme(_ segmentedControl: UISegmentedControl) {
        DemoSettings.colorSchemeSetting = BTUIKColorScheme(rawValue: segmentedControl.selectedSegmentIndex)!
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
                } else {
                    // An error occurred and nonce was consumed
                }
                self.updatePaymentMethodNonce(nil)
                self.fetchPaymentMethods()
                self.progressBlock?(error.localizedDescription)
                return
            }
        
            if let threeDSecureResult = result as? BTThreeDSecureResult {
                self.selectedNonce = threeDSecureResult.tokenizedCard
                self.updatePaymentMethodNonce(self.selectedNonce)
                self.completionBlock?(self.selectedNonce)
                self.transactionBlock?()
            }
        }
    }
    
    // MARK: - Helper Methods
    
    func updatePaymentMethodNonce(_ nonce: BTPaymentMethodNonce?) {
        demoView.paymentMethodTypeLabel.isHidden = (nonce == nil)
        demoView.paymentMethodTypeIcon.isHidden = (nonce == nil)
        if let nonce = nonce {
            let paymentMethodType = BTUIKViewUtil.paymentOptionType(forPaymentInfoType: nonce.type)
            demoView.paymentMethodTypeIcon.paymentOptionType = paymentMethodType
            demoView.paymentMethodTypeLabel.text = nonce.localizedDescription
        }
        demoView.updatePaymentMethodConstraints()
    }
    
    func fetchPaymentMethods() {
        progressBlock?("Fetching customer's payment methods...")
        didSelectApplePay = false
        
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
                self.didSelectApplePay = false
                self.selectedNonce = result.paymentMethod
                self.updatePaymentMethodNonce(self.selectedNonce)
            }
        }
    }
    
    func setupApplePay() {
        demoView.paymentMethodTypeLabel.isHidden = false
        demoView.paymentMethodTypeIcon.isHidden = false
        demoView.paymentMethodTypeIcon.paymentOptionType = .applePay
        demoView.paymentMethodTypeLabel.text = NSLocalizedString("Apple Pay", comment: "")
        
        didSelectApplePay = true
        demoView.updatePaymentMethodConstraints()
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
