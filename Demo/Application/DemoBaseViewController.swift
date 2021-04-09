import UIKit
import InAppSettingsKit
import BraintreeDropIn

class DemoBaseViewController: UIViewController {
    
    var progressBlock: ((String?) -> Void)?
    var completionBlock: ((BTPaymentMethodNonce?) -> Void)?
    var transactionBlock: (() -> Void)?
    
    required init(authorization: String) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
