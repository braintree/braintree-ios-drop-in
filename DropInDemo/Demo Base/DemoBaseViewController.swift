import UIKit

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
