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
        let request = BTDropInRequest()
        request.payPalRequest = BTPayPalCheckoutRequest(amount: "10.00")
        return BTDropInController(authorization: authorization, request: request, handler: handler)!
    }

    func updateUIViewController(_ uiViewController: BTDropInController, context: UIViewControllerRepresentableContext<DropInRepresentable>) {

    }
}
