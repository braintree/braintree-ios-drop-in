import Foundation

class DemoMerchantAPIClient {
    
    static let shared = DemoMerchantAPIClient()
    
    private init() {}
    
    func createCustomerAndFetchClientToken(completion: @escaping ((String?, Error?) -> Void)) {
        
        guard var urlComponents = URLComponents(string: DemoSettings.currentEnvironmentURLString + "/client_token") else { return }
        
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
    
    func makeTransaction(paymentMethodNonce: String, merchantAccountId: String? = nil, completion: @escaping ((String?, Error?) -> Void)) {
        NSLog("Creating a transaction with nonce: %@", paymentMethodNonce)
        
        guard var urlComponents = URLComponents(string: DemoSettings.currentEnvironmentURLString + "/nonce/transaction") else { return }
        
        var queryItems = [URLQueryItem(name: "nonce", value: paymentMethodNonce)]
        
        if (DemoSettings.threeDSecureRequiredStatus == .required) {
            queryItems += [URLQueryItem(name: "three_d_secure_required", value: "true")]
        } else if (DemoSettings.threeDSecureRequiredStatus == .optional) {
            queryItems += [URLQueryItem(name: "three_d_secure_required", value: "false")]
        }
        
        if let id = merchantAccountId {
            queryItems += [URLQueryItem(name: "merchant_account_id", value: id)]
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
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
