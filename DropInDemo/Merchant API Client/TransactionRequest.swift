import Foundation

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
