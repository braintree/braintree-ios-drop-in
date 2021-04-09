import SwiftUI

@available(iOS 13, *)
struct ContentView: View {
    let tokenizationKey = "sandbox_9dbg82cq_dcpspy2brwdjr3qn"

    @State var showDropIn = false
    @State var message: String = "Select a payment method."

    var body: some View {
        ZStack {
            NavigationView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("CART")
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                    HStack {
                        Text("1 Sock")
                        Spacer()
                        Text("$10")
                    }
                    .padding(.horizontal, 20)
                    Button(action: { self.showDropIn = true }) {
                        HStack {
                            Spacer()
                            Text("Select Payment Method")
                                .fontWeight(.bold)
                                .font(.body)
                            Spacer()
                        }
                        .padding(.vertical, 12)
                        .foregroundColor(.white)
                        .background(Color.blue)
                    }
                    .padding(.top, 40)
                    .padding(.horizontal, 20)
                    Spacer()
                    ZStack {
                        Rectangle()
                            .frame(height: 80)
                            .foregroundColor(.gray)
                        Text(message)
                            .foregroundColor(.white)
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
            }

            if self.showDropIn {
                DropInRepresentable(authorization: tokenizationKey, handler: { controller, result, error in
                    if let error = error {
                        self.message = "Error: \(error.localizedDescription)"
                    } else if let result = result, result.isCanceled {
                        self.message = "Canceled 🎲"
                    } else {
                        self.message = "Ready for checkout..."
                    }
                    self.showDropIn = false
                }).edgesIgnoringSafeArea(.vertical)
            }
        }
    }
}

@available(iOS 13, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
