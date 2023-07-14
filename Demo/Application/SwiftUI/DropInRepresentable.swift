import SwiftUI
import BraintreeDropIn

// TODO: we shouldn't need to do this? Or maybe we do? Idk.
import BraintreePayPal

@available(iOS 13, *)
struct DropInRepresentable: UIViewControllerRepresentable {
    var authorization: String
    var handler: BTDropInControllerHandler

    init(authorization: String, handler: @escaping BTDropInControllerHandler) {
        self.authorization = authorization
        self.handler = handler
    }

    func makeUIViewController(context: Context) -> BTDropInController {
        let request = BTDropInRequest()
        request.payPalCheckoutRequest = BTPayPalCheckoutRequest(amount: "10.00")
        return BTDropInController(authorization: authorization, request: request, handler: handler)!
    }

    func updateUIViewController(_ uiViewController: BTDropInController, context: UIViewControllerRepresentableContext<DropInRepresentable>) {

    }
}
