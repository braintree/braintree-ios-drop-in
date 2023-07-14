import UIKit
import InAppSettingsKit
import BraintreeDropIn

// TODO: we shouldn't need to do this? Or maybe we do? Idk.
import BraintreeCore

class DemoBaseViewController: UIViewController {
    
    var progressBlock: ((String?) -> Void)?
    var completionBlock: ((BTPaymentMethodNonce?) -> Void)?
    var transactionBlock: (() -> Void)?
    
    init(authorization: String) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
