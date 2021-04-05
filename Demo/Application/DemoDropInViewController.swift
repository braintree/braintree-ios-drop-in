import UIKit
import PassKit
import BraintreeDropIn

class DemoDropInViewController: DemoBaseViewController, DemoDropInViewDelegate {
    
    private var demoView = DemoDropInView()
    
    private let authorization: String
    private var didSelectApplePay: Bool = false
    private var selectedNonce: BTPaymentMethodNonce?
    
    override init(authorization: String) {
        self.authorization = authorization
        super.init(authorization: authorization)
        self.title = NSLocalizedString("Checkout", comment: "")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = demoView
        demoView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !DemoSettings.useTokenizationKey {
            fetchPaymentMethods()
        }
    }
    
    // MARK: - DemoDropInViewDelegate
    
    func demoViewDidTapDropInButton(_ view: DemoDropInView) {
        let uiCustomization = BTDropInUICustomization(colorScheme: DemoSettings.colorSchemeSetting)
        
        let dropInRequest = BTDropInRequest()
        dropInRequest.uiCustomization = uiCustomization
        dropInRequest.vaultManager = !ProcessInfo.processInfo.arguments.contains("-DisableEditMode")
        BTDropInLocalization.setCustomTranslations(["cs"])
        
        dropInRequest.paypalDisabled = DemoSettings.paypalDisabled
        dropInRequest.cardDisabled = ProcessInfo.processInfo.arguments.contains("-CardDisabled")
        dropInRequest.shouldMaskSecurityCode = DemoSettings.maskSecurityCode
        dropInRequest.cardholderNameSetting = DemoSettings.cardholderNameSetting
        dropInRequest.vaultCard = DemoSettings.vaultCardSetting
        dropInRequest.allowVaultCardOverride = DemoSettings.allowVaultCardOverrideSetting
        
        if ProcessInfo.processInfo.arguments.contains("-PayPalOneTime") {
            dropInRequest.payPalRequest = BTPayPalCheckoutRequest(amount: "4.77")
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
            threeDSecureRequest.shippingMethod = .sameDay
            threeDSecureRequest.billingAddress = billingAddress
            dropInRequest.threeDSecureRequest = threeDSecureRequest
        }
        
        let dropInController = BTDropInController(authorization: authorization, request: dropInRequest) { (dropInController, result, error) in
            guard let result = result, error == nil else {
                self.progressBlock?("Error: \(error!.localizedDescription)")
                print("Error: \(error!)")
                return
            }
            
            if result.isCanceled {
                self.progressBlock?("Canceled 🎲")
            } else {
                self.didSelectApplePay = (result.paymentMethodType == .applePay)
                self.progressBlock?("Ready for checkout...")
                self.selectedNonce = result.paymentMethod
                self.demoView.result = result
            }
            
            dropInController.dismiss(animated: true, completion: nil)
        }
        
        guard let dropIn = dropInController else {
            progressBlock?("Unable to initialize BTDropInController")
            return
        }
        
        present(dropIn, animated: true, completion: nil)
    }
    
    func demoViewDidTapPurchaseButton(_ view: DemoDropInView) {
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
        } else {
            completionBlock?(self.selectedNonce)
            transactionBlock?()
        }
    }
    
    // MARK: - Helper Methods
    
    func fetchPaymentMethods() {
        progressBlock?("Fetching customer's payment methods...")
        didSelectApplePay = false

        BTDropInResult.mostRecentPaymentMethod(forClientToken: authorization) { result, error in
            guard error == nil else {
                self.progressBlock?("Error: \(error!.localizedDescription)")
                print("Error: \(error!)")
                return
            }

            guard let result = result else {
                self.progressBlock?("No vaulted payment methods")
                print("No vaulted payment methods")
                return
            }
            
            self.progressBlock?("Ready for checkout...")
            self.didSelectApplePay = (result.paymentMethodType == .applePay)
            self.selectedNonce = result.paymentMethod
            self.demoView.result = result
        }
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
