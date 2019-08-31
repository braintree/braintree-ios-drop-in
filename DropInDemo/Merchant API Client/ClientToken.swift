import Foundation

struct ClientToken: Codable {
    let value: String
    
    enum CodingKeys: String, CodingKey {
        case value = "client_token"
    }
}
