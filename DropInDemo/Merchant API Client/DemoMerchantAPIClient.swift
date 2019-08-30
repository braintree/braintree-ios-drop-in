//
//  DemoMerchantAPIClient.swift
//  DropInDemo
//
//  Created by Stevens, Susan on 8/30/19.
//  Copyright © 2019 Braintree Payments Solution, LLC. All rights reserved.
//

import Foundation

struct ClientToken: Codable {
    let value: String
    
    enum CodingKeys: String, CodingKey {
        case value = "client_token"
    }
}

struct TransactionRequest: Codable {
    let nonce: String
    let threeDSecureRequired: Bool?
    let merchantAccountId: String?
    
    enum CodingKeys: String, CodingKey {
        case nonce
        case threeDSecureRequired = "three_d_secure_required"
        case merchantAccountId = "merchant_account_id"
    }
}

struct TransactionResponse: Codable {
    let message: String
}

@objc
class DemoMerchantAPIClient: NSObject {
    
    @objc
    static let shared = DemoMerchantAPIClient()
    
    @objc
    func createCustomerAndFetchClientToken(completion: @escaping ((String?, Error?) -> Void)) {
        
        guard var urlComponents = URLComponents(string: BraintreeDemoSettings.currentEnvironmentURLString() + "/clientToken") else { return }
        
        if BraintreeDemoSettings.customerPresent() {
            if let id = BraintreeDemoSettings.customerIdentifier(), id.count > 0 {
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
        
        guard let url = URL(string: BraintreeDemoSettings.currentEnvironmentURLString() + "/nonce/transaction") else { return }
        
        let threeDSecureRequired: Bool?
        switch (BraintreeDemoSettings.threeDSecureRequiredStatus()) {
        case .default:
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
