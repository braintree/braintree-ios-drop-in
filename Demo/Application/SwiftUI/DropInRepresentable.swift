import SwiftUI
import BraintreeDropIn

@available(iOS 13, *)
struct DropInRepresentable: UIViewControllerRepresentable {
    var authorization: String
    var handler: BTDropInControllerHandler

    init(authorization: String, handler: @escaping BTDropInControllerHandler) {
        self.authorization = authorization
        self.handler = handler
    }

    func makeUIViewController(context: Context) -> BTDropInController {
        let payPalRequest = BTPayPalCheckoutRequest(amount: "10.00")

        let request = BTDropInRequest()
        request.payPalRequest = payPalRequest
        request.applePayDisabled = true

        let dropInController = BTDropInController(authorization: authorization, request: request, handler: handler)!
        return dropInController
    }

    func updateUIViewController(_ uiViewController: BTDropInController, context: UIViewControllerRepresentableContext<DropInRepresentable>) {

    }
}
