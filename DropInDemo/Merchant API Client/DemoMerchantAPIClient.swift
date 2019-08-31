import Foundation

@objc
class DemoMerchantAPIClient: NSObject {
    
    @objc
    static let shared = DemoMerchantAPIClient()
    
    @objc
    func createCustomerAndFetchClientToken(completion: @escaping ((String?, Error?) -> Void)) {
        
        guard var urlComponents = URLComponents(string: DemoSettings.currentEnvironmentURLString + "/clientToken") else { return }
        
        if DemoSettings.customerPresent {
            if let id = DemoSettings.customerIdentifier, id.count > 0 {
                urlComponents.queryItems = [URLQueryItem(name: "customer_id", value: id)]
            } else {
                urlComponents.queryItems = [URLQueryItem(name: "customer_id", value: UUID().uuidString)]
            }
        }
        
        let task = URLSession.shared.dataTask(with: urlComponents.url!) { (data, response, error) in
            guard let data = data, error == nil else {
                DispatchQueue.main.async { completion(nil, error) }
                return
            }
            
            let clientToken = try? JSONDecoder().decode(ClientToken.self, from: data).value
            DispatchQueue.main.async { completion(clientToken, nil) }
        }
        
        task.resume()
    }
    
    @objc
    func makeTransaction(paymentMethodNonce: String, merchantAccountId: String? = nil, completion: @escaping ((String?, Error?) -> Void)) {
        NSLog("Creating a transaction with nonce: %@", paymentMethodNonce)
        
        guard let url = URL(string: DemoSettings.currentEnvironmentURLString + "/nonce/transaction") else { return }
        
        let threeDSecureRequired: Bool?
        switch (DemoSettings.threeDSecureRequiredStatus) {
        case .requiredIfPresent:
            threeDSecureRequired = nil
        case .required:
            threeDSecureRequired = true
        case .notRequired:
            threeDSecureRequired = false
        @unknown default:
            threeDSecureRequired = nil
        }
        
        let transaction = TransactionRequest(nonce: paymentMethodNonce,
                                             threeDSecureRequired: threeDSecureRequired,
                                             merchantAccountId: merchantAccountId)
        
        var request = URLRequest(url: url)
        request.httpBody = try? JSONEncoder().encode(transaction)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                DispatchQueue.main.async { completion(nil, error) }
                return
            }
            
            let message = try? JSONDecoder().decode(TransactionResponse.self, from: data).message
            DispatchQueue.main.async { completion(message, nil) }
        }
        
        task.resume()
    }
}
