import UIKit
import BraintreeDropIn

class ViewController: UIViewController {

    @IBAction func didTapLaunchDropIn(_ sender: UIButton) {
        let dropInController = BTDropInController(authorization: "sandbox_9dbg82cq_dcpspy2brwdjr3qn", request: BTDropInRequest()) { (controller, result, error) in

            if let err = error {
                print(err.localizedDescription)
            } else if let paymentMethod = result?.paymentMethod {
                print(paymentMethod.nonce)
            }

            controller.dismiss(animated: true)
        }

        present(dropInController!, animated: true)
    }
}
